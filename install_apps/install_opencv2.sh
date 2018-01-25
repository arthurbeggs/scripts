#!/bin/bash

################################################################################
###                       OpenCV2 Installation Script                        ###
################################################################################

### Single line script will download and run this gist automatically:
# curl -s "https://gist.githubusercontent.com/arthurbeggs/06df46af94af7f261513934e56103b30/raw/b751ab4f720aee01a7be08a20289b400c86b526d/install_opencv2_ubuntu.sh" | bash

################################################################################


### Dependencies
sudo apt-get update
sudo apt-get install -y build-essential cmake libgtk2.0-dev pkg-config \
                        python-numpy python-dev libavcodec-dev libavformat-dev \
                        libswscale-dev libjpeg-dev libpng12-dev libtiff5-dev \
                        libjasper-dev libopencv-dev checkinstall pkg-config \
                        yasm libjpeg-dev libjasper-dev libavcodec-dev \
                        libavformat-dev libswscale-dev libdc1394-22-dev \
                        libxine2 libgstreamer0.10-dev  libv4l-dev \
                        libgstreamer-plugins-base0.10-dev python-dev \
                        python-numpy libtbb-dev libqt4-dev libgtk2.0-dev \
                        libmp3lame-dev libopencore-amrnb-dev \
                        libopencore-amrwb-dev libtheora-dev libvorbis-dev \
                        libxvidcore-dev x264 v4l-utils

### Download opencv-2.4.13.5
wget https://github.com/opencv/opencv/archive/2.4.13.5.zip -O opencv-2.4.13.5.zip
unzip opencv-2.4.13.5.zip
cd opencv-2.4.13.5
mkdir release
cd release

### Compile and install
cmake -G "Unix Makefiles" -DCMAKE_CXX_COMPILER=/usr/bin/g++ CMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_TBB=ON -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_V4L=ON -DINSTALL_C_EXAMPLES=ON -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=ON -DWITH_QT=ON -DWITH_OPENGL=ON -DBUILD_FAT_JAVA_LIB=ON -DINSTALL_TO_MANGLED_PATHS=ON -DINSTALL_CREATE_DISTRIB=ON -DINSTALL_TESTS=ON -DENABLE_FAST_MATH=ON -DWITH_IMAGEIO=ON -DBUILD_SHARED_LIBS=OFF -DWITH_GSTREAMER=ON ..
make all -j$(nproc) # Uses all machine cores
sudo make install

cd ../../
rm -rf ./opencv-2.4.13.5

sudo apt-get install python-opencv -y

### Echoes OpenCV installed version if installation process was successful
echo -e "OpenCV version:"
pkg-config --modversion opencv
