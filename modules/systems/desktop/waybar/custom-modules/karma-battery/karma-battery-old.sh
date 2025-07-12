#!/bin/sh
symbol_folder="/home/locochoco/.dotfiles/home/modules/hyprland/waybar/custom-modules/karma-battery"
#battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
battery_capacity=12
#battery_status=$(cat /sys/class/power_supply/BAT0/status)
battery_status='Discharging'
if [[ -z $battery_capacity ]] 
then
  # no battery on this device, exiting
  exit
fi
battery_level=$(expr $battery_capacity / 10)

# add color to symbol
if [[ $battery_capacity < 20 ]]
then
  convert $symbol_folder/karma$battery_level.png xc:"#ff0000" -channel RGB -clut /tmp/battery-karma-status.png
elif [[ $battery_capacity < 30 ]]
then
  convert $symbol_folder/karma$battery_level.png xc:"#ffff00" -channel RGB -clut /tmp/battery-karma-status.png
else
  convert $symbol_folder/karma$battery_level.png xc:"#ffffff" -channel RGB -clut /tmp/battery-karma-status.png
fi

# add special wheel if charging/plugged
if [[ $battery_status != 'Discharging' ]]
then
  convert $symbol_folder/karmaRingReinforced.png /tmp/battery-karma-status.png -gravity center -composite /tmp/battery-karma-status.png
else
  convert $symbol_folder/karmaRing.png /tmp/battery-karma-status.png -gravity center -composite /tmp/battery-karma-status.png
fi

echo "/tmp/battery-karma-status.png"
