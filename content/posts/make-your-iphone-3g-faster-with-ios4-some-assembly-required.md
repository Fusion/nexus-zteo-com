---
title: "Make your iPhone 3G faster with iOS4 (some assembly required)"
description: "Make your iPhone 3G faster with iOS4 (some assembly required)"
slug: make-your-iphone-3g-faster-with-ios4-some-assembly-required
date: 2010-07-31 09:34:08
draft: false
summary: "Today, I am venturing outside my usual programming and open-source path and I am going to share my experience speeding up my iPhone with you.I am not going to write a long article where I copy/paste what everybody else has already written about how slow iPhone 3G's can get when running iOS4. It is now a well established fact.Rumor has it, iOS4.1 should really make your iPhone faster."
image: "be493083-9dc0-4bd8-8efd-8acf21508e55.jpg"
---


![](/images/iphone-3g-twice-as-fast-300x228.jpg)Today, I am
venturing outside my usual programming and open-source path and I am going to
share my experience speeding up my iPhone with you.  
I am not going to write a long article where I copy/paste what everybody else
has already written about how slow iPhone 3G's can get when running iOS4. It
is now a well established fact.  
Rumor has it, iOS4.1 should _really_ make your iPhone faster.

In the meantime, here is what I did. Note that the first two steps are already
abundantly documented all over the internet; a good read can be found at
<http://www.roughlydrafted.com/2010/07/07/how-to-speed-up-your-
iphone-3g-running-ios4/>.

1\. Force your iPhone to rebuild its internal databases  

[![](/images/1354-291x300.jpg)](http://www.iclarified.com/entry/index.php?enid=368)

Courtesy: iClarified

Simply rebooting your handset does just that: reboot. However, performing a
complete reboot -- or "hard reset" -- forces it to actually clean up and
rebuild all sorts of data structures. The benefit is twofold: less fragmented,
they become faster to access. And, if any of your applications seems keen to
crash -- for reasons other than the obvious "out of memory" error -- this
could be due to a corrupt database. A hard reboot should fix that.

To perform a hard reboot, hold down both the sleep button and the home button
until the phone turns off, then back on -- that's when the Apple logo shows
up.

For reasons beyond my comprehension, you may need to perform multiple hard
reboots: usually two or three. I have no idea whether this is just a
superstitious belief or there is an actual technical explanation for that. It
just seems to help.

2\. Disable all Spotlight searches  
 
![](/images/IMG_0216-200x300.png) Noticed how Spotlight can
make your Mac slower? Well, the problem is compounded on your underpowered
iPhone. I have observed a tremendous speed bump after disabling all indexing.

Disable Spotlight by opening the "Settings" application, then going to
_General > Home Button > Spotlight search_and deselecting all search types.

  
.  
3\. Hacky hack hack  
 
This one is not for the faint of heart. It should typically not cause your
phone to spontaneously combust, but it requires some toying with the phone's
internals. Therefore, you need a jailbroken phone.  
Note, however, that it does not install any new software on your phone. That's
good news if you are -- justifiably so -- worried about uploading anything
from an unknown party to your handset.

Have a look at [this forum thread](http://forums.qj.net/developement-hacks-
jailbroken-software/168817-ioverhellclock-rev-3-0063-7-a.html). You can
download a file that contains two interesting hacks: first, a hack to
overclock your phone. Then, a hack to enable virtual memory paging to the
phone's flash.

Let's get something out of the way immediately: I do not believe that the
first hack does anything for you. It almost certainly provides no
overclocking. It simply attempts to tell your phone to be less prone to slow
down under some conditions. Both hacks use .plist files, therefore, as I said
before, no trojan is installed on your phone. However, this also means that
they can be easily inspected and I found nothing in the "overclock"-related
one, that would speed up anything. It may, at worst, instruct your phone not
to slowdowns when you are not doing anything with it, thus somewhat worsening
its battery life. Amusingly, it contains many directives that have nothing to
do with your iPhone, such as what to do when the lid is open(?) or which video
card to use(!) but, to be fair, the same directives are found in the original
.plist on your phone.

![](/images/com.apple_.dynamic_pager.plist_.jpg)  
The new paging policy as defined in the second .plist file is much more
interesting indeed. In a nutshell: it introduces your handset to the joys of
swapping in and our of memory. When a program is pushed to the bottom of the
phone's "to-do" list, the memory pages that belong to that program can be
"swapped out" the the flash, therefore out of the regular execution memory.  
With this policy in place, even if your iPhone insits on loading Mail when
opening the Maps application, for instance, the Mail app, running in the
background, will be quickly removed from dynamic memory and your front
application will be able to use much more memory. Suddenly, applications that
used to be killed by a fairly touchy "out of memory" watchdog become much more
stable.  
And this is all done by running a memory pager that is [already available on
your
phone](http://developer.apple.com/mac/library/documentation/Darwin/Reference/ManPages/man8/dynamic_pager.8.html)!

There are, of course, some drawbacks but I estimate that they are minor:
sometimes your phone will freeze while trying to figure out where a chunk of
virtual memory should be. Using a tool such as "Backgrounder" is not
recommended as it will only make the pager work harder. You will, in theory,
shorten the life of your phone, but this should take years since we are
talking about flash memory failing after millions of read/write operations,
each operation only performed when necessary. It is very likely that you will
grow bored of your old iPhone 3G before its flash memory gets impacted at all.

In summary: install **com.apple.dynamic_pager.plist** , forget
com.apple.SystemPowerProfileDefaults.plist!

I setup this hack on my phone weeks ago and I have to say that my overall user
experience has greatly improved. Of course, I hope iOS4.1 is the holy grail
that was described to me by some enthusiastic Apple fans.

