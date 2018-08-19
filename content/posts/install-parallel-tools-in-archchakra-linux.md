---
title: "Install Parallel Tools in Arch/Chakra Linux"
description: "Install Parallel Tools in Arch/Chakra Linux"
slug: install-parallel-tools-in-archchakra-linux
date: 2012-02-13 04:08:14
draft: false
summary: "As niche posts go, I think this one may take the cake since it is about my experience installing Parallel 7's tools in a Chakra Linux guest (of the venerable Arch family)"
image: "f7b2f8de-d93f-4170-960c-d0f9a7c386f5.jpg"
---


![](/images/chakra-project.jpg)As niche posts go, I think
this one may take the cake since it is about my experience installing Parallel
7's tools in a Chakra Linux guest (of the venerable Arch family)

Let me begin with pointing out that there are no Parallel Tools for
Arch/Chakra but you can still make this work.  
  

  
**What you need**

* Parallels 7

* Chakra Linux

* Kernel 3.2



**Let's do this**

1\. On your host, select [cfrbc]Install Parallel Tools[/cfrbc]

2\. Shell time! You may first need to mount Parallel Tools manually.

```bash
sumount /dev/cdrom /mnt
```

  
3\. Let's make a copy of the tools and patch it for kernel 3.2.

```bash
mkdir -p ~/Tmp/PT
cd ~/Tmp/PT
cp -r /mnt/* .
cd kmods
tar zxvf prl_mod.tar.gz
vi prl_eth/pvmnet/pvmnet.c
Replace .ndo_set_multicast_list with .ndo_set_rx_mode
tar zcvf prl_mod.tar.gz prl_eth prl_fs prl_fs_freeze prl_pv prl_tg dkms.conf Makefile.kmods
```

  
4\. And finally, let's run the installer (fingers crossed!)

```bash
cd ..
export def_sysconfdir=/etc/rc.d
./install
```

You may or may not have to set correct the resolution in
**/etc/X11/xorg.conf**. Personally I added "1920x1080" logged out, logged back
in...it just worked.

Note that all the host's shares can be found in **/media/psf/**

