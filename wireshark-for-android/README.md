# Cross-compile Wireshark for Android

Source: https://github.com/luckiday/wireshark-for-android


This repository provides the vagrant environment to cross-compile 
wireshark(3.4.0) for android automatically. 

## Quickstart 
Download this repo and put it the Vagrantfile under your development path, say /path/to/dev. 
Run vagrant up and install the virtual image.

```bash
cd /path/to/dev
vagrant up
```

It will run and compile the wireshark and related libraries.

When the process finish, it will created a folder at the current path, named `ws_libs`. It contains the 
`libwireshark.so` and it's dependencies. 

You can stop the virtual machine using either command:

```bash
vagrant suspend (suspends the machine)
vagrant halt (stops the vagrant machine)
```

To generate `andoid_pie_ws_dissector`, please run the MakeFile in https://github.com/mobile-insight/mobileinsight-core/blob/dev-6.0/ws_dissector/Makefile
with `HOME=/home/vagrant`.