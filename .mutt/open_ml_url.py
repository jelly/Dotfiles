#!/usr/bin/python

import sys
import subprocess
from email.parser import Parser

import requests


URLS = ['https://www.mail-archive.com/search?l=mid&q={}', 'http://marc.info/?i={}', 'http://mid.gmane.org/{}']


if __name__ == "__main__":
    eml = ''
    for line in sys.stdin:
        eml += line
    headers = Parser().parsestr(eml)
    if 'message-id' in headers:
        for base_url in URLS:
            message_id = headers['message-id'].replace('<', '').replace('>', '')
            url = base_url.format(message_id)
            r = requests.get(url)
            if r.status_code == 200 and b'NOT FOUND' not in r.content:
                subprocess.call(['xdg-open', url], stdout=subprocess.DEVNULL)
                break
