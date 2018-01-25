#!/bin/bash

################################################################################
###                       Matlab 2017a Desktop Entry                         ###
################################################################################
#            Source code at https://github.com/arthurbeggs/scripts             #
################################################################################
#                                                                              #
#     Feel free to copy and modify this file. Giving me credit for it is your  #
# choice, but please keep references to other people's work, which I don't     #
# have ownership and thus cannot decide what to do with the licenses.          #
#                                                                              #
################################################################################

sudo touch /usr/share/applications/matlab.desktop
echo '[Desktop Entry]' |  sudo tee --append /usr/share/applications/matlab.desktop
echo 'Type=Application' |  sudo tee --append /usr/share/applications/matlab.desktop
echo 'Version=1.0' |  sudo tee --append /usr/share/applications/matlab.desktop
echo 'Name=Matlab 2017a' |  sudo tee --append /usr/share/applications/matlab.desktop
echo 'Matlab 2017a Professional Edition' |  sudo tee --append /usr/share/applications/matlab.desktop
echo 'Icon=/usr/local/MATLAB/R2017a/bin/glnxa64/cef_resources/matlab_icon.png' |  sudo tee --append /usr/share/applications/matlab.desktop
echo 'Exec=/usr/local/MATLAB/R2017a/bin/matlab' |  sudo tee --append /usr/share/applications/matlab.desktop
echo 'Terminal=true' |  sudo tee --append /usr/share/applications/matlab.desktop
echo 'Categories=Development;' |  sudo tee --append /usr/share/applications/matlab.desktop
