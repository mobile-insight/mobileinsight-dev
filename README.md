Automated Deployment for MobileInsight Development Environment
==========


## Introduction

This repo contains a `Vagrantfile` for automated deployment for [MobileInsight](http://www.mobileinsight.net) development. It configures a Ubuntu 16.04 virtual machine contains MobileInsight repos using Vagrant and VirtualBox. It installs `mobileinsight-core`, `mobileinsight-mobile` and `python-for-android` on the VM, so that you can login and perform offline analysis of cellular traces, and compile the mobile version of MobileInsight.

## Quickstart

Download this repo and put it the `Vagrantfile` under your development path, say `/path/to/dev`. Run `vagrant up` and install the virtual image (depending on the network and CPU speed, the installation may take half hour or longer.). 

	git clone https://github.com/mobile-insight/mobileinsight-dev.git /path/to/dev
	cd /path/to/dev
	vagrant up

It will run and compile a MobileInsight apk, and run an offline MobileInsight analysis example at the end (you should be able to see the decoded messages).

When the process finish install and returns the shell, a MobileInsight app is already compiled and copied to your path (`/path/to/dev`). You can install it on supported Android phone and try it out immediately using `adb`.

	adb install MobileInsight-5.0.0-debug.apk

You can stop the virtual machine using either command:

	vagrant suspend (suspends the machine)
	vagrant halt (stops the vagrant machine)

## Customize MobileInsight

To log into the virtual machine, use the following command

	vagrant up (if the VM has been stopped)
	vagrant ssh

All MobileInsight related repos are under `/home/vagrant/mi-dev` folder, which you can access by

	cd mi-dev

The `/vagrant` folder in VM is a special folder. It is the synced folder between the VM and your host machine, see more details [here](https://www.vagrantup.com/docs/synced-folders/).

### Modify mobileinsight-core codes

When you modify the [`mobileinsight-core`](https://github.com/mobile-insight/mobileinsight-core) codes, you can locally debug it without commiting to GitHub.

First, apply the local debug patch to `python-for-android` and reinstall:

	cd ~/mi-dev
	patch -p1 < p4a.patch
	cd python-for-android
	sudo python setup.py install

Next, modify `mobileinsight-core` codes as needed, and then reinstall:

	cd ~/mi-dev/mobileinsight-core
	./install-ubuntu.sh

### Modify mobileinsight-mobile codes

If you wish to add your own plugin and compile it into the MobileInsight apk, you may put your plugin folder under the `mobileinsight-mobile/app/plugins/` folder.
For details on how to write the plugin, please refer to the [tutorial](http://www.mobileinsight.net/tutorial-plugin.html) on the MobileInsight website.

To compile a new apk, run make command again:

	make apk_debug

If you wish to incorporate the changes from the `mobileinsight-core` codes as well, you need to clean and recompile the distribution first:

	make clean_dist
	make dist

## How to Contribute

We love pull requests and discussing novel ideas. You can open issues here to report bugs. Feel free to improve MobileInsight and become a collaborator if you are interested.

The following Slack group is used exclusively for discussions about developing the MobileInsight and its sister projects:

+ Email: support@mobileinsight.net

For other advanced topics, please refer to the wiki and the [MobileInsight website](http://www.mobileinsight.net).