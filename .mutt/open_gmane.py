#!/usr/bin/python

# Simple script to open a GMANE URL.

import sys
import os
import subprocess

from email.parser import Parser

BASE_URL = 'http://mid.gmane.org/'

if __name__ == "__main__":
    eml = ''
    for line in sys.stdin:
        eml += line
    headers = Parser().parsestr(eml)
    if headers['message-id']:
        url = BASE_URL + headers['message-id']
        if sys.version_info > (3, 3):
            subprocess.call(['xdg-open', url], stdout=subprocess.DEVNULL)
        else:
            subprocess.call(['xdg-open', url], stdout=open(os.devnull))
