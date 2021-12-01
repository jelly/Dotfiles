curl -H "Host: www.nstrein.ns.nl" $(host www.nstrein.ns.nl | head -n 1 | grep -oE '[0-9.]{7,}')/?action=nstrein:main.internet >/dev/null
