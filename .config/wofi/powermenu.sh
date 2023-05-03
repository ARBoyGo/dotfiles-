#!/usr/bin/env bash

op=$( echo -e " Shutdown\n Reboot\n Suspend\n Hibernate\n Logout" | wofi -i --dmenu | awk '{print tolower($2)}' )

case $op in 
        shutdown)
                systemctl poweroff
                ;;
        reboot)
                systemctl reboot
                ;;
        suspend)
                systemctl suspend
                ;;
        hibernate)
                systemctl hibernate
                ;;
        logout)
                pkill -KILL -u $(whoami)
                ;;
esac
