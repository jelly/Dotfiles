#!/usr/bin/env python2
import urllib2
import urllib
from BeautifulSoup import BeautifulSoup
import smtplib
import ConfigParser


# Retreive user information
config = ConfigParser.ConfigParser()
config.read('config.cfg')
user = config.get('data','user')
password = config.get('data','password')
fromaddr = config.get('data','fromaddr')
toaddr = config.get('data','toaddr')
smtpserver = config.get('data','smtp_server')
login_page='https://bugs.archlinux.org/index.php?do=authenticate'

# Create message
msg = "To: %s \nFrom: %s \nSubject: Bug Mail\n\n" % (toaddr,fromaddr)
msg += 'Unassigned bugs  \n\n'

# build opener with HTTPCookieProcessor
o = urllib2.build_opener( urllib2.HTTPCookieProcessor() )
urllib2.install_opener( o )

p = urllib.urlencode( { 'user_name': user, 'password': password, 'remember_login' : 'on',} )
f = o.open(login_page, p)
data = f.read()

# Archlinux
url = "https://bugs.archlinux.org/index.php?string=&project=1&search_name=&type%5B%5D=&sev%5B%5D=&pri%5B%5D=&due%5B%5D=0&reported%5B%5D=&cat%5B%5D=&status%5B%5D=1&percent%5B%5D=&opened=&dev=&closed=&duedatefrom=&duedateto=&changedfrom=&changedto=&openedfrom=&openedto=&closedfrom=&closedto=&do=index"

# Community
url2= "https://bugs.archlinux.org/index.php?string=&project=5&search_name=&type%5B%5D=&sev%5B%5D=&pri%5B%5D=&due%5B%5D=0&reported%5B%5D=&cat%5B%5D=&status%5B%5D=1&percent%5B%5D=&opened=&dev=&closed=&duedatefrom=&duedateto=&changedfrom=&changedto=&openedfrom=&openedto=&closedfrom=&closedto=&do=index"


def parse_bugtrackerpage(url,count=1):
    print url
    # open bugtracker / parse 
    page = urllib2.urlopen(url)
    soup =  BeautifulSoup(page)
    data = soup.findAll('td',{'class':'task_id'})
    msg = ""
    pages = False

    # Is there another page with unassigned bugs
    if soup.findAll('a',{'id': 'next' }) == []:
        page = False
    else:
        print soup.findAll('a',{'id': 'next'})
        count += 1
        pages = True

    print count

    # print all found bugs
    for f in data:
        title = f.a['title'].replace('Assigned |','')
        title = f.a['title'].replace('| 0%','')
        msg += '* [https://bugs.archlinux.org/task/%s FS#%s] %s \n' % (f.a.string,f.a.string,title)

    if pages == True:
        new = "%s&pagenum=%s" % (url,count)
        msg += parse_bugtrackerpage(new,count)

    return msg

msg += '\n\nArchlinux: \n\n'
msg += parse_bugtrackerpage(url)

msg += '\n\nCommunity: \n\n'
msg += parse_bugtrackerpage(url2)





msg = msg.encode("utf8")
# send mail
server = smtplib.SMTP(smtpserver)
server.sendmail(fromaddr, toaddr,msg)
server.quit()
