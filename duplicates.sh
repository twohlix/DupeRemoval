#!/bin/bash

#clear the md5 list and create a fresh one
echo "-|Clearing MD5 List"
rm raw.md5.list
echo "-|Creating new MD5 List"
find * -exec md5 {} \; >> raw.md5.list

#Find the duplicates
echo "-|Getting Duplicate MD5s"
cat raw.md5.list | cut -d \  -f 4  | sort | uniq -d > dupe.md5.list

#Get paths of duplicates
rm paths.dupes.list
cat dupe.md5.list | while read line;do
  grep "$line" raw.md5.list | cut -d \  -f 2 | sed 's/.\(.*\)/\1/' | sed '$s/.$//' >> paths.dupes.list;
  echo "" >> paths.dupes.list;
done
