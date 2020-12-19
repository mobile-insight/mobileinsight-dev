# Cross-compile Wireshark for Android
This folder provides the vagrant environment to cross-compile 
wireshark(3.4.0) for Android automatically. 

## Quickstart 
Download this repo and put it the Vagrantfile under your development path, say `/path/to/dev`. 
Run vagrant up and install the virtual image.

```bash
cd /path/to/dev
vagrant up ws
```

It will run and compile the wireshark and related libraries.

This vm generates two folders, `ws_lib` and `ws_bin`. 
`ws_lib` contains the `libwireshark.so` and related libraries. 
`ws_bin` contains the binary programs `android_ws_dissector` 
and `android_ws_dissector_pie`.

You can stop the virtual machine with either command:

```bash
vagrant suspend ws (suspends the machine)
vagrant halt ws (stops the vagrant machine)
```

