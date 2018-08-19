---
title: "A driver for your Darwin-based keyboard woes"
description: "A driver for your Darwin-based keyboard woes"
slug: a-driver-for-your-darwin-based-keyboard-woes
date: 2008-12-01 01:05:36
draft: false
summary: "I built this driver in 2007, to support Leopard Darwin on my wife's laptop (hmmm where's the \"wink wink nudge nudge\" smiley when you need it?)"
---


I built this driver in 2007, to support ~~Leopard~~ Darwin on my wife's laptop
(hmmm where's the "wink wink nudge nudge" smiley when you need it?)

I am offering a full driver for download, but it's only so that you could use
**my keyboard fix** if you do not currently have an ApplePS2Controller.kext
that support plug-ins.

The point of this driver really is to provide keyboard support for laptops
that see their **built-in keyboard as PS2** \-- ie the vast majority.
Therefore the piece that is really interesting to you is ApplePS2Keyboard.kext
(in ApplePS2Controller.kext/Contents/PlugIns/)

There are other drivers that do just that, out there, but unfortunately many
of them **fail to properly detect the keyboard**.

So, here goes. If you have a laptop running ~~Leopard~~ Darwin but your built-
in keyboard is not working, give this driver a try.

[download#1#image]

ps: Come to think of it, you may find this **kext** useful if you are using a
desktop with a recalcitrant PS2 keyboard as well.

pps: Miracle! After a year of having misplaced the source code, I found it on
a USB stick. It's now [available at
Github](http://github.com/Fusion/applekeyboarddriver/tree/master).

