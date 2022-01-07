#!/bin/sh

resourcemon () {
	free_output=$(free -h | grep Mem)
	MEMUSED=$(echo $free_output | awk '{print $3}')
	CPU=$(top -bn1 | grep Cpu | awk '{print $2}')%
		printf "   %s   %s" "${MEMUSED%?}" "$CPU"
}

volume () {
	printf "%s\n" "  墳 $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"
}

microphone(){
    is_mute=$(pactl get-source-mute $(pactl get-default-source))
    if [ "$is_mute" = "Mute: yes" ]; then
        echo "    0%  "
    else
        echo "   100%  "
    fi
}

dclock(){
        printf " %s  " "$(date "+%T")" 
}

ddate(){
        printf " %s  " "$(date "+%a %d-%m-%y")" 
}



#update loop
while true
do
    upperbar="$( resourcemon )"
    upperbar="$upperbar$( volume )"
    upperbar="$upperbar$( microphone )"
    upperbar="$upperbar$( dclock )"
    upperbar="$upperbar$( ddate )"
    xsetroot -name "$upperbar"
    sleep 1
done
