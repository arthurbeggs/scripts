#!/bin/bash

################################################################################
###                         Libvirt Services Stopper                         ###
################################################################################
#            Source code at https://github.com/arthurbeggs/scripts             #
################################################################################
#                                                                              #
#     This script starts and stops libvirt services. It's useful to decrease   #
# memory usage when no virtual machine is running.                             #
#                                                                              #
#     Feel free to copy and modify this file. Giving me credit for it is your  #
# choice, but please keep references to other people's work, which I don't     #
# have ownership and thus cannot decide what to do with the licenses.          #
#                                                                              #
################################################################################

start () {
    sudo systemctl start libvirt-bin.service
    sudo systemctl start libvirt-guests.service
}

stop () {
    sudo systemctl stop libvirt-guests.service
    sudo systemctl disable libvirt-guests.service
    sudo systemctl stop libvirt-bin.service
    sudo systemctl disable libvirt-bin.service
}

case "$1" in

    start)
        echo "Starting libvirt..."
        start
        echo "Done!"
    ;;

    stop)
        echo "Stopping libvirt..."
        stop
        echo "Done!"
    ;;

    *)
        pwd=$(pwd)
        echo "Usage: $0 {start|stop}"
    ;;

esac
