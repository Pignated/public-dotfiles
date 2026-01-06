#!/usr/bin/env bash
audiostate=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
mutestate=$(if [[ $( echo "$audiostate" |  grep -oP '(?<=\[)[^\]]+(?=\])' ) || true == "MUTED" ]]; then echo "1"; else echo "0"; fi;)
volume=$( echo "$audiostate" | grep -oP '\d+.\d+' | awk '{printf "%.0f\n", $1 * 100}')
if [[ $mutestate == 1 ]];
	then echo "  $volume %"
	elif [ $volume -lt 30 ];
	then echo "󰕿 $volume %"
	elif [ $volume -lt 60 ];
	then echo "󰖀 $volume %"
	else echo "󰕾 $volume %"
fi




