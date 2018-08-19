---
title: "No doubt about that: we are about to hear again about how Android is an inherently insecure OS. It does..."
description: "No doubt about that: we are about to hear again about how Android is an inherently insecure OS. It does..."
slug: No-doubt-about-that-we-are-about-to-hear-again-about-how-Android-is-an-inherently-insecure-OS-It-does
date: 2014-08-24T21:51:06.538Z
draft: false
summary: "No doubt about that: we are about to hear again about how Android is an inherently insecure OS. It does not matter that the same algorithm would likely work on other mobile devices or, for that matter, any OS.<br /><br />It&#39;s a clever attack. Well, the &quot;theft&quot; bits of it (invisible activity or photo hijacking) are pretty standard but the first part, the activity detection one, is pretty smart.<br />Note that it&#39;s nothing new though; simply a mix of computer forensics and a timing attack.<br /><br /><b>So, how do you protect your data?</b><br /><br />In short: it&#39;s not too bad. Read on.<br /><br />Bad news: not much you can do, at this point, to prevent the &quot;active&quot; part of the attack: it is easy to open a transparent activity; as opposed to a transparent screen overlay, which requires a special set of permissions that MIUI, for instance, denies by default.<br /><br />Conceivably, though, if your phone is rooted, it would be fairly trivial to write an Xposed module that displays a Toast like: <br /><br />    * switching to app_blah *<br /><br />Good news, though, regarding the detection bit: as if often the case, I believe that this experiment can only be reproduced in a tightly controlled environment.<br />If your device has a different screen resolution/density; if you use an alternate keyboard (in some cases); if you are using a customized ROM; (insert here other factors that would change your activity&#39;s signature); then you are now dramatically lowering the odds that this exploit will work at all.<br />These videos are impressive but keep in mind that they were made using the researchers&#39; own devices, not <i>your</i> device.<br /><br />I am not saying that you are safe, though. I am simply pointing out that this is definitely <b>not</b> a trivial attack and I am sure that as soon as my fellow XDA-ers start giving it some thoughts, a workaround will become available.﻿"
image: "2a6d39f6-e4b6-4c28-aa98-829f379428ae.png"
---

http://www.cs.ucr.edu/~zhiyunq/pub/sec14_android_activity_inference.pdf

No doubt about that: we are about to hear again about how Android is an
inherently insecure OS. It does not matter that the same algorithm would
likely work on other mobile devices or, for that matter, any OS.  
  
It's a clever attack. Well, the "theft" bits of it (invisible activity or
photo hijacking) are pretty standard but the first part, the activity
detection one, is pretty smart.  
Note that it's nothing new though; simply a mix of computer forensics and a
timing attack.  
  
 **So, how do you protect your data?**  
  
In short: it's not too bad. Read on.  
  
Bad news: not much you can do, at this point, to prevent the "active" part of
the attack: it is easy to open a transparent activity; as opposed to a
transparent screen overlay, which requires a special set of permissions that
MIUI, for instance, denies by default.  
  
Conceivably, though, if your phone is rooted, it would be fairly trivial to
write an Xposed module that displays a Toast like:  
  
> switching to app_blah 
  
Good news, though, regarding the detection bit: as if often the case, I
believe that this experiment can only be reproduced in a tightly controlled
environment.  
If your device has a different screen resolution/density; if you use an
alternate keyboard (in some cases); if you are using a customized ROM; (insert
here other factors that would change your activity's signature); then you are
now dramatically lowering the odds that this exploit will work at all.  
These videos are impressive but keep in mind that they were made using the
researchers' own devices, not _your_ device.  
  
I am not saying that you are safe, though. I am simply pointing out that this
is definitely **not** a trivial attack and I am sure that as soon as my fellow
XDA-ers start giving it some thoughts, a workaround will become available.


