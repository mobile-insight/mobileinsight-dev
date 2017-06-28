Automated Deployment for MobileInsight Development Environment
==========


## Introduction

This repo contains a `Vagrantfile` for automated deployment for [MobileInsight](http://mobileinsight.net) development. It configures a Ubuntu 16.04 virtual machine contains MobileInsight repos using Vagrant and VirtualBox. It installs `mobileinsight-core`, `mobileinsight-mobile` and `python-for-android` on the VM, so that you can login and perform offline analysis of cellular traces, and compile the mobile version of MobileInsight.

## Quickstart

Download this repo and put it the `Vagrantfile` under your development path, say `/path/to/dev`. Run `vagrant up` and install the virtual image (depending on the network and CPU speed, the installation may take half hour or longer.). 

	cd /path/to/dev
	wget https://github.com/mobile-insight/mobileinsight-dev/archive/v1.0.tar.gz
	tar -xf v1.0.tar.gz mobileinsight-dev-1.0/Vagrantfile
	mv mobileinsight-dev-1.0/Vagrantfile .
	rm -r mobileinsight-dev-1.0
	vagrant up

It will run and compile a MobileInsight apk, and run an offline MobileInsight analysis example at the end (you should be able to see the decoded messages).

When the process finish install and returns the shell, a MobileInsight app is already compiled and copied to your path (`/path/to/dev`). You can install it on supported Android phone and try it out immediately using `adb`.

	adb install MobileInsight-3.0.0-debug.apk


## How to Contribute

We love pull requests and discussing novel ideas. You can open issues here to report bugs. Feel free to improve MobileInsight and become a collaborator if you are interested.

The following Slack group is used exclusively for discussions about developing the MobileInsight and its sister projects:

+ Dev Slack Group: https://mobileinsight-dev.slack.com

For other advanced topics, please refer to the wiki and the [MobileInsight website](http://mobileinsight.net).
