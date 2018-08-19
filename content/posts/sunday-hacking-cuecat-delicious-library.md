---
title: "Sunday Hacking: Cue:Cat, Delicious Library"
description: "Sunday Hacking: Cue:Cat, Delicious Library"
slug: sunday-hacking-cuecat-delicious-library
date: 2009-06-07 23:32:10
draft: false
summary: "Sunday Hacking is going to be this new and irregular feature, where I blather about how I made my week-end a bit geekier by doing such or such hardware hack. I do not guarantee originality, nor much software-related content. If you're not into that kind of thing, I promise that it shouldn't feel much worse than a flu shot."
---


[![Blue LED.jpg](http://farm1.static.flickr.com/119/265879129_2b6b17edf2_t.jpg)](http://www.flickr.com/photos/17425845@N00/265879129/
"Blue LED.jpg")Sunday Hacking is going to be this new and irregular feature,
where I blather about how I made my week-end a bit geekier by doing such or
such hardware hack. I do not guarantee originality, nor much software-related
content. If you're not into that kind of thing, I promise that it shouldn't
feel much worse than a flu shot.  

  
  



  
I like hacking on Sundays; that's how I ended up with a stack of Wiimotes even
though I did not own a Wii.  
Anyway, I was in the process of sorting my various cables when I found
**her**. And by "her" I mean my USB [Cue:Cat](http://cuecat.com/).  
This gave me an idea: my friend [Tom](http://tomchappell.com/blog/) and I both
swear by [Delicious Library](http://www.delicious-monster.com/). Now, there
are two things you really need to know about Tom:  

  

1. He does not hesitate to spend money when he needs a good quality product
  

2. He is insanely competitive
  

  
Regarding #1: he bought a nice barcode reader because it works better than an
iSight.  
Regarding #2: if I can come up with a cheaper barcode reader, it will totally
feel like victory!

So, I googled "cuecat" and "delicious" and, of course, it's easy to use the
feline with Delicious Library.

**Step #1** : If you do not already have a Cue:Cat, [you need to get one](http://shop.ebay.com/?_nkw=cuecat&_sacat=See-All-Categories). It's very
easy: more than 2 million _Raminagrobis_ were distributed before Digital
Designs' predictable demise (it's one of those times when it's not just
hindsight, that should have been 20/20) -- Make sure you get a USB model.

**Step #2** : Now, to "fix" it! By default, the device was dedicated to
Digital Designs applications and this was achieved through the use of a very
simple protocol (originally described by Steven Satchell)  
[![cuecat before](/images/untitled.png)  
Obviously, this is going to be confusing for programs that expect standard
barcode information.  
  
[![Hmmm...bad kitty!](/images/p1020128.jpg)

Hmmm...bad kitty!

  

[![cuecat surgery](/images/p1020119.jpg)  
All you need if a wife who's a med or a vet student and -- voila! -- you have
a very convenient scalpel that you can use to remove pin #5 of the 8-bit chip
labeled 'HMS91C7316'

[![cuecat surgery detail](/images/p1020126.jpg)  
The circle shows where you need to remove pin #5. The arrow shows which way to
go when counting pins (counter-clockwise)

And that's it! Your _malkin_ will now deliver compatible messages:  
[![cuecat after](/images/untitled-1.png)

Amusingly, it is seen by your Mac as some kind of keyboard (not doubt through
USB-HID); therefore, each scan operation will be an opportunity for your
computer to play the bongos.  
You can check what's happening by scanning a barcode while in TextEdit rather
than Delicious Library.

