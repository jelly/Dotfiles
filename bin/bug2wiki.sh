#!/bin/sh
#
# just run it and enter one ID per line
#

while read bugid; do
  title="$(curl "https://bugs.archlinux.org/task/$bugid" 2>/dev/null |
    grep -A 1 "<h2 class=\"summary" |
    tail -n1 |
    sed -rn 's/\s*(FS#[0-9]*) - (.*)<\/h2>/\1] - \2/p')"
    if curl "http://wiki.archlinux.org/index.php/Bug_Day_TODO" 2>/dev/null| grep -q "FS#$bugid<"; then
      echo -e "\e[0;31m  !! Bug seems to be already on the TODO list\e[0m"
    fi
  echo "* [http://bugs.archlinux.org/task/$bugid $title"
  echo "* [http://bugs.archlinux.org/task/$bugid $title" | xclip
done
