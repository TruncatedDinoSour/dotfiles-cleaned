#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

df_check_location='/home'

dwm_resources () {
	# get all the infos first to avoid high resources usage
	free_output=$(free -h | grep Mem)
	df_output=$(df -h $df_check_location | tail -n 1)
	# Used and total memory
	MEMUSED=$(echo $free_output | awk '{print $3}')
	MEMTOT=$(echo $free_output | awk '{print $2}')
	# CPU temperature
	#CPU=$(top -bn1 | grep Cpu | awk '{print $2}')%
	#CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)
	# Used and total storage in /home (rounded to 1024B)
	#STOUSED=$(echo $df_output | awk '{print $3}' | head -c 2)
	#STOTOT=$(echo $df_output | awk '{print $2}' | head -c 3)
	STOPER=$(echo $df_output | awk '{print $4}')

	printf "%s" "$SEP1"
	if [ "$IDENTIFIER" = "unicode" ]; then
        printf "   %s/%s $SEP2  %s" "$MEMUSED" "$MEMTOT" "$STOPER"
    else
        printf "MEM %s/%s $SEP2 DSK %s" "$MEMUSED" "$MEMTOT" "$STOPER"
    fi
	printf "%s\n" " $SEP2"
}

dwm_resources
