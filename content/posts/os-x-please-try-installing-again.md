---
title: "OS X: “Please try installing again”"
description: "OS X: “Please try installing again”"
slug: os-x-please-try-installing-again
date: 2007-03-24 22:29:00
draft: false
summary: "It's like this message has become a feature of OS X."
---


It's like this message has become a feature of OS X.

You download a .dmg, double-click and expect that all your files should be an
exact copy of the original install files. And yet, sometimes, you get stuck
with this message.

Here is a very simple fix that works 90% of the time: make sure that your
post-install script can be executed!

Open a shell window, go to where your package is, and type:

```bash
chmod a+x yourpackage.pkg/Content/Resources/postinstall
```

Of course, replace 'yourpackage,pkg' with the package's actual name.

