#!/bin/bash

source="/mnt/media/photos/dump"
target="/mnt/media/photos/"

find "$source" -type f -iname "*.*" | while read file ; do
   date=$(exiv2 "$file" 2> /dev/null | awk '/Image timestamp/ { print $4 }')
   [ -z "$date" ] && echo "$file" >> ~/error.txt && continue
   year=${date%%:*}
   month=${date%:*}
   month=${month#*:}
   day=${date##*:}
   mkdir -p "${target}/${year}"
   mkdir -p "${target}/${year}/${month}/${day}-${month}-${year}"
   mv "$file" "${target}/${year}/${month}/${day}-${month}-${year}"
done
