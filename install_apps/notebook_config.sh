#!/bin/bash

################################################################################
###                  Xubuntu 16.04 - Notebook Configuration                  ###
################################################################################
#            Source code at https://github.com/arthurbeggs/scripts             #
################################################################################
#                                                                              #
#     This script was inspired by Jessé Barreto's configuration script         #
# available at https://github.com/jessebarreto/ConfigureWorkspace              #
#                                                                              #
#     This script isn't full automated yet, as a few things still need user    #
# input. I hope I'll fix this in the near future. I also want to make it       #
# possible to tweak what you want to install and what you don't want using a   #
# JSON or YAML file or something like that.                                    #
#                                                                              #
#     Feel free to copy and modify this file. Giving me credit for it is your  #
# choice, but please keep references to other people's work, which I don't     #
# have ownership and thus cannot decide what to do with the licenses.          #
#                                                                              #
################################################################################


##################################################
#            Installation root folder            #
##################################################

cd ~/Downloads
mkdir Install
cd ~/Downloads/Install



##################################################
#  Essential headers, drivers and applications   #
##################################################

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y build-essential autoconf exifprobe automake libass-dev \
                    libfreetype6-dev libsdl1.2-dev libtheora-dev libtool \
                    libva-dev libvdpau-dev libvorbis-dev libxcb1-dev \
                    libxcb-shm0-dev libxcb-xfixes0-dev gdb pkg-config \
                    texinfo zlib1g-dev htop nload mlocate curl wget gdebi \
                    pulseaudio pavucontrol


### Updated Git client
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install git -y


##### NOT SUPPORTED IN 16.04!
# ### AMD GPU Pro Driver
# wget https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-17.30-465504.tar.xz
# tar -Jxvf amdgpu-pro-17.30-465504.tar.xz
# cd amdgpu-pro-17.30-465504
# ./amdgpu-pro-install
#
# ### Radeon Open Compute
# sudo apt install -y rocm-amdgpu-pro
# echo 'export LLVM_BIN=/opt/amdgpu-pro/bin' | sudo tee /etc/profile.d/amdgpu-pro.sh


### Oibaf Graphic Drivers
sudo add-apt-repository ppa:oibaf/graphics-drivers -y
sudo apt full-upgrade -y
sudo apt install mesa-utils -y


### zsh
sudo apt install -y zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
sudo apt install -y fonts-powerline
# TODO: Separar em script próprio com customização de ~/.zshrc


### UFW - Uncomplicated Firewall
sudo apt install ufw -y
sudo ufw enable
sudo ufw logging on
sudo ufw default deny incoming
sudo ufw default allow outgoing



##################################################
#       Programming Languages and Linters        #
##################################################

### Python
sudo apt install -y python python3 python-pip python3-pip
### Update python packages
pip install --upgrade pip
pip3 install --upgrade pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip install -U
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip3 install -U
# Linters
sudo -H pip install pep8 pycodestyle
sudo -H pip3 install pep8 pycodestyle


### Node
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
# Install npm packages locally
## NOTE: Maybe not suitable for server environments and multiple users
wget -O- https://raw.githubusercontent.com/glenpike/npm-g_nosudo/master/npm-g-nosudo.sh | sh


### Julia
sudo add-apt-repository ppa:staticfloat/juliareleases
sudo add-apt-repository ppa:staticfloat/julia-deps
sudo apt-get update
sudo apt-get install -y julia julia-doc


### R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu $(lsb_release -cs)/'
sudo apt-get update
sudo apt-get install -y r-base


### Haskell
sudo apt-get install haskell-platform -y
cabal update
cabal install ghc-mod hsdev --force-reinstall


### Icarus Verilog
sudo apt-get install -y iverilog


### Ruby
sudo apt-get install -y ruby-full


### Arduino Environment
sudo apt-get install -y arduino arduino-core


### Octave
sudo apt-add-repository ppa:octave/stable
sudo apt-get update
sudo -H apt-get install -y octave


### Lua
sudo apt-get install -y lua5.3 luarocks


### CoffeeScript
npm install -g coffeescript


### TypeScript
npm install -g typescript


### Sass
sudo gem install sass --no-user-install


### Less
npm install -g less


### LaTeX
sudo apt-get install -y texlive-full


### Kotlin
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install kotlin


### Io
wget http://iobin.suspended-chord.info/linux/iobin-linux-x64-deb-current.zip -O iolang.zip
unzip iolang.zip
yes | sudo gdebi IoLanguage-2013.11.04-Linux-x64.deb


### Prolog
sudo apt-add-repository ppa:swi-prolog/stable -y
sudo apt-get update
sudo apt-get install swi-prolog -y


### Erlang
sudo apt-get install erlang -y


### Java
sudo apt install openjdk-8-jdk -y


### Go
wget https://dl.google.com/go/go1.9.2.linux-amd64.tar.gz -O golang.tar.gz
sudo tar -C /usr/local -xzf golang.tar.gz
echo "# Go lang path" >> ~/.zshrc
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.zshrc
# Linter
go get -u github.com/golang/lint/golint


### Clojure
curl -O https://download.clojure.org/install/linux-install-1.9.0.302.sh
chmod +x linux-install-1.9.0.302.sh
sudo ./linux-install-1.9.0.302.sh


### Common LISP
sudo apt install sbcl -y
curl -o /tmp/ql.lisp http://beta.quicklisp.org/quicklisp.lisp
sbcl --no-sysinit --no-userinit --load /tmp/ql.lisp \
   --eval '(quicklisp-quickstart:install :path ".quicklisp")' \
   --quit


### Elixir
sudo apt install elixir -y


### Elm
npm install -g elm


### Idris
cabal install idris --force-reinstalls


### OCaml OPAM
sudo apt install opam
# Linter
opam init
opam install merlin
opam user-setup install


### Racket
sudo add-apt-repository ppa:plt/racket -y
sudo apt-get update
sudo apt install racket -y


### Rust
curl https://sh.rustup.rs -sSf | sh


### Scala
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt -y


### Smalltalk
sudo apt-get install gnu-smalltalk -y


### LLVM & Clang
### NOTE: LLVM & Clang comingo from Oibaf packages :c
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6084F3CF814B57C1CF12EFD515CF4D18AF4F7421
sudo add-apt-repository 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main'
sudo add-apt-repository 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-4.0 main'
sudo add-apt-repository 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main'
sudo apt update
sudo apt-get install clang-5.0 lldb-5.0 lld-5.0 -y


### YAML
npm install yaml-js -g


### Shell Check linter
sudo apt install shellcheck -y



##################################################
#                   Frameworks                   #
##################################################

### Jekyll
sudo gem install jekyll bundler


### Django
sudo -H pip install Django==2.0.1


### Rails, electron, angular,...



##################################################
#                   Databases                    #
##################################################




##################################################
#                   Toolchains                   #
##################################################

### WebAssembly
echo \\n >> ~/.zshrc
git clone https://github.com/juj/emsdk.git ~/.emsdk
cd ~/.emsdk
./emsdk install latest
./emsdk activate latest
echo "source ~/.emsdk/emsdk_env.sh" >> ~/.zshrc
echo "# Emscripten WebAssembly aliases" >> ~/.zshrc
echo "alias wasm='emcc -s WASM=1' wasmrun='emrun --no_browser --port 9090'" >> ~/.zshrc
cd ~/Downloads/Install


### RISC-V
sudo apt install -y autoconf automake autotools-dev curl device-tree-compiler \
                    libmpc-dev libmpfr-dev libgmp-dev gawk build-essential \
                    bison flex texinfo gperf libtool patchutils bc zlib1g-dev
echo \\n >> ~/.zshrc
echo '# RISC-V Toolchain' >> ~/.zshrc
TOP=$HOME/.local/share
echo "RISCV=$TOP/riscv" >> ~/.zshrc
echo 'PATH=$PATH:$RISCV/bin' >> ~/.zshrc
export MAKEFLAGS=$(nproc)
source ~/.zshrc
git clone --recursive https://github.com/riscv/riscv-tools.git $TOP/riscv-tools
cd $TOP/riscv-tools
./build.sh
cd ~/Downloads/Install


### OpenCV
# curl -s "https://raw.githubusercontent.com/arthurbeggs/scripts/master/install_apps/install_opencv2.sh" | bash
source ./install_opencv2_ubuntu.sh


### Quartus and ModelSim
# curl -s "https://raw.githubusercontent.com/arthurbeggs/scripts/master/install_apps/install_quartus.sh" | bash
source ./install_quartus.sh



##################################################
#               Jupyter Notebooks                #
##################################################

sudo -H pip3 install jupyter

### Notebook repository
sudo add-apt-repository ppa:chronitis/jupyter -y
sudo apt-get update


### Metakernel
sudo -H pip install metakernel --upgrade


### Haskell kernel
sudo apt install ihaskell -y


### julia kernel
sudo apt install ijulia -y


### R kernel
sudo apt install irkernel -y


### Ruby kernel
sudo apt install iruby -y


### Octave kernel
sudo -H pip install octave_kernel




##################################################
#               Development Tools                #
##################################################

### Docker
sudo apt-get install apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce -y


### KMV qemu
sudo apt-get install qemu-kvm qemu virt-manager virt-viewer libvirt-bin bridge-utils -y


### Azure CLI
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install azure-cli -y


### AWS CLI
sudo -H pip install awscli


### GCP CLI
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-cloud-sdk -y


# Libsecret credential helper for Git
sudo apt-get install libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
cd ~/Downloads/Install


### GnuPG keyring
sudo apt-get install -y gnupg2 gpa seahorse


### gpg-agent configurations
gpg2 --list-keys
touch ~/.gnupg/gpg-agent.conf2
echo "use-standard-socket" >> ~/.gnupg/gpg-agent.conf2
echo "pinentry-program /usr/bin/pinentry-gtk-2" >> ~/.gnupg/gpg-agent.conf2
echo "default-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf2
echo "max-cache-ttl 3600" >> ~/.gnupg/gpg-agent.conf2


# Meld
sudo apt-get install -y meld
sudo apt-get install -y intltool itstool gir1.2-gtksource-3.0 libxml2-utils


### GitKraken
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
yes | sudo gdebi gitkraken-amd64.deb


# TLDR manual entries
npm install -g tldr


### Atom Editor
sudo add-apt-repository ppa:webupd8team/atom -y
sudo apt-get update
sudo apt-get install -y atom
### Atom packages
apm install atom-clock autoclose-html autocomplete-emojis autocomplete-haskell autocomplete-paths build busy busy-signal color-picker emmet figlet file-icons git-blame git-plus haskell-ghc-mod highlight-selected Hydrogen ide-haskell intentions language-arduino language-arm language-cspm language-csv language-haskell language-ini language-latex language-matlab language-mips language-nginx language-verilog language-vhdl language-x86-64-assembly latex latex-completions linter linter-chktex linter-csslint linter-flake8 linter-gcc linter-htmlhint linter-jshint linter-jsonlint linter-matlab linter-tidy linter-ui-default minimap minimap-cursorline minimap-highlight-selected minimap-linter pigments platformio-ide script tablr todo-show travis-ci-status
apm disable autocomplete-paths build busy busy-signal color-picker figlet git-plus highlight-selected Hydrogen intentions linter-chktex linter-csslint linter-gcc linter-htmlhint linter-jshint linter-tidy pigments platformio-ide travis-ci-status
### TODO: Fazer script standalone para configuração do Atom

###  Sublime
sudo apt-get install apt-transport-https -y
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text -y
### TODO: Fazer script standalone para configuração do Sublime



##################################################
#               Other Applications               #
##################################################

### GIMP
sudo apt-get -y install gimp


### Inkscape
sudo add-apt-repository ppa:inkscape.dev/stable -y
sudo apt-get update
sudo apt-get install inkscape -y


### Deluge Torrent Client
sudo apt-get install deluge -y


### Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client -y
# Link keyboard media controls to Spotify
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioPlay -s "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause" -n -t string
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioNext -s "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next" -n -t string
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioPrev -s "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous" -n -t string


### VLC Media Player
sudo apt-get install vlc browser-plugin-vlc -y


### Wireshark
sudo add-apt-repository ppa:wireshark-dev/stable -y
sudo apt-get update
sudo apt-get install -y wireshark
sudo adduser $USER wireshark


### Stacer
wget https://github.com/oguzhaninan/Stacer/releases/download/v1.0.8/Stacer_1.0.8_amd64.deb
yes | sudo gdebi Stacer_1.0.8_amd64.deb


### QDirStat
sudo add-apt-repository ppa:nathan-renniewaldock/qdirstat -y
sudo apt-get update
sudo apt install -y qdirstat


### Master PDF Editor
wget http://get.code-industry.net/public/master-pdf-editor-4.3.61_qt5.amd64.deb -O master-pdf-editor.deb
yes | sudo gdebi master-pdf-editor.deb


### Calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"


### Telegram
sudo add-apt-repository ppa:atareao/telegram
sudo apt-get update
sudo apt-get install telegram -y


### Discord
wget https://dl.discordapp.net/apps/linux/0.0.4/discord-0.0.4.deb
yes | sudo gdebi discord-0.0.4.deb


### TeamViewer
wget http://download.teamviewer.com/download/teamviewer_i386.deb -O teamviewer.deb
yes | sudo gdebi teamviewer.deb


### Google Drive CLI
sudo apt-get install software-properties-common dirmngr -y
sudo apt-add-repository 'deb http://shaggytwodope.github.io/repo ./' -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7086E9CC7EC3233B
sudo apt-key update
sudo apt-get update
sudo apt-get install drive -y
### Automation scripts available at https://gitlab.com/jean-christophe-manciot/Drive




################################################################################
################################################################################
