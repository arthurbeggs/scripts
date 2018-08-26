#!/bin/bash

################################################################################
###                           Turn Off NumLock Led                           ###
################################################################################
#            Source code at https://github.com/arthurbeggs/scripts             #
################################################################################
#                                                                              #
#     This script turns off the keyboard Num Lock led. It's not an ideal       #
# solution as you need to run it everytime a Lock key is pressed and needs     #
# root permissions.                                                            #
#                                                                              #
#     Feel free to copy and modify this file. Giving me credit for it is your  #
# choice, but please keep references to other people's work, which I don't     #
# have ownership and thus cannot decide what to do with the licenses.          #
#                                                                              #
################################################################################

sudo su -c 'setleds -L +num < /dev/tty7'
sudo su -c 'setleds -L -num < /dev/tty7'
