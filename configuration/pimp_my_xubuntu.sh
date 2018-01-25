#!/bin/bash

################################################################################
###                             Pimp My Xubuntu                              ###
################################################################################
#            Source code at https://github.com/arthurbeggs/scripts             #
################################################################################
#                                                                              #
#     This script customizes my Ubuntu with Xfce4 experience, making it really #
# delightful to use daily for everu purpose. As it heavily depends on personal #
# tastes, it might not be suitable for everybody :P                            #
#                                                                              #
#     Feel free to copy and modify this file. Giving me credit for it is your  #
# choice, but please keep references to other people's work, which I don't     #
# have ownership and thus cannot decide what to do with the licenses.          #
#                                                                              #
################################################################################

### NOTE: This script is heavily incomplete. There is a TON of things I didn't put yet

mkdir ~/Downloads/Pimp
cd ~/Downloads/Pimp

### Fonts
wget -O source-code-pro.zip https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip
unzip source-code-pro.zip
sudo cp -r source-code-pro-2.030R-ro-1.050R-it/OTF /usr/local/share/fonts
sudo fc-cache -f -v
rm -rf source-code-pro-2.030R-ro-1.050R-it
rm source-code-pro.zip

git clone https://github.com/powerline/fonts.git powerline_fonts
./powerline_fonts/install.sh
fc-cache -f -v
rm -rf powerline_fonts/


### Terminal color schemes
git clone https://github.com/afg984/base16-xfce4-terminal.git
mkdir -p ~/.local/share/xfce4/terminal/colorschemes
cp base16-xfce4-terminal/colorschemes/* ~/.local/share/xfce4/terminal/colorschemes
rm -rf base16-xfce4-terminal


### Zsh Theme
mkdir -p ~/.oh-my-zsh/custom/themes
wget -O - https://raw.githubusercontent.com/halfo/lambda-mod-zsh-theme/master/lambda-mod.zsh-theme | tee ~/.oh-my-zsh/custom/themes/lambda-mod.zsh-theme

