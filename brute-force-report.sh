#!/bin/bash

# variables...
DATE=`date +"%m%d%y"`
NC='\033[0m' # No Color
G='\033[0;32m'

# begin report: /var/log/reports...
echo "--------------------------------------------------" > /var/log/reports/bf.$DATE\.log
echo "| Brute force and failed login report for $DATE |" >> /var/log/reports/bf.$DATE\.log
echo "--------------------------------------------------" >> /var/log/reports/bf.$DATE\.log
echo "" >> /var/log/reports/bf.$DATE\.log
echo "--------------------------------------------------" >> /var/log/reports/bf.$DATE\.log
echo "| Attempted usernames:                           |" >> /var/log/reports/bf.$DATE\.log
echo "--------------------------------------------------" >> /var/log/reports/bf.$DATE\.log
cat /var/log/secure | grep 'Failed' | awk '{print$11}' | sort | uniq -c | sort -rn >> /var/log/reports/bf.$DATE\.log
echo "--------------------------------------------------" >> /var/log/reports/bf.$DATE\.log
echo "" >> /var/log/reports/bf.$DATE\.log
echo "--------------------------------------------------" >> /var/log/reports/bf.$DATE\.log
echo "| List of IP addresses and IP information:       |" >> /var/log/reports/bf.$DATE\.log
echo "--------------------------------------------------" >> /var/log/reports/bf.$DATE\.log
for ip in `cat /var/log/secure | grep 'Failed' | awk '{print$13}' | sort -rn`; do echo "" >> /var/log/reports/bf.$DATE\.log &&  echo "$ip:" >> /var/log/reports/bf.$DATE\.log && whois $ip | grep -ie netname -e country >> /var/log/reports/bf.$DATE\.log && echo "" >> /var/log/reports/bf.$DATE\.log; done 
echo "--------------------------------------------------" >> /var/log/reports/bf.$DATE\.log
