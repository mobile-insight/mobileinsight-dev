# -*- mode: ruby -*-
# vi: set ft=ruby :

# MobileInsight Vagrant Installation Script
# Copyright (c) 2020 MobileInsight Team
# Author: Yuanjie Li, Zengwen Yuan, Yunqi Guo
# Version: 2.0

# --------------------------------MobileInsight---------------------------------------#

$INSTALL_BASE = <<SCRIPT
apt-get update
apt-get -y install build-essential pkg-config git ruby ant
apt-get -y install autoconf automake zlib1g-dev libtool
apt-get -y install bison byacc flex ccache libffi-dev
apt-get -y install openjdk-8-jdk openjdk-8-jre
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
apt-get -y install python-dev python-setuptools python-wxgtk3.0
apt-get -y install python3-dev python3-setuptools python3-pip
apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
apt-get -y install libgtk-3-dev libpulse-dev

gem install android-sdk-installer

# # Use Python3.7. Python3.8 has bugs with P4A
# add-apt-repository -y ppa:deadsnakes/ppa
# apt-get update
# apt-get -y install python3.7

# Set default Python to Python3
# alias python=python3.7
alias python=python3

# easy_install pip
pip3 install --upgrade pip
pip3 install cython
pip3 install pyyaml
pip3 install xmltodict
pip3 install pyserial
pip3 install virtualenv
pip3 install virtualenvwrapper
pip3 install Jinja2
pip3 install colorama
pip3 install sh==1.12.1
# pip3 install wxpython

SCRIPT


$CLONE_REPOS = <<SCRIPT
# Create MobileInsight dev folder at /home/vagrant/mi-dev
mkdir /home/vagrant/mi-dev
cd /home/vagrant/mi-dev

# Clone MobileInsight-core repo
# git clone https://github.com/mobile-insight/mobileinsight-core.git
git clone -b dev-6.0 https://github.com/mobile-insight/mobileinsight-core.git

# Clone MobileInsight-mobile repo
# git clone https://github.com/mobile-insight/mobileinsight-mobile.git
git clone -b dev-6.0 https://github.com/mobile-insight/mobileinsight-mobile.git

# Clone python-for-android repo
# git clone https://github.com/mobile-insight/python-for-android.git
git clone -b dev-6.0 https://github.com/mobile-insight/python-for-android.git

SCRIPT


$INSTALL_CORE = <<SCRIPT
# Install MobileInsight-core and run example
cd /home/vagrant/mi-dev/mobileinsight-core
sudo ./install-ubuntu.sh

SCRIPT


$COMPILE_APK = <<SCRIPT
# Config Android SDK download script
cat > /home/vagrant/android-sdk-installer.yml <<-EOF
platform: linux
version: '3859397'
debug: true
ignore_existing: true
components:
  - platform-tools
  - build-tools;27.0.3
  - platforms;android-27
  - extras;android;m2repository
EOF

# Download and setup Android SDK
# Based on https://github.com/Commit451/android-sdk-installer
cd ~
export ANDROID_HOME=/home/vagrant/android-sdk
android-sdk-installer
echo 'ANDROID_SDK_HOME=/home/vagrant/android-sdk' >> ~/.bashrc

# # Replace SDK tool with version 27.0.3 to use ant build
# cd $ANDROID_HOME
# rm -rf tools
# wget https://dl.google.com/android/repository/build-tools_r27.0.3-linux.zip
# unzip build-tools_r27.0.3-linux.zip
# rm build-tools_r27.0.3-linux.zip

# Download and setup Android NDK r19
cd ~
wget https://dl.google.com/android/repository/android-ndk-r19b-linux-x86_64.zip
unzip android-ndk-r19b-linux-x86_64.zip
echo 'ANDROID_NDK_HOME=/home/vagrant/android-ndk-r19b' >> ~/.bashrc
echo 'PATH=$PATH:$ANDROID_NDK_HOME:$ANDROID_SDK_HOME:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/tools/bin:$ANDROID_SDK_HOME/platform-tools' >> ~/.bashrc
source ~/.bashrc
rm android-ndk-r19b-linux-x86_64.zip

# Install python-for-android
cd /home/vagrant/mi-dev/python-for-android
sudo python3 setup.py install

# Prepare MobileInsight Android app compilation
cd /home/vagrant/mi-dev/mobileinsight-mobile

# To recompile after change the core
# rm -rf ~./python-for-android

# Make MobileInsight compilation config
make config

# Use default config to compile a python-for-android distribution
make dist

# # Use example keystore to compile and sign a release version of MobileInsight
# # keystore and key password: mobileinsight
make apk_debug

# # Copy MobileInsight apk to local folder
# # Please exit vagrant ssh shell and use adb to install
cp MobileInsight*.apk /vagrant/

SCRIPT



# --------------------------------Wireshark for Android---------------------------------------#

$INSTALL_BASE_WS = <<SCRIPT
apt-get update
apt-get -y install build-essential pkg-config
apt-get -y install autoconf automake zlib1g-dev libtool
apt-get -y install bison byacc flex ccache
apt-get -y install unzip
apt -y install python3.8
apt-get -y install libncurses5
apt-get -y install cmake pkg-config wget libglib2.0-dev bison flex libpcap-dev libgcrypt-dev qt5-default qttools5-dev qtmultimedia5-dev libqt5svg5-dev libc-ares-dev libsdl2-mixer-2.0-0 libsdl2-image-2.0-0 libsdl2-2.0-0

alias python=python3

SCRIPT


$CREATE_NDK_TOOLCHAIN = <<SCRIPT
# Download and setup Android NDK r15c
cd ~
wget https://dl.google.com/android/repository/android-ndk-r15c-linux-x86_64.zip
unzip android-ndk-r15c-linux-x86_64.zip
echo 'export ANDROID_NDK_HOME=/home/vagrant/android-ndk-r15c' >> ~/.bashrc
echo 'PATH=$PATH:$ANDROID_NDK_HOME' >> ~/.bashrc
source ~/.bashrc
rm android-ndk-r15c-linux-x86_64.zip

# Create MobileInsight dev folder at /home/vagrant/mi-dev
cd ~/android-ndk-r15c
python3 build/tools/make_standalone_toolchain.py \
    --arch arm \
    --api 26 \
    --stl gnustl \
    --unified-headers \
    --install-dir /home/vagrant/android-ndk-toolchain

SCRIPT


$DOWNLOAD_TARBALLS = <<SCRIPT
cd ~
wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
tar xf libiconv-1.15.tar.gz
rm libiconv-1.15.tar.gz

wget http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.tar.gz
tar xf gettext-0.19.8.tar.gz
rm gettext-0.19.8.tar.gz

# wget https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.27.tar.bz2
# tar xf libgpg-error-1.27.tar.bz2
# rm libgpg-error-1.27.tar.bz2

wget https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.37.tar.gz
tar xf libgpg-error-1.37.tar.gz
rm libgpg-error-1.37.tar.gz

wget https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.1.tar.bz2
tar xf libgcrypt-1.8.1.tar.bz2
rm libgcrypt-1.8.1.tar.bz2

wget http://ftp.gnome.org/pub/gnome/sources/glib/2.54/glib-2.54.3.tar.xz
tar xf glib-2.54.3.tar.xz
rm glib-2.54.3.tar.xz

wget https://github.com/c-ares/c-ares/releases/download/cares-1_15_0/c-ares-1.15.0.tar.gz
tar -xf c-ares-1.15.0.tar.gz
rm c-ares-1.15.0.tar.gz

wget https://github.com/libffi/libffi/releases/download/v3.3/libffi-3.3.tar.gz
tar -xf libffi-3.3.tar.gz
rm libffi-3.3.tar.gz

ws_ver=3.4.0
wget  http://www.mobileinsight.net/wireshark-3.4.0-rbc-dissector.tar.xz -O wireshark-3.4.0.tar.xz
tar -xf wireshark-3.4.0.tar.xz
rm wireshark-3.4.0.tar.xz

# mkdir ws_1
# mkdir ws_2
# cp -r wireshark-3.4.0/ ws_1/
# cp -r wireshark-3.4.0/ ws_2/

wget http://www.tcpdump.org/release/libpcap-1.9.1.tar.gz
tar -xf libpcap-1.9.1.tar.gz
rm libpcap-1.9.1.tar.gz

# Apply the patch to wireshark
# cd ws_1/
cp /vagrant/wireshark-for-android/ws_android.patch ./
cd wireshark-3.4.0
patch -p1 < ../ws_android.patch

# Compile wireshark first time
cd tools/lemon
cmake .
make
cp lemon ~/
echo "lemon is generated"

# Import the environment settings
cd ~
cp  /vagrant/wireshark-for-android/envsetup.sh .
chmod +x envsetup.sh
source ~/envsetup.sh

SCRIPT


$COMPILE_LIBICONV = <<SCRIPT
source ~/envsetup.sh
cd ~/libiconv-1.15
./configure --build=${BUILD_SYS} --host=arm-eabi --prefix=${PREFIX} --disable-rpath
make
make install
SCRIPT


$COMPILE_GETTEXT = <<SCRIPT
source ~/envsetup.sh
cd ~/gettext-0.19.8
./configure --build=${BUILD_SYS} --host=arm-eabi  --prefix=${PREFIX} --disable-rpath --disable-java --disable-native-java --disable-libasprintf --disable-openmp --disable-curses
make
make install

SCRIPT


$COMPILE_LIBGPGERROR = <<SCRIPT
source ~/envsetup.sh
cd ~/libgpg-error-1.37
./configure --build=${BUILD_SYS} --host=${TOOLCHAIN} --prefix=${PREFIX} --enable-static --disable-shared
make
make install

SCRIPT


$COMPILE_LIBGCRYPT = <<SCRIPT
source ~/envsetup.sh
cd ~/libgcrypt-1.8.1
./configure --build=${BUILD_SYS} --host=${TOOLCHAIN} --prefix=${PREFIX} --enable-static --disable-shared
make
make install

SCRIPT


$COMPILE_PCAP = <<SCRIPT
source ~/envsetup.sh
cd ~/libpcap-1.9.1
./configure --build=${BUILD_SYS} --host=${TOOLCHAIN} --prefix=${PREFIX} --enable-static --disable-shared
make
make install
SCRIPT


$COMPILE_GLIB = <<SCRIPT
# Install libffi
source ~/envsetup.sh
cd ~/libffi-3.3
./configure --build=${BUILD_SYS} --host=${TOOLCHAIN} --prefix=${PREFIX} --enable-static --disable-shared
make
make install

cd ~/c-ares-1.15.0/
unset CFLAGS
./configure --build=${BUILD_SYS} --host=${TOOLCHAIN} --prefix=${PREFIX} --enable-static --disable-shared
make
make install

# Reset the CFLAGS
source ~/envsetup.sh
cd ~/glib-2.54.3
cp  /vagrant/wireshark-for-android/android.cache .
./configure --build=${BUILD_SYS} --host=${TOOLCHAIN} --prefix=${PREFIX} --disable-dependency-tracking --cache-file=android.cache --enable-included-printf --enable-static --with-pcre=no --disable-libmount
make
make install

SCRIPT


$COMPILE_WIRESHARK = <<SCRIPT
# source ~/envsetup.sh
#
# # Create a new wireshark folder
# # sudo rm -rf wireshark-3.4.0/
#
# # mkdir ws_env/
# # cd ws_env/
# # wget  http://www.mobileinsight.net/wireshark-3.4.0-rbc-dissector.tar.xz -O wireshark-3.4.0.tar.xz
# # tar -xf wireshark-3.4.0.tar.xz
# # rm wireshark-3.4.0.tar.xz
# #
# # # Apply the patch to wireshark
# # cp  /vagrant/wireshark-for-android/ws_android.patch ./
# # cd  wireshark-3.4.0
# # patch -p1 < ../ws_android.patch
#
# echo "Compiling wireshark for Android"
# cd  ~/wireshark-3.4.0
# cmake -DCMAKE_PREFIX_PATH=${PREFIX} -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DANDROID_ABI=armeabi-v7a -DANDROID_NATIVE_API_LEVEL=26 -DCMAKE_LIBRARY_PATH=${PREFIX} -DGLIB2_LIBRARY=${PREFIX}/lib/libglib-2.0.so -DGLIB2_MAIN_INCLUDE_DIR=${PREFIX}/include/glib-2.0 -DGLIB2_INTERNAL_INCLUDE_DIR=${PREFIX}/lib/glib-2.0/include -DGMODULE2_LIBRARY=${PREFIX}/lib/libgmodule-2.0.so -DGMODULE2_INCLUDE_DIR=${PREFIX}/include/glib-2.0 -DGTHREAD2_LIBRARY=${PREFIX}/lib/libgthread-2.0.so -DGTHREAD2_INCLUDE_DIR=${PREFIX}/include/glib-2.0 -DGCRYPT_LIBRARY=${PREFIX}/lib/libgcrypt.a -DGCRYPT_INCLUDE_DIR=${PREFIX}/include -DGCRYPT_ERROR_LIBRARY=${PREFIX}/lib/libgpg-error.a -DCARES_LIBRARY=${PREFIX}/lib/libcares.a -DCARES_INCLUDE_DIR=${PREFIX}/include -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DANDROID_ABI=armeabi-v7a -DANDROID_NATIVE_API_LEVEL=26 -DENABLE_gnutls=OFF -DENABLE_plugins=OFF -DENABLE_pcap=OFF -DENABLE_libgcrypt-prefix=OFF -DBUILD_wireshark=OFF -DBUILD_packet-editor=OFF -DBUILD_profile-build=OFF -DBUILD_tshark=OFF -DBUILD_editcap=OFF -DBUILD_capinfos=OFF -DBUILD_captype=OFF -DBUILD_mergecap=OFF -DBUILD_reordercap=OFF -DBUILD_text2pcap=OFF -DBUILD_dftest=OFF -DBUILD_randpkt=OFF -DBUILD_dumpcap=OFF -DBUILD_rawshark=OFF -DBUILD_sharkd=OFF -DBUILD_tfshark=OFF -DBUILD_pcap-ng-default=OFF -DBUILD_androiddump=OFF -DBUILD_sshdump=OFF -DBUILD_ciscodump=OFF -DBUILD_randpktdump=OFF -DBUILD_udpdump=OFF .
# # To install the libwireshark at the same location as the other libs:
# # Replace lemon with the prebuilt one
#
# grep -rwl '&& lemon' * | xargs -i@ sed -i 's/\&\& lemon/\&\& ~\/lemon/g' @
# make
# sudo make install

cp /vagrant/build_ws.sh ./
chmod +x build_ws.sh
./build_ws.sh

SCRIPT


$COPY_LIBS = <<SCRIPT
# Copy MobileInsight apk to local folder
cd ~
mkdir ws_lib
cd ws_lib
cp ~/androidcc/lib/libgio-2.0.so .
cp ~/androidcc/lib/libglib-2.0.so .
cp ~/androidcc/lib/libgobject-2.0.so .
cp ~/androidcc/lib/libgmodule-2.0.so .
cp ~/androidcc/lib/libgthread-2.0.so .
cp /usr/local/lib/libwireshark.so .
cp /usr/local/lib/libwiretap.so .
cp /usr/local/lib/libwsutil.so .

cp -r ~/ws_lib  /vagrant/wireshark-for-android/
SCRIPT


$COMPILE_WS_DISSECTOR = <<SCRIPT
# Compile android_ws_dissector
cd ~/
git clone -b dev-6.0 https://github.com/mobile-insight/mobileinsight-core.git
cd mobileinsight-core/ws_dissector/
make android
mkdir ws_bin
cp android_* ws_bin/
cp -r ws_bin  /vagrant/wireshark-for-android/
SCRIPT





Vagrant.configure(2) do |config|
  # config.vm.box = "bento/ubuntu-16.04"
  # config.vm.box_version = "201708.22.0"
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.box_version = "202004.27.0"

  config.vm.provider "virtualbox" do |vb|
    # # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory and cpus on the VM:
    vb.memory = "8192"
    vb.cpus = 12
  end

  config.vm.define "mi" do |mi|
    mi.vm.provision :shell, inline: "echo Building MobileInsight"
    mi.vm.provision "shell", privileged: true, inline: $INSTALL_BASE
    mi.vm.provision "shell", privileged: false, keep_color: true, inline: $CLONE_REPOS
    mi.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_APK
    mi.vm.provision "shell", privileged: false, keep_color: true, inline: $INSTALL_CORE
  end

  config.vm.define "ws" do |ws|
    ws.vm.provision :shell, inline: "echo Building Wireshark for Android"
    ws.vm.provision "shell", privileged: true, inline: $INSTALL_BASE_WS
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $CREATE_NDK_TOOLCHAIN
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $DOWNLOAD_TARBALLS
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_LIBICONV
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_GETTEXT
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_LIBGPGERROR
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_LIBGCRYPT
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_PCAP
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_GLIB
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_WIRESHARK
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $COPY_LIBS
    ws.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_WS_DISSECTOR
  end
end