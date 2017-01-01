#!/usr/bin/python

import sys
import subprocess
from email.parser import Parser

import requests


def open_marc_info(message_id):
    url = 'http://marc.info/?i={}'.format(message_id)
    r = requests.get(url)
    if r.status_code == 200:
        subprocess.call(['xdg-open', url], stdout=subprocess.DEVNULL)
    return False


def open_gmane(message_id):
    url = 'http://mid.gmane.org/{}'.format(message_id)
    r = requests.get(url)
    if b'NOT FOUND' not in r.content:
        subprocess.call(['xdg-open', url], stdout=subprocess.DEVNULL)
        return True
    return False


if __name__ == "__main__":
    eml = ''
    for line in sys.stdin:
        eml += line
    headers = Parser().parsestr(eml)
    if headers['message-id']:
        message_id = headers['message-id']
        if not open_marc_info(message_id):
            open_gmane(message_id)
