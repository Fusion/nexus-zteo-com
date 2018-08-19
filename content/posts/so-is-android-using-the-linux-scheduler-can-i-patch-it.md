---
title: "So, is Android using the Linux scheduler? Can I patch it?"
description: "So, is Android using the Linux scheduler? Can I patch it?"
slug: so-is-android-using-the-linux-scheduler-can-i-patch-it
date: 2010-11-27 04:03:47
draft: false
summary: "These last few days, the Linux world has paid quite a lot of attention to this kernel patch, written by Mike Galbraith.Its purpose is to make your desktop more responsive by grouping your tasks so that they have a better chance at getting their fair share of CPU time when some other task, notably a CPU hog, is running in the background. Lennart Poettering then offered his own solution, which requires no tweak of the kernel itself."
image: "da2f006a-b1c6-4f58-a10a-7ef6cefdbffa.jpg"
---


[![](/images/oldfaithful-300x199.jpg)](http://www.flickr.com/photos/kwamekwame/4643079802/)These
last few days, the Linux world has paid quite a lot of attention to [this kernel patch](http://lkml.org/lkml/2010/10/19/123), written by Mike Galbraith.  
Its purpose is to make your desktop **more responsive** by grouping your tasks
so that they have a better chance at getting their fair share of CPU time when
some other task, notably a CPU hog, is running in the background. Lennart
Poettering then offered [his own solution](http://www.webupd8.org/2010/11/alternative-to-200-lines-kernel-
patch.html), which requires no tweak of the kernel itself.

While Mike's approach adds the concept of tty grouping to
[cgroup](http://www.kernel.org/doc/Documentation/cgroups/cgroups.txt),
Lennart's one consists of grouping every task you launch under your own bash
shell. The latter take actually offers better granularity.

It appears that this tweak just works. Hurray, then.

### So..?

  
On Reddit, the question was asked: [Does any one know if this linked linux speed patch will work on an ( linux based) android phone?](http://www.reddit.com/r/linux_devices/comments/ebat7/does_any_one_know_if_this_linked_linux_speed/)

I've seen several replies that were quite off the mark so I added my own (I
like being wrong too!)  
Allow me to expand on it a little here:

[![](/images/nerd.jpg)](http://www.flickr.com/photos/bayat/7491311/)_"android
has its own custom scheduler"_  
Actually, it appears that **it does not** :  
  
  
Out of curiosity, I did a line-by-line comparison of the scheduler code
between three kernels: Linux stock 2.6.32.26, Android snapshot branch and HTC
Incredible MR3 2.6.32.  
Well, they are all different. But the question is: how different? In this
case, not different enough to be seen as "different schedulers."

Overall, the three branches use the fair scheduler. With these differences:

* Unsurprisingly, the Android code cares about task freezing.

* On the Android side, the real-time portion does not let you add a task to the head of the queue

* It seems more concerned with proper IRQ handling

* The Incredible code aligns its timing on the clock rather than raw CPU time, again -- I suppose -- out of care for overall sync., including IRQ timing (It also pushes the logic a bit further by making sure that it uses the high-res timer)

* All tasks' iowait time is included in **init** 's own iowait time. My guess is for statistics purpose; possibly including battery life.

* Tasks enqueuing is simplified to ignore the "migrate" flag. However, load balancing is implemented and CPUs can be found not eligible for process migration. If they are, the **same algorithm** is used as in the stock kernel.

* When attaching a task, Android does not immediately check for ownership. It does, however, make up for this by testing that the process has the [CAP_SYS_ADMIN Posix capability](http://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/capfaq-0.2.txt).

### Oh, how exciting.

  
So, what does this mean for Android? Can we just tweak a phone as we would a
desktop machine?  
Unfortunately, **the answer is no**.  
Even though cgroups are alive and well in our phones, you do not log in on
different ttys ([best concise-yet-accurate comment winner](http://www.reddit.com/r/linux_devices/comments/ebat7/does_any_one_know_if_this_linked_linux_speed/c16u6mz)),
which means that the kernel patch would not really help. And we do not have a
bash shell that we could rely on to apply Lennart's tweak.  
OK, allow me to add a **caveat** : we may be able to group the applications
you get from the market on one side and the phone's system applications on the
other. This would be a different tweak but in the same spirit.  
This would not do anything to prevent market application "A" from starving
market application "B", though.  
As far as I can tell, Android does not see strong enough a difference between
activities and services for it to be useful either.

### Need more cowbells!

  
Note, too, that while Android's code is ready to handle load balancing, **this
would not helps us much**. Let's have a look a the three current top sellers:  
[table id=1]  
Ouch. Not much to balance against. This should change when the next generation
of SnapDragon is released as it should have multiple cores.

