!#/usr/bin/bash 
url=$1
if [[ $url =~ "youtube" ]]; then
    mpv "$1"
else
    chromium "$1"
fi
