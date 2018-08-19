---
title: "Mount a recalcitrant .dmg file"
description: "Mount a recalcitrant .dmg file"
slug: mount-a-recalcitrant-dmg-file
date: 2009-06-18 00:29:56
draft: false
summary: "I have no idea why but sometimes a .dmg file will just-not-mount.For instance I just downloaded the latest PostBox from http://postbox-inc.com/ and the silly little image will *not* cooperate."
image: "64ef562f-d60c-4fcf-b7e3-0d3d49a0af08.jpg"
---


[![pzizz](/images/256597423_0ed45180a9_t.jpg)](http://www.flickr.com/photos/35237092727@N01/256597423/)I have no idea why but sometimes a .dmg file will just-not-mount.  
For instance I just downloaded the latest PostBox from <http://postbox-inc.com/> and the silly little image will *not* cooperate.

My amazingly quick'nt dirty workaround? **Convert it to another format file**
(using the command-line)!

```bash
hdiutil convert postbox-1.0b12-mac.dmg -format UDTO -o postbox_iso
```

