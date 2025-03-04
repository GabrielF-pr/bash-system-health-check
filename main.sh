#!/bin/bash

if [ "$(vmstat 1 2 | awk 'NR==4 {print 100 - $15}')" -eq 100 ]; then
	echo "$(date) ALERT: Cpu usage too high"
fi

if [ "$(free -m | awk '/Mem:/ {print $4}')" -lt 500 ]; then
	echo "$(date) ALERT: Low memory!"
fi

if [ "$(df -B1 | awk 'NR==3 {print $4}')" -lt 524288000 ]; then
	echo "$(date) ALERT: Low available space on disk!"
fi
