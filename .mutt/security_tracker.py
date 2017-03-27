#!/usr/bin/python

import sys
import subprocess
import re
import requests


url_json = 'https://security.archlinux.org/{}/json'
url= 'https://security.archlinux.org/{}'


if __name__ == "__main__":
    matches = set(re.findall("CVE-\d{4}-\d*", sys.stdin.read()))
    for match in matches:
        r = requests.get(url_json.format(match))
        if r.status_code == 200:
            cve = r.json()
            groups = cve["groups"]
            print("=======")
            print(url.format(match))
            print("Packages: {}".format(" ".join(cve["packages"])))
            for group in groups:
                r = requests.get(url_json.format(group))
                if r.status_code == 200:
                    group = r.json()
                    print("Part of {}".format(group["name"]))
                    print(url.format(group["name"]))
                    print("Status: {}".format(group["status"]))
                    if 'advisories' in group:
                        for asa in group['advisories']:
                            print("Published as part of {}".format(asa))
                    else:
                        print("No published ASA for this CVE")
            print("=======")
        else:
            print("No CVE registered for: {}".format(match))
