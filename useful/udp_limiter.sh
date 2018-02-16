#!/bin/bash

################################################################################
###                      UDP Upload Bandwidth Throttler                      ###
################################################################################
#            Source code at https://github.com/arthurbeggs/scripts             #
################################################################################
#                                                                              #
#     Based upon http://www.mzpeter.co.uk/limit-bandwidth-udp.html and         #
# https://www.cyberciti.biz/faq/linux-traffic-shaping-using-tc-to-control-http\#
#-traffic/                                                                     #
#                                                                              #
#     Feel free to copy and modify this file. Giving me credit for it is your  #
# choice, but please keep references to other people's work, which I don't     #
# have ownership and thus cannot decide what to do with the licenses.          #
#                                                                              #
################################################################################

network_interface=enp1s0
# network_interface=wlp2s0
throttled_rate=110kbps


start (){

    # Turn on queue discipline
    sudo /sbin/tc qdisc add dev $network_interface root handle 1:0 htb default 10

    # Define limitations
    sudo /sbin/tc class add dev $network_interface parent 1:0 classid 1:10 htb rate $throttled_rate prio 0

    ### Add rule to iptables
    sudo /sbin/iptables -A OUTPUT -t mangle -p udp -j MARK --set-mark 10

    # Assign iptables rule to tc rule
    sudo tc filter add dev $network_interface parent 1:0 prio 0 protocol ip handle 10 fw flowid 1:10
}

stop (){
    ### Delete previous rules for the interface
    sudo /sbin/tc qdisc del dev $network_interface root

    ### Remove rule from iptables
    sudo /sbin/iptables -D OUTPUT -t mangle -p udp -j MARK --set-mark 10
}


show () {
    sudo /sbin/tc -s qdisc ls dev $network_interface
}

case "$1" in

    start)
        echo -n "Starting UDP throttling: "
        start
        echo "done"
    ;;

    stop)
        echo -n "Stopping UDP throttling: "
        stop
        echo "done"
    ;;

    reload)
        echo -n "Reloading UDP throttling:"
        stop
        start
        echo "done"
    ;;

    show)
        echo "UDP throttling status for $network_interface:"
        show
        echo ""
    ;;

    *)
        pwd=$(pwd)
        echo "Usage: $0 {start|stop|reload|show}"
    ;;

esac

exit 0
