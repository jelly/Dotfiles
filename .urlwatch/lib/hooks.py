from BeautifulSoup import BeautifulSoup

# Additional modules installed with urlwatch
from urlwatch import ical2txt
from urlwatch import html2txt

from BeautifulSoup import BeautifulSoup

def filter(url, data):
        if 'github' in url:
                soup = BeautifulSoup(data)

                if soup.find('span', {'class': 'tag-name'}):
                        return str(soup.find('span', {'class': 'tag-name'}))
                elif soup.find('h1', {'class': 'release-title'}):
                        return str(soup.find('h1', {'class': 'release-title'}))
                else:
                        return data
        else:
                return data



'''
def filter(url, data):
    if 'github' in url:
        soup = BeautifulSoup(data)
        print 'github ', url
        print str(soup.find('div', {'class': 'main'}))
        return str(soup.find('div', {'class': 'main'}))
    else:
        return data
'''
