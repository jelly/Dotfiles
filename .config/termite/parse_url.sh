!#/usr/bin/bash 
url=$1
if [[ $url =~ "youtube" ]]; then
    mpv "$1"
else
    firefox "$1"
fi
