---
title: "Tools"
description: "Tools"
slug: tools
date: 2012-11-21 09:16:41
draft: false
summary: "TinySU\nTinySU is a very small \"su\" binary, compiled to run on all ARM-based Android devices."
---


## TinySU

TinySU is a very small "su" binary, compiled to run on all ARM-based Android
devices.

It does not interact with SuperUser.apk and thus the user is not prompted to
grant access to their device. You may thus think of it as less "secure" than
the su binary that comes with SuperUser.apk.

On the other hand, TinySU works in every possible situation where its more
complex brethren may not; for instance when automatically rooting a device
(e.g. LV Optimus V)

If you wish to use TinySU in your ROM or rooting application, just drop me a
note :)

[![](/images/download.gif)](/refdirect/?obj=tinysu)

## LG Optimus V Tools

This is a suite of tools that will let you root your LG Optimus V device and,
optionally, flash a new ROM such as CyanogenMod 7.

The zip file contains:

* psneuter, which will temporarily root your device
* TinySU ("su") to add permanent, albeit unmonitored, root
* flash_image, a binary that you run on your phone to flash a recovery image
* recovery.img, a working recovery image
* Debug-FormatSYSTEM.zip, a flashable script that will prepare your phone for a new ROM.

For complete information on the rooting process, please read [this
thread](http://forum.xda-developers.com/showthread.php?t=1070018)

[![](/images/download.gif)](/refdirect/?obj=lgoptimus)

## RescueTime AddTask

A small utility for OS X/Linux, based on Angus Helm's Linux updater.  
Using the command line (hint! Use "Visor Mode") you can add tasks manually to
RescueTime, which is the one thing it doesn't typically let you do.

**Usage (OS X):**  
Expand the archive in ~/Applications  
Copy ~/Applications/rescuetime/CP_TO_USR_BIN/addtask to /usr/bin  
To add a task, type "addtask"  
If you leave the "Name" field blank, a task named "ManualEntry" will be added.

[![](/images/download.gif)](/refdirect/?obj=rescuetime)

