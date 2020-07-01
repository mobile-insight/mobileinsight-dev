# -*- mode: ruby -*-
# vi: set ft=ruby :

# MobileInsight Vagrant Installation Script
# Copyright (c) 2017 MobileInsight Team
# Author: Zengwen Yuan, zyuan (at) cs.ucla.edu
# Version: 1.2

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
# git clone -b dev-py3 https://github.com/mobile-insight/mobileinsight-core.git
git clone https://github.com/mobile-insight/mobileinsight-core.git

# Clone MobileInsight-mobile repo
# git clone -b dev-py3 https://github.com/mobile-insight/mobileinsight-mobile.git
git clone https://github.com/mobile-insight/mobileinsight-mobile.git

# Clone python-for-android repo
git clone https://github.com/mobile-insight/python-for-android.git
# git clone -b dev-mi5 https://github.com/mobile-insight/python-for-android.git
# git clone -b p4a-MI https://github.com/luckiday/python-for-android.git

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

Vagrant.configure(2) do |config|
  # config.vm.box = "bento/ubuntu-16.04"
  # config.vm.box_version = "201708.22.0"
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.box_version = "202004.27.0"

  config.vm.provider "virtualbox" do |vb|
    # # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory and cpus on the VM:
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision "shell", privileged: true, inline: $INSTALL_BASE
  config.vm.provision "shell", privileged: false, keep_color: true, inline: $CLONE_REPOS
  config.vm.provision "shell", privileged: false, keep_color: true, inline: $COMPILE_APK
  config.vm.provision "shell", privileged: false, keep_color: true, inline: $INSTALL_CORE
end