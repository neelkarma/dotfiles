#!/bin/sh

mode="$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"

case $mode in
  powersave)
    icon="󰌪 "
    ;;
  performance)
    icon="󰓅 "
    ;;
esac

echo "{\"text\":\"$icon\",\"class\":\"$mode\",\"tooltip\":\"$mode\"}"
