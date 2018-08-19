---
title: "Cross-Compile Android (CM7) on OS X"
description: "Cross-Compile Android (CM7) on OS X"
slug: cross-compile-android-cm7-on-os-x
date: 2011-05-11 01:54:45
draft: false
summary: "This is your \"up-to-date 5 minutes ago\" guide on how to build CyanogenMod 7 using your Mac. Check the date: 05/10/2011.Note that, obviously, these instructions should also help you with building other ROMs."
image: "a5e727f8-f73a-4274-b4dc-4b86fba19238.jpg"
---


![](/images/Download-CyanogenMod-7-RC2-300x290.jpg)This is
your "up-to-date 5 minutes ago" guide on how to build CyanogenMod 7 using your
Mac. Check the date: **05/10/2011**.  
Note that, obviously, these instructions should also help you with building
other ROMs.

Let's start with **the good news** :

* [This guide](http://wiki.cyanogenmod.com/index.php?title=Compile_CyanogenMod_for_Vision_%28Mac%29), found in the Cyanogen Wiki, still works (mostly) so we will follow it

* And the guide would work with any CM7 target. Simply use your own target name; e.g. for Droid Incredible, replace 'vision' with 'inc'

  
Now, ahem, **the bad news** :  
You will need to do a bit more work than what's in that guide.

Namely:

The most recent version of XCode, the one you paid for, will fail with this
message:

> ld: _illegal text reloc to DwarfCUImpl_

  
**Fix:**

Download an older, compatible version. Oh, and it's free too. I found out
(thanks Newsgroups!) that 3.2.4 could very well be the last version of XCode
to work properly.  
Get it from [this page](http://connect.apple.com/cgi-
bin/WebObjects/MemberSite.woa/wo/5.1.17.2.1.3.3.1.0.1.1.0.3.3.3.3.1). That's
the page you get when you go to [connect.apple.com](http://connect.apple.com)
and select 'Developer Tools'.  
You will not find this page when visiting developers.apple.com!

After downloading, install the package. You can install it next to your
shinier XCode 4 by selecting an alternate destination on the 'Installation
Type' screen. I installed it in /Developer324

I created this short script to build CM7. It replaces the guide's 'Compile'
section:

```bash
cd /Volumes/CyanogenModWorkspace/android/system/  
sudo mv /Developer /Developer.new  
sudo mv /Developer324 /Developer  
time make -j`sysctl -an hw.logicalcpu` bacon  
sudo mv /Developer /Developer324  
sudo mv /Developer.new /Developer
```

If you build now, you will, however, get another error:

> ASSERTION FAILURE external/elfcopy/elfcopy.c:932: [ranges[i].start >= last_end]

This fix is much faster: open external/elfcopy/elfcopy.c and add this before
line 928:

```c
sort_ranges(section_ranges);
```

Then...oh, wait. That's it. Run the make script and you're done.

