---
title: "Google+ on your desktop/in Safari + user script, just working"
description: "Google+ on your desktop/in Safari + user script, just working"
slug: google-on-your-desktopin-safari-user-script-just-working
date: 2011-07-25 01:32:52
draft: false
summary: "In this post:"
---


In this post:

* Google+ on your Mac, using its own credentials

* Google+ as its own desktop app, with a nice icon

* Using a complex GreaseMonkey script in Safari or Fluid

![](/images/g-plus-icon-150x150.png)I really like Google+
but I have more than one Google account so it was a pain to use because
Google's **cookies** are shared among all Google services and I had to
constantly switch accounts.  
I decided to turn it into **its own application** , with its own cookies.  
I could have run it in a different browser, such as Opera, but it seemed a tad
overkill.

So, I finally decided to send some money Todd Ditchendorf's way and spend the
"outrageous" $4.99 required for [a full version of
**Fluid**](http://fluidapp.com/), the application that turns web pages into
their own **desktop application**.  
I did not use Prism because it seems to be all but abandoned. I did not use
Bazinga or an automator script because both share their cookies with Safari,
which Fluid's full version offers not to.

After downloading and registering Fluid, I created an application that load
_https://plus.google.com_  
I gave it a nice **icon** thanks to Sean McCabe's vector set, [available for
free in his blog](http://boldperspective.com/2011/free-google-plus-icon-
vector/).

I could have declared victory at that point but I wanted to perform some
customization; Fluid, like Safari, understands a subset of the **GreaseMonkey
API** so that shouldn't be too difficult (Safari requires
[GreaseKit](http://8-p.info/greasekit/) or
[NinjaKit](https://bitbucket.org/os0x/ninjakit/overview))

Jerome Dane wrote a great "G+ Tweaks" script, available at
[userscripts.org](http://userscripts.org/scripts/show/106166). Unfortunately,
it uses a bit too much of GreaseMonkey's built-in power and wouldn't work at
all in Fluid.

**Issues** :

1. The script tries to load external JavaScript using the _require_ command (not available)

1. It uses GreaseMonkey functions, such as GM_setValue(), that Fluid does not understand

I worked around (1) the ugliest way possible: I copy/pasted the external
Javascript in the script itself.  
As it turns out, it is not as bad as you may think: GreaseMonkey does not
reload 'required' scripts dynamically; it merges them internally at
installation time, which means that we are doing something very similar.

And (2) was a simple matter of adding a few bogus functions: a user called
aeosynth [posted a short version](http://userscripts.org/topics/41177) of
those missing functions on userscripts.org's forums.

And now, if you are feeling **brave** enough, you can view the whole script by
clicking the link below. You can copy and paste it into Fluid's scripts
editor, with the pattern '*plus.google.com*'

**[The script](http://nexus.zteo.com/wp-content/uploads/gplustweaksscript.txt)**

