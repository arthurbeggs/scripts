#!/bin/bash
##################################
# TODO: Escrever cabeçalho
##################################

cd ~/Downloads
mkdir Install
cd ~/Downloads/Install

###
# Updating Headers and Essential Libs
echo -e "\e[33mGetting Essential Stuff ...\e[0m"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install build-essential -y
sudo apt-get install mesa-utils -y
sudo apt-get install git subversion autoconf exifprobe automake libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev gdb pkg-config texinfo zlib1g-dev htop -y
# For better audio control
# sudo apt-get install pulseaudio pavucontrol -y
echo -e "\e[32m[OK] Essential Stuff \e[0m"


### gdebi
sudo apt-get install gdebi -y

### curl
apt-get install -y curl

### Num Lock ativo no boot
# sudo apt-get -y install numlockx
### TODO: Falta comando de ativação!


##### NOT SUPPORTED!
# # AMD GPU Driver
# wget https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-17.30-465504.tar.xz
# tar -Jxvf amdgpu-pro-17.30-465504.tar.xz
# cd amdgpu-pro-17.30-465504
# ./amdgpu-pro-install
#
# # Radeon Open Compute
# sudo apt install -y rocm-amdgpu-pro
# echo 'export LLVM_BIN=/opt/amdgpu-pro/bin' | sudo tee /etc/profile.d/amdgpu-pro.sh



### Update python packages
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip install -U
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip3 install -U




### zsh



###########################
# Linguagens de Programação
###########################

# Node
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

# Julia
sudo add-apt-repository ppa:staticfloat/juliareleases
sudo add-apt-repository ppa:staticfloat/julia-deps
sudo apt-get update
sudo apt-get install -y julia julia-doc

# R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu zesty/'
sudo apt-get update
sudo apt-get install -y r-base

# Haskell
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:hvr/ghc
sudo apt-get update
sudo apt-get install -y cabal-install-1.22 ghc-7.10.3
cat >> ~/.bashrc <<EOF
export PATH="\$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:\$PATH"
EOF
export PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH

# Icarus Verilog
sudo apt-get install -y iverilog

# Ruby
sudo apt-get install -y ruby-full

# Arduino Environment
sudo apt-get install -y arduino arduino-core

# Octave
sudo apt-add-repository ppa:octave/stable
sudo apt-get update
sudo -H apt-get install -y octave

# Lua
sudo apt-get install -y lua5.3 luarocks

# CoffeeScript
sudo -H npm install -g coffeescript

# TypeScript
sudo npm install -g typescript

# Sass
sudo gem install sass --no-user-install

# Less
sudo -H npm install -g less

# LaTeX
sudo apt-get install -y texlive-full

# Kotlin
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install kotlin

#Io
wget http://iobin.suspended-chord.info/linux/iobin-linux-x64-deb-current.zip -O iolang.zip
unzip iolang.zip
sudo gdebi IoLanguage-2013.11.04-Linux-x64.deb


### Futuramente Scala, Clojure, Erlang, Lisp, Racket...


### Frameworks Django, Rails, electron, angular...



#####################
### Jupyter Notebooks
#####################
sudo apt-get install python3-pip
pip3 install --upgrade pip
pip3 install jupyter

### Notebook repository
sudo add-apt-repository 'deb http://ppa.launchpad.net/chronitis/jupyter/ubuntu zesty main'
sudo apt-get update


### Metakernel
pip install metakernel --upgrade

### Octave kernel
pip install octave_kernel
python -m octave_kernel.install

### bash kernel
pip install bash_kernel
python -m bash_kernel.install

### Haskell kernel
sudo apt-get install -y libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev
pip3 install -r requirements.txt
curl -sSL https://get.haskellstack.org/ | sh
git clone https://github.com/gibiansky/IHaskell
cd IHaskell
stack install gtk2hs-buildtools
stack install --fast
ihaskell install --stack

### Ruby kernel
sudo apt install libtool libffi-dev ruby-dev make
sudo apt install libzmq3-dev libczmq-dev
sudo -H gem install cztop iruby
iruby register --force

### JavaScript kernel ## NOT properly installed
sudo npm install -g ijavascript

### R kernel
sudo apt-get install -y libzmq3-dev
apt-get -y build-dep libcurl4-gnutls-dev
apt-get -y install libcurl4-gnutls-dev
sudo apt-get install libcurl4-openssl-dev libssl-dev
## Start R
# install.packages(c('crayon', 'pbdZMQ', 'devtools'))
# devtools::install_github(paste0('IRkernel/', c('repr', 'IRdisplay', 'IRkernel')))
# IRkernel::installspec()

### julia kernel
## Start julia
# ENV["JUPYTER"]="/home/arthur/.local/share/jupyter/"
# Pkg.add("IJulia")

### tcl kernel
pip3 install tcl_kernel
python3 -m tcl_kernel.install

### NodeJS kernel
git clone https://github.com/notablemind/jupyter-nodejs.git
cd jupyter-nodejs
mkdir -p ~/.ipython/kernels/nodejs/
sudo npm install && node install.js
sudo npm run build
sudo npm run build-ext
jupyter console --kernel nodejs

### gnuplot kernel # Not properly installed
pip install gnuplot_kernel

### Typescript kernel # NOT installed
sudo npm install -g itypescript
sudo its --ts-install=global

### CoffeeScript kernel
sudo npm install jp-coffeescript

### C kernel # NOT installed
pip install jupyter-c-kernel
install_c_kernel




### Docker



### KMV qemu


### Azure CLI
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install azure-cli


### AWS CLI
pip install awscli



###
# Instalar o GIMP
echo -e "\e[33mGetting GIMP  ...\e[0m"
sudo apt-get -y install gimp
echo -e "\e[32m[OK] GIMP \e[0m"

# Instalar Inkscape
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt-get update
sudo apt-get install inkscape -y


################
###   Atom
################

### Atom Editor
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install -y atom

### Atom packages
apm install autoclose-html autocomplete-emojis autocomplete-haskell autocomplete-paths build busy busy-signal color-picker emmet figlet file-icons git-blame git-plus haskell-ghc-mod highlight-selected Hydrogen ide-haskell intentions language-arduino language-arm language-cspm language-csv language-haskell language-ini language-latex language-matlab language-mips language-nginx language-verilog language-vhdl language-x86-64-assembly latex latex-completions linter linter-chktex linter-csslint linter-flake8 linter-gcc linter-htmlhint linter-jshint linter-jsonlint linter-matlab linter-tidy linter-ui-default minimap minimap-cursorline minimap-highlight-selected minimap-linter pigments platformio-ide script tablr todo-show travis-ci-status

apm disable autocomplete-paths build busy busy-signal color-picker figlet git-plus highlight-selected Hydrogen intentions linter-chktex linter-csslint linter-gcc linter-htmlhint linter-jshint linter-tidy pigments platformio-ide travis-ci-status



### Deluge Torrent Client
sudo apt-get install deluge


### Stacer
wget https://github.com/oguzhaninan/Stacer/releases/download/v1.0.4/Stacer_1.0.4_amd64.deb
sudo dpkg --install Stacer_1.0.4_amd64.deb
Stacer


###
# Install Spotify
echo -e "\e[33mGetting Spotify   ...\e[0m"
# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
# 3. Update list of available packages
sudo apt-get update
# 4. Install Spotify
sudo apt-get install spotify-client -y
echo -e "\e[32m[OK] Spotify  \e[0m"


# Install VLC Media Player
sudo apt-get install vlc browser-plugin-vlc


# Franz



# Wireshark
sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt-get update
sudo apt-get install -y wireshark
sudo adduser $USER wireshark


# Meld
sudo apt-get install -y meld
sudo apt-get install -y intltool itstool gir1.2-gtksource-3.0 libxml2-utils


### GitKraken
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb




# Install Telegram
echo -e "\e[33mGetting Telegram	...\e[0m"
sudo add-apt-repository ppa:atareao/telegram
sudo apt-get update
sudo apt-get install telegram -y
echo -e "\e[32m[OK] Telegram	....  \e[0m"


# TeamViewer
wget http://download.teamviewer.com/download/teamviewer_i386.deb -O teamviewer.deb
sudo dpkg -i teamviewer.deb
sudo apt-get install -f -y


sudo apt-get install libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
# git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

cd ~/Downloads/Install



### GnuPG keyring
sudo apt-get install -y gnupg2 gpa


### Preparations for Quartus and ModelSim
sudo apt-get install -y libxft2:i386 libxext6:i386 libncurses5:i386
sudo apt-get install -y libc6:i386
sudo apt-get install -y libstdc++6:i386
sudo apt-get install -y unixodbc-dev
sudo apt-get install -y lib32ncurses5-dev
sudo apt-get install -y libzmq3-dev

###
# Install Quartus 17.0.2
echo -e "\e[33mGetting Quartus 17.0.2	...\e[0m"
cd ~/libs/
sudo apt-get install expat fontconfig xorg-dev glibc-source libcanberra-dev libpng12-dev libpng12-dev libice-dev libsm-dev util-linux ncurses-base tcl-dev tcllib zlib1g-dev libx11-dev libxau-dev libxdmcp-dev libxext-dev libxft-dev libxrender-dev libxt-dev libxtst-dev -y
wget http://download.altera.com/akdlm/software/acdsinst/17.0std.2/602/ib_tar/Quartus-lite-17.0.2.602-linux.tar
mkdir Quartus-lite-17
tar -xf Quartus-lite-17.0.2.602-linux.tar -C Quartus-lite-17
cd Quartus-lite-17
sudo ./setup.sh
cd ..
sudo rm -Rf Quartus-lite-17 # Clean the garbage
sudo touch /etc/profile.d/quartus_settings.sh
echo "# Quartus 17.0.2" | sudo tee --append /etc/profile.d/quartus_settings.sh
echo "export PATH=$PATH:/home/arthur/intelFPGA/17.0/embedded/host_tools/altera/preloadergen:/home/arthur/intelFPGA_lite/17.0/quartus/bin:/home/arthur/intelFPGA_lite/17.0/quartus/sopc_builder/bin:/home/arthur/intelFPGA_lite/17.0/modelsim_ase/bin:/home/arthur/intelFPGA_lite/17.0/modelsim_ase/linuxaloem" | sudo tee --append /etc/profile.d/quartus_settings.sh
echo 'export QSYS_ROOTDIR="/home/arthur/intelFPGA_lite/17.0/quartus/sopc_builder/bin"' | sudo tee --append /etc/profile.d/quartus_settings.sh
echo 'export QUARTUS_ROOTDIR="/home/arthur/intelFPGA_lite/17.0/quartus"' | sudo tee --append /etc/profile.d/quartus_settings.sh
echo 'export SOCEDS_DEST_ROOT="/home/arthur/intelFPGA/17.0/embedded"' | sudo tee --append /etc/profile.d/quartus_settings.sh
sudo chmod +x /etc/profile.d/quartus_settings.sh
echo "# Quartus 17.0.2" >> ~/.bashrc
echo "source /etc/profile.d/quartus_settings.sh" >> ~/.bashrc
echo " " >> ~/.bashrc
# Create ShortCut
sudo touch /usr/share/applications/quartus2017.desktop
echo '[Desktop Entry]' |  sudo tee --append /usr/share/applications/quartus2017.desktop
echo 'Type=Application' |  sudo tee --append /usr/share/applications/quartus2017.desktop
echo 'Version=0.9.4' |  sudo tee --append /usr/share/applications/quartus2017.desktop
echo 'Name=Quartus (Quartus Prime 17.0) Lite Edition' |  sudo tee --append /usr/share/applications/quartus2017.desktop
echo 'Comment=Quartus (Quartus Prime 17.0)' |  sudo tee --append /usr/share/applications/quartus2017.desktop
echo 'Icon=/home/arthur/intelFPGA_lite/17.0/quartus/adm/quartusii.png' |  sudo tee --append /usr/share/applications/quartus2017.desktop
echo 'Exec=/home/arthur/intelFPGA_lite/17.0/quartus/bin/quartus --64bit' |  sudo tee --append /usr/share/applications/quartus2017.desktop
echo 'Terminal=false' |  sudo tee --append /usr/share/applications/quartus2017.desktop
echo 'Categories=Development;IDE;' |  sudo tee --append /usr/share/applications/quartus2017.desktop
echo 'Path=/home/arthur/intelFPGA_lite/17.0' |  sudo tee --append /usr/share/applications/quartus2017.desktop
# USB-Blaster Cable Driver
sudo touch /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"' | sudo tee --append /etc/udev/rules.d/51-altera-usb-blaster.rules
sudo udevadm control --reload
sudo mkdir /etc/jtagd
sudo cp /home/arthur/intelFPGA_lite/17.0/quartus/linux64/pgm_parts.txt /etc/jtagd/jtagd.pgm_parts
echo -e "\e[32m[OK] Quartus 17.0.2	....  \e[0m"

###
# Give permission to users to access USB-Serial devices connected to this machine without super user permission
# With great powers come great responsabilities
# Give user access to USB-SERIAL devices connected to this computer
echo -e "\e[33mGiving User Access to USB Devices	...\e[0m"
sudo touch /etc/udev/rules.d/50-system_usb.rules
echo 'KERNEL=="ttyUSB[0-9]*",MODE="0666"' | sudo tee --append /etc/udev/rules.d/50-system_usb.rules
echo 'KERNEL=="ttyACM[0-9]*",MODE="0666"' | sudo tee --append /etc/udev/rules.d/50-system_usb.rules
echo -e "\e[32m[OK]	User Access to USB Devices	....  \e[0m"


### Making ModelSim work
# A few manual steps described in https://gist.github.com/PrieureDeSion/e2c0945cc78006b00d4206846bdb7657 are needed
########
cd ~/Downloads/Install
mkdir freetype
cd freetype
# Download freetype 2.4.12 lib
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.12.tar.bz2
tar -jxvf freetype-2.4.12.tar.bz2
cd freetype-2.4.12
./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
make -j8
# Instalar dependências
sudo apt-get install -y libpng-dev
sudo apt-get install -y libpng12-0
sudo apt-get install -y gcc-multilib g++-multilib \
lib32z1 lib32stdc++6 lib32gcc1 \
expat:i386 fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386 libgtk-3-0:i386 \
libcanberra0:i386 libpng12-0:i386 libice6:i386 libsm6:i386 libncurses5:i386 zlib1g:i386 \
libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386 \
libxt6:i386 libxtst6:i386 zlib1g-dev:i386 zlibc zlibc:i386
sudo ln -s /lib/x86_64-linux-gnu/libz.so.1.2.11 /lib/x86_64-linux-gnu/libzlib.so
sudo ln -s /lib/i386-linux-gnu/libz.so.1.2.11 /lib/i386-linux-gnu/libzlib.so
sudo ln -s /usr/lib/i386-linux-gnu/libpng16.so.16 /usr/lib/i386-linux-gnu/libpng16.so
# Build freetype
./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
make -j8
# Copy freetype to ModelSim folder
sudo mkdir ~/intelFPGA_lite/17.0/modelsim_ase/lib32
# TODO: arrumar diretórios
sudo cp ~/Downloads/Install/freetypeagain/freetype-2.4.12/objs/.libs/libfreetype.so* ~/intelFPGA_lite/17.0/modelsim_ase/lib32
# Manually add the following line (uncommented) after "dir=`dirname $arg0`" line found outside loops
# export LD_LIBRARY_PATH=${dir}/lib32
