#!/bin/bash
#
# Script Name: gstat.sh
#
# Author: Mahdi khosravi
# Mail:khosravi.mahdi73@gmail.com
# Date: 2019/10/30
#
# Error Log: Any errors or output associated with the script can be found in /path/to/logfile

### Online Volume param cheak
stat=`gluster volume status $1 detail | awk '{print $3}' |grep Y` 
if [ "$stat" != "Y" ] ;
        then
        echo $1 is not Online
	else
	echo $1 is Online
        fi
### Host status Cheak        
for peer in $(gluster peer status | grep '^Hostname: ' | awk '{print $2}'); do
  state=$(gluster peer status | grep -A 2 "$2  $peer$" | grep '^State: ' | sed -nre 's/.* \(([[:graph:]]+)\)$/\1/p')
  if [ "$state" != "Connected" ]; then
    exit 0
  fi
done

exec 1>>/var/log/gstatoutput.log
exec 2>>/var/log/gstaterror.log
