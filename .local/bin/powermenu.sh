#!/bin/sh

choice="$(echo "Lock
Shutdown
Reboot
Exit
Suspend" | fuzzel -d --placeholder Choose...)"

case $choice in
  Lock)
    loginctl lock-session
    ;;
  Shutdown)
    shutdown now
    ;;
  Reboot)
    reboot
    ;;
  Exit)
    swaymsg exit
    ;;
  Suspend)
    systemctl suspend
    ;;
esac
    
