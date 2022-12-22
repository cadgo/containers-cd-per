#!/bin/bash

HOSTS=""
COUNT=4
RUN="YES"
AUTOWAKE="no"
serverDown=0
if [[ $RUN == "YES" ]]
then
	for myHost in $HOSTS
	do
		count=$(ping -c $COUNT $myHost | grep 'received' | awk -F',' '{ print $2 }' | awk '{print $1}')
	    if [ $count -eq 0 ]; then
	        # 100% failed
	        echo "Server failed at $(date)" | ./mailwrapper.py "Server Down $myHost" "Rig $myHost down"
	        echo "Host : $myHost is down (ping failed) at $(date)"
		ServerDown=1
	    else
		ServerDown=0
	    fi
	done
fi

if [[ $AUTOWAKE == "YES" ]]; then
	if [[ $ServerDown -eq 1 ]]; then
		sleep 75	
		echo "Sending wakeonlan" >> tempfile
		./wakeonlan.sh
	fi
else
	echo "No Wake on lan"
fi

