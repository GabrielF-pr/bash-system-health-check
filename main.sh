#!/bin/bash

cpu_usage=$(vmstat 1 2 | awk 'NR==4 {print 100 - $15}')
if [ -z "$cpu_usage" ]; then
	echo "$(date) ERROR: failed to fetch CPU usage"	
else 
	if [ "$cpu_usage" -eq 100 ]; then
		echo "$(date) ALERT: Cpu usage too high"
	fi
fi

free_memory=$(free -m | awk '/Mem:/ {print $4}')
if [ -z "$free_memory" ]; then
	
	echo "$(date) ERROR: failed to fetch memory information"

else

	if [ "$free_memory" -lt 500 ]; then
		echo "$(date) ALERT: Low memory!"
	fi

fi

disk_space=$(df -B1 | awk 'NR==3 {print $4}')
if [ -z "$disk_space" ]; then

	echo "$(date) ERROR: failed to fetch disk space information"

else

	if [ "$disk_space" -lt 524288000 ]; then
		echo "$(date) ALERT: Low available space on disk!"
	fi

fi

echo "The system has been up for: $(uptime | awk -F'up' '{print $2}' | awk -F',' '{print $1}' | tr -d ' ')"
