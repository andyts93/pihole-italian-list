#!/bin/bash

wget -O - https://raw.githubusercontent.com/disconnectme/disconnect/b27abbf033c6f80f157fe9d98cb767c87065fbf4/firefox/content/disconnect.safariextension/opera/chrome/scripts/data.js > list.txt
wget -O - https://easylist-downloads.adblockplus.org/easylist.txt >> list.txt
wget -O - https://easylist-downloads.adblockplus.org/easylistitaly.txt >> list.txt
wget -O - https://easylist-downloads.adblockplus.org/easyprivacy.txt >> list.txt
wget -O - https://easylist-downloads.adblockplus.org/antiadblockfilters.txt >> list.txt
wget -O - https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt >> list.txt
wget -O - https://easylist-downloads.adblockplus.org/fanboy-social.txt >> list.txt
wget -O - http://winhelp2002.mvps.org/hosts.txt >> list.txt
wget -O - http://hosts-file.net/ad_servers.asp >> list.txt
wget -O - http://someonewhocares.org/hosts/hosts >> list.txt
wget -O - https://easylist-downloads.adblockplus.org/malwaredomains_full.txt >> list.txt
wget -O - https://raw.githubusercontent.com/gioxx/xfiles/master/filtri.txt >> list.txt
wget -O - https://filtri-dns.ga/filtri.txt >> list.txt
wget -O - https://gitcdn.xyz/cdn/gioxx/xfiles/bbcbbbeaca2449f7f977e65c4363ca9efd970ec3/filtri.txt >> list.txt

sed -e '/^0.0.0.0/!d' -e '/localhost/d' -e 's/0.0.0.0//' -e 's/ \+/\t/' -e 's/#.*$//' -e 's/[ \t]*$//' < list.txt | sort -u > list2.txt
cat list2.txt | tr -d " \t" | uniq > adlist.txt
rm -rf list.txt list2.txt

totalFilters=`cat adlist.txt| wc -l`

echo "
#------------------------------------[UPDATE]--------------------------------------
# Title: Italian AD list for pihole
# Expires: 1 day
# Homepage: https://github.com/andyts93/pihole-italian-list
# Help: https://github.com/andyts93/pihole-italian-list/issues
# License: MIT
# Total number of network filters: $totalFilters
#------------------------------------[SUPPORT]-------------------------------------
# You can support by:
# - reporting false positives
#-------------------------------------[INFO]---------------------------------------
#
# Italian AD list
#------------------------------------[FILTERS]-------------------------------------" > adlist_pluggable.txt

sed -e 's/^/0.0.0.0 /' adlist.txt >> adlist_pluggable.txt