#!/usr/bin/python

# Simple script to open a GMANE URL.

import sys
import os
import subprocess

from email.parser import Parser

BROWSER = os.getenv('BROWSER', 'firefox')
URL = 'http://mid.gmane.org/'

if __name__ == "__main__":
    eml = ''
    for line in sys.stdin:
        eml += line
    headers = Parser().parsestr(eml)
    if headers['message-id']:
        subprocess.Popen(['xdg-open', URL + headers['message-id']])
