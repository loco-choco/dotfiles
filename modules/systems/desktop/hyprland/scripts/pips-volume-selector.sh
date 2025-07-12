#!/bin/sh
max_volume=150
pips_steps=10

if [[ -z $1 ]] 
then
  # no arguments passed, exiting
  exit
elif [[ $1 == "raise" ]]
then
  wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
elif [[ $1 == "lower" ]]
then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
elif [[ $1 == "mute" ]]
then
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
fi # if neither, just send the notification to dunst

#wpctl output parsinh
#from https://gist.github.com/schauveau/b5a2d20c98e6bea8c8cd50410ff01253
INPUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
while read LINE ; do
#
# The output of wpctl is of the form
#   Volume: AAAAA.BB
# or
#   Volume: AAAAA.BB [MUTED]
#
# Where A and B are sequences of digits.
#  --> B is always of length 2 and A is often of length 1.
#      However, Pipewire can set the volume to more than 100%
#      so A may be bigger. 
#
  if [[ "$LINE" =~ ^Volume:.([0-9]+)\.([0-9]{2})(([[:blank:]]\[MUTED\])?)$ ]] ; then
    # Bash stores the parts of the matched regular expression in BASH_REMATCH
    # 
    # [0] = the whole match
    # [1] = the AAAAA part
    # [2] = the BB part
    # [3] = the MUTED part when found 
    
    current_volume=$(( 10#${BASH_REMATCH[1]}${BASH_REMATCH[2]} ))
    if [[ -n "${BASH_REMATCH[3]}" ]] ; then
      is_muted="yes"
    else
      is_muted="no"
    fi
  else
    echo "Warning: Failed to match output of wpctl: '$LINE'" >&2
  exit
  fi
done <<<"$INPUT"
#current_volume=$( wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/.* //' | sed -e 's/\.//g' )

notification_string="Volume:"
current_pips=$(expr $current_volume / $pips_steps - 1)
current_half_pips=$(expr $current_volume % $pips_steps)
echo $current_half_pips
max_pips=$(expr $max_volume / $pips_steps)
one_hundred_percent_pips=$(expr 100 / $pips_steps)

# create pips progress bar
for ((i = 0 ; i < max_pips ; i++)); do
  if [[ $i -le $current_pips ]]
  then
    if [[ $is_muted == "no" ]]
    then
      notification_string="${notification_string} "
    else
      notification_string="${notification_string} "
    fi
  else
    notification_string="${notification_string} "
  fi
  if [[ $i -eq $one_hundred_percent_pips ]]
  then
    notification_string="${notification_string} |"
  fi
done
# send notification to dunst
dunstify -a "changeVolume" -u low -h string:x-dunst-stack-tag:pips-volume "${notification_string}" 
