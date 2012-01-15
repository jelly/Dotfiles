#!/usr/bin/python 
import urllib2
import urllib
from BeautifulSoup import BeautifulSoup
import smtplib
import ConfigParser

# Script to send an email with bugs openend before a certian date. Usefull for keeping the tracker clean

# Retreive user information
config = ConfigParser.ConfigParser()
config.read('config.cfg')
user = config.get('data','user')
password = config.get('data','password')
fromaddr = config.get('data','fromaddr')
toaddr = config.get('data','toaddr')
smtpserver = config.get('data','smtp_server')
date = config.get('data','date')
login_page='https://bugs.archlinux.org/index.php?do=authenticate'

# Create message
msg = "To: %s \nFrom: %s \nSubject: Bug Mail\n\n" % (toaddr,fromaddr)
msg += 'Bugs open and opened before %s \n\n' % (date)


# build opener with HTTPCookieProcessor
o = urllib2.build_opener( urllib2.HTTPCookieProcessor() )
urllib2.install_opener( o )

p = urllib.urlencode( { 'user_name': user, 'password': password, 'remember_login' : 'on',
                #'return_to' : None,
} )
f = o.open(login_page, p)
data = f.read()

# Replace date
url = "https://bugs.archlinux.org/index.php?string=&project=1&search_name=&type%5B%5D=&sev%5B%5D=&pri%5B%5D=&due%5B%5D=&reported%5B%5D=&cat%5B%5D=&status%5B%5D=open&percent%5B%5D=&opened=&dev=&closed=&duedatefrom=&duedateto=&changedfrom=&changedto=&openedfrom=&openedto=bugdate&closedfrom=&closedto=&do=index" 
url = url.replace('bugdate',date)


url2 = "https://bugs.archlinux.org/index.php?string=&project=5&type%5B%5D=&sev%5B%5D=&pri%5B%5D=&due%5B%5D=&reported%5B%5D=&cat%5B%5D=&status%5B%5D=open&percent%5B%5D=&opened=&dev=&closed=&duedatefrom=&duedateto=&changedfrom=&changedto=&openedfrom=&openedto=bugdate&closedfrom=&closedto=&do=index"
url2 = url2.replace('bugdate',date)

def parse_bugtrackerpage(url):
    # open bugtracker / parse 
    page = urllib2.urlopen(url)
    soup =  BeautifulSoup(page)
    foo = soup.findAll('td',{'class':'task_id'})
    msg = ""

    # print all found bugs
    for f in foo:
        title = f.a['title'].replace('Assigned |','')
        title = f.a['title'].replace('| 0%','')
        msg += '* [https://bugs.archlinux.org/task/%s FS#%s] %s \n' % (f.a.string,f.a.string,title)
    return msg

msg += 'Archlinux: \n\n'
msg += parse_bugtrackerpage(url)
msg += '\n\nCommunity: \n\n'
msg += parse_bugtrackerpage(url2)


msg = msg.encode("utf8")
# send mail
server = smtplib.SMTP(smtpserver)
server.sendmail(fromaddr, toaddr,msg)
server.quit()
