#!/bin/bash
for ip in $(cat ip_FTP)
do
  echo 'Working on '$ip
  sslscan --starttls-ftp $ip:21 >> results.txt 2>> error.txt
done
echo 'Removing color char and parsing'
sed -i.bak 's/\x1b\[[0-9;]*m//g' results.txt
python parse_results.py
echo 'Done'
