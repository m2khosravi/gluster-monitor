#!/bin/bash
#
# Script Name: gstat.sh
#
# Author: Mahdi khosravi
# Date: 2019/10/30
#
# Error Log: Any errors or output associated with the script can be found in /path/to/logfile

### Online Volume param cheak
#stat=`gluster volume status $@ detail | awk '{print $3}' |grep Y` 
#for arg in "$@"
#	do
#stat=`gluster volume status $arg detail | awk '{print $3}' |grep Y` 
#	  if [ "$stat" != "Y" ] ;
#           then
#      	echo $arg is not Online
#	     else
#		echo $arg is Online
#        fi
#done
### Host status Cheak        
for i in "$@"
	do
stat=`gluster pool list | grep $i | awk '{print $3}' ` 
	  if [ "$stat" == "Connected" ] ;
             then
        	echo $i is Connect
	     else
		echo $i is Dis
          fi
done

exec 1>>/var/log/gstatoutput.log
exec 2>>/var/log/gstaterror.log##
