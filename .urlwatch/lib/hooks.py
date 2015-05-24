from BeautifulSoup import BeautifulSoup

# Additional modules installed with urlwatch
from urlwatch import ical2txt
from urlwatch import html2txt

from BeautifulSoup import BeautifulSoup

def filter(url, data):
    if 'github' in url:
        soup = BeautifulSoup(data)

        tag = soup.find('span', {'class': 'tag-name'})
        if tag:
            return str(tag)

        tag = soup.find('h1', {'class': 'release-title'})
        if tag:
            return str(tag)

        tag = soup.find('div', {'class': 'site'})
        if tag:
            return str(tag)

    elif 'pypi.python.org' in url:
        soup = BeautifulSoup(data)

        tag = soup.find('table', {'class': 'list'})
        if tag:
            return str(tag)

    else:
        return data
