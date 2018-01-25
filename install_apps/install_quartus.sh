#!/bin/bash

################################################################################
###                       Install Quartus and ModelSim                       ###
################################################################################
#                                                                              #
#    Based on https://github.com/jessebarreto/ConfigureWorkspace script.       #
#                                                                              #
#    Also based on https://wiki.archlinux.org/index.php/Altera_Design_Software #
# and https://gist.github.com/PrieureDeSion/e2c0945cc78006b00d4206846bdb7657   #
#                                                                              #
################################################################################

### Preparations for Quartus and ModelSim
sudo apt-get update
sudo apt-get install -y libxft2:i386 libxext6:i386 libncurses5:i386
sudo apt-get install -y libc6:i386
sudo apt-get install -y libstdc++6:i386
sudo apt-get install -y unixodbc-dev
sudo apt-get install -y lib32ncurses5-dev
sudo apt-get install -y libzmq3-dev


##################################################
#                 Quartus 17.0.2                 #
##################################################

sudo apt-get install -y expat fontconfig xorg-dev glibc-source libcanberra-dev \
                        libpng12-dev libpng12-dev libice-dev libsm-dev \
                        util-linux ncurses-base tcl-dev tcllib zlib1g-dev \
                        libx11-dev libxau-dev libxdmcp-dev libxext-dev \
                        libxft-dev libxrender-dev libxt-dev libxtst-dev \
                        lib32-expat lib32-fontconfig lib32-freetype2 \
                        lib32-glibc lib32-gtk2 lib32-libcanberra lib32-libpng \
                        lib32-libpng12 lib32-libice lib32-libsm \
                        lib32-util-linux lib32-ncurses lib32-zlib lib32-libx11 \
                        lib32-libxau lib32-libxdmcp lib32-libxext lib32-libxft \
                        lib32-libxrender lib32-libxt lib32-libxtst -y

wget http://download.altera.com/akdlm/software/acdsinst/17.0std.2/602/ib_tar/Quartus-lite-17.0.2.602-linux.tar
mkdir Quartus-lite-17
tar -xf Quartus-lite-17.0.2.602-linux.tar -C Quartus-lite-17
cd Quartus-lite-17
echo \\n'When asked, use /opt/altera/17.0 as the installation directory!'
echo '[Press any key to continue]'
read -n 1 keypress
sudo ./setup.sh
cd ..
sudo rm -rf Quartus-lite-17

sudo touch /etc/profile.d/quartus_settings.sh
echo "# Quartus 17.0.2" | sudo tee --append /etc/profile.d/quartus_settings.sh
echo "export PATH=$PATH:/opt/altera/17.0/embedded/host_tools/altera/preloadergen:/opt/altera/17.0/quartus/bin:/opt/altera/17.0/quartus/sopc_builder/bin:/opt/altera/17.0/modelsim_ase/bin:/opt/altera/17.0/modelsim_ase/linuxaloem" | sudo tee --append /etc/profile.d/quartus_settings.sh
echo 'export QSYS_ROOTDIR="/opt/altera/17.0/quartus/sopc_builder/bin"' | sudo tee --append /etc/profile.d/quartus_settings.sh
echo 'export QUARTUS_ROOTDIR="/opt/altera/17.0/quartus"' | sudo tee --append /etc/profile.d/quartus_settings.sh
echo 'export SOCEDS_DEST_ROOT="/opt/altera/17.0/embedded"' | sudo tee --append /etc/profile.d/quartus_settings.sh
sudo chmod +x /etc/profile.d/quartus_settings.sh

echo "\n# Quartus 17.0.2" >> ~/.bashrc
echo "source /etc/profile.d/quartus_settings.sh" >> ~/.bashrc
echo "\n" >> ~/.bashrc

echo "\n# Quartus 17.0.2" >> ~/.zshrc
echo "source /etc/profile.d/quartus_settings.sh" >> ~/.zshrc
echo "\n" >> ~/.zshrc

### Create Shortcut
sudo touch /usr/share/applications/quartus17.desktop
echo '[Desktop Entry]' |  sudo tee --append /usr/share/applications/quartus17.desktop
echo 'Type=Application' |  sudo tee --append /usr/share/applications/quartus17.desktop
echo 'Version=1.0' |  sudo tee --append /usr/share/applications/quartus17.desktop
echo 'Name=Quartus (Quartus Prime 17.0) Lite Edition' |  sudo tee --append /usr/share/applications/quartus17.desktop
echo 'Comment=Quartus (Quartus Prime 17.0)' |  sudo tee --append /usr/share/applications/quartus17.desktop
echo 'Icon=/opt/altera/17.0/quartus/adm/quartusii.png' |  sudo tee --append /usr/share/applications/quartus17.desktop
echo 'Exec=/opt/altera/17.0/quartus/bin/quartus --64bit' |  sudo tee --append /usr/share/applications/quartus17.desktop
echo 'Terminal=false' |  sudo tee --append /usr/share/applications/quartus17.desktop
echo 'Categories=Development;IDE;' |  sudo tee --append /usr/share/applications/quartus17.desktop
echo 'Path=/opt/altera/17.0' |  sudo tee --append /usr/share/applications/quartus17.desktop

### USB-Blaster Cable Driver
sudo touch /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
sudo udevadm control --reload
sudo mkdir /etc/jtagd
sudo cp /opt/altera/17.0/quartus/linux64/pgm_parts.txt /etc/jtagd/jtagd.pgm_parts

### Give user access to USB-SERIAL devices connected to this computer
sudo touch /etc/udev/rules.d/50-system_usb.rules
echo 'KERNEL=="ttyUSB[0-9]*",MODE="0666"' | sudo tee --append /etc/udev/rules.d/50-system_usb.rules
echo 'KERNEL=="ttyACM[0-9]*",MODE="0666"' | sudo tee --append /etc/udev/rules.d/50-system_usb.rules



##################################################
#             ModelSim Configuration             #
##################################################

### Download freetype 2.4.12 lib
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.12.tar.bz2
tar -jxvf freetype-2.4.12.tar.bz2
cd freetype-2.4.12

sudo apt-get install -y libpng-dev libpng12-0 gcc-multilib g++-multilib \
                        lib32z1 lib32stdc++6 lib32gcc1 expat:i386 \
                        fontconfig:i386 libfreetype6:i386 libexpat1:i386 \
                        libc6:i386 libgtk-3-0:i386 libcanberra0:i386 \
                        libpng12-0:i386 libice6:i386 libsm6:i386 \
                        libncurses5:i386 zlib1g:i386 libx11-6:i386 \
                        libxau6:i386 libxdmcp6:i386 libxext6:i386 \
                        libxft2:i386 libxrender1:i386 libxt6:i386 \
                        libxtst6:i386 zlib1g-dev:i386 zlibc:i386

sudo ln -s /lib/x86_64-linux-gnu/libz.so.1.2.11 /lib/x86_64-linux-gnu/libzlib.so
sudo ln -s /lib/i386-linux-gnu/libz.so.1.2.11 /lib/i386-linux-gnu/libzlib.so
sudo ln -s /usr/lib/i386-linux-gnu/libpng12.so.0 /usr/lib/i386-linux-gnu/libpng12.so

### Build freetype
./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
make -j$(nproc)
sudo mkdir /opt/altera/17.0/modelsim_ase/lib32
sudo cp ./objs/.libs/libfreetype.so* /opt/altera/17.0/modelsim_ase/lib32
cd ../
rm -rf ./freetype-2.4.12


### Create Shortcut
sudo touch /usr/share/applications/modelsim.desktop
echo '[Desktop Entry]' |  sudo tee --append /usr/share/applications/modelsim.desktop
echo 'Type=Application' |  sudo tee --append /usr/share/applications/modelsim.desktop
echo 'Version=1.0' |  sudo tee --append /usr/share/applications/modelsim.desktop
echo 'Name=ModelSim Altera Edition' |  sudo tee --append /usr/share/applications/modelsim.desktop
echo 'Comment=ModelSim simulation software for Altera FPGAs' |  sudo tee --append /usr/share/applications/modelsim.desktop
echo 'Icon=/opt/altera/17.0/modelsim_ase/tcl/bitmaps/m.gif' |  sudo tee --append /usr/share/applications/modelsim.desktop
echo 'Exec=/opt/altera/17.0/modelsim_ase/bin/vsim' |  sudo tee --append /usr/share/applications/modelsim.desktop
echo 'Terminal=true' |  sudo tee --append /usr/share/applications/modelsim.desktop
echo 'Categories=Development;' |  sudo tee --append /usr/share/applications/modelsim.desktop


### Manual edition steps:
### TODO: Automate this too!
echo \\n'A few manual steps are needed to make ModelSim work!'
echo \\n'In the line below "dir=`dirname $arg0`" at line 50 of /opt/altera/17.0/modelsim_ase/vco add the following in a new line:'
echo 'export LD_LIBRARY_PATH=${dir}/lib32'
echo \\n'[Press any key to open the file in the correct line to be edited]'
read -n 1 keypress
sudo nano +51,0 /opt/altera/17.0/modelsim_ase/vco

echo \\n'Replace line 210 of /opt/altera/17.0/modelsim_ase/vco with the following:'
echo ' *)                vco="linux" ;;'
echo \\n'[Press any key to open the file in the correct line to be edited]'
read -n 1 keypress
sudo nano +211,0 /opt/altera/17.0/modelsim_ase/vco

echo \\n'Quartus and ModelSim installation and configuration finished!'
