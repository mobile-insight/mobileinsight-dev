# -*- mode: ruby -*-
# vi: set ft=ruby :

# MobileInsight Vagrant Installation Script
# Copyright (c) 2019 MobileInsight Team
# Author: Zengwen Yuan, zyuan (at) cs.ucla.edu
# Version: 1.3

$INSTALL_BASE = <<SCRIPT
apt-get update
apt-get -y install build-essential pkg-config git ruby ant
apt-get -y install autoconf automake zlib1g-dev libtool
apt-get -y install bison byacc flex ccache
apt-get -y install openjdk-8-jdk openjdk-8-jre
apt-get -y install python-dev python-setuptools python-wxgtk3.0
apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

gem install android-sdk-installer

easy_install pip
pip install cython==0.25.2
pip install pyyaml
pip install xmltodict
pip install pyserial
pip install virtualenv
pip install virtualenvwrapper

SCRIPT


$CLONE_REPOS = <<SCRIPT
# Create MobileInsight dev folder at /home/vagrant/mi-dev
mkdir /home/vagrant/mi-dev
cd /home/vagrant/mi-dev

# Clone MobileInsight-core repo
git clone https://github.com/mobile-insight/mobileinsight-core.git

# Clone MobileInsight-mobile repo
git clone https://github.com/mobile-insight/mobileinsight-mobile.git

# Clone python-for-android repo
git clone https://github.com/mobile-insight/python-for-android.git

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
  - build-tools;25.0.3
  - platforms;android-19
  - extras;android;m2repository
EOF

# Download and setup Android SDK
# Based on https://github.com/Commit451/android-sdk-installer
cd ~
export ANDROID_HOME=/home/vagrant/android-sdk
android-sdk-installer
echo 'ANDROID_SDK_HOME=/home/vagrant/android-sdk' >> ~/.bashrc

# Replace SDK tool with version 25.2.5 to use ant build
cd $ANDROID_HOME
rm -rf tools
wget https://dl.google.com/android/repository/tools_r25.2.5-linux.zip
unzip tools_r25.2.5-linux.zip
rm tools_r25.2.5-linux.zip

# Download and setup Android NDK r10e
cd ~
wget https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip
unzip android-ndk-r10e-linux-x86_64.zip
echo 'ANDROID_NDK_HOME=/home/vagrant/android-ndk-r10e' >> ~/.bashrc
echo 'PATH=$PATH:$ANDROID_NDK_HOME:$ANDROID_SDK_HOME:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/tools/bin:$ANDROID_SDK_HOME/platform-tools' >> ~/.bashrc
source ~/.bashrc
rm android-ndk-r10e-linux-x86_64.zip

# Install python-for-android
cd /home/vagrant/mi-dev/python-for-android
sudo python setup.py install

# Prepare MobileInsight Android app compilation
cd /home/vagrant/mi-dev/mobileinsight-mobile

# Make MobileInsight compilation config
make config

# Use default config to compile a python-for-android distribution
make dist

# Use example keystore to compile and sign a release version of MobileInsight
# keystore and key password: mobileinsight
make apk_debug

# Copy MobileInsight apk to local folder
# Please exit vagrant ssh shell and use adb to install
cp MobileInsight-4.0.0-debug.apk /vagrant

SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  # config.vm.box_version = "201708.22.0"

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