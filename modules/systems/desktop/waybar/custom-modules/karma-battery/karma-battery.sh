#! /usr/bin/env sh
symbol_folder="/home/locochoco/.dotfiles/home/modules/hyprland/waybar/custom-modules/karma-battery"
battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)
if [[ -z $battery_capacity ]] 
then
  # no battery on this device, exiting
  exit
fi
battery_level=$(expr $battery_capacity / 10)

# add special wheel if charging/plugged
if [[ $battery_status != 'Discharging' ]]
then
  convert $symbol_folder/karmaRingReinforced.png $symbol_folder/karma$battery_level.png -gravity center -composite /tmp/battery-karma-status.png
else
  convert $symbol_folder/karmaRing.png $symbol_folder/karma$battery_level.png -gravity center -composite /tmp/battery-karma-status.png
fi

# add color to symbol
if [[ "$battery_capacity" -lt 20 ]]
then
  convert /tmp/battery-karma-status.png xc:"#ff0000" -channel RGB -clut /tmp/battery-karma-status.png
elif [[ "$battery_capacity" -lt 30 ]]
then
  convert /tmp/battery-karma-status.png xc:"#ffff00" -channel RGB -clut /tmp/battery-karma-status.png
else
  convert /tmp/battery-karma-status.png xc:"#ffffff" -channel RGB -clut /tmp/battery-karma-status.png
fi

echo "/tmp/battery-karma-status.png"
echo "$battery_capacity%"
