#!/bin/bash

#fukaYOUchina!
TMP=/tmp
FILE=delegated-apnic-extended-latest
URL="ftp://ftp.apnic.net/pub/stats/apnic/"
COUNTRY='CN|HK'
cd $TMP
rm -f $FILE
echo "Downloading IP address information for "$COUNTRY"..."
wget -q $URL$FILE

# coversion array
prefix=("16:65536" "24:256" "17:32768" "18:16384" "19:8192" "20:4096" "21:2048" "22:1024" "23:512" "14:262144" "15:131072" "13:524288" "12:1048576" "12:2097152" "10:4194304")

echo "Adding IP address networks for "$COUNTRY" to iptables..."

iptables -F CNBAN
iptables -D INPUT -j CNBAN
iptables -X CNBAN
iptables -N CNBAN
iptables -A INPUT -j CNBAN

for i in `cat $FILE |grep ipv4 | egrep $COUNTRY`
do

    	for j in ${prefix[@]}
    	do
            	KEY=${j%%:*}
            	VALUE=${j##*:}
            	i=${i/$VALUE/$KEY}
    	done
    echo "Adding network... " $(echo $i|awk -F'|' '{print $4"/"$5}')
    	echo $i|awk -F'|' '{system("iptables -A CNBAN -s " $4"/"$5 " -j DROP");}'
done
echo "Complete."
