---
title: "Android StatusBar Height, the cautious way"
description: "Android StatusBar Height, the cautious way"
slug: android-statusbar-height-the-cautious-way
date: 2011-11-08 08:47:28
draft: false
summary: "A lot of applications expect the status bar to be at the top of your device's screen. It's true in most cases so their developers are somewhat justified in making this assumption.However, with more and more tablets on the market, this is becoming an increasingly dangerous assumption."
image: "064c4b6d-1ea6-4a6f-af82-0a30099fc33e.jpg"
---


[![](/images/5587611705_2aa6dfbe31_z-300x200.jpg)](http://www.flickr.com/photos/asirap/5587611705/sizes/z/in/photostream/)A
lot of applications expect the status bar to be at the top of your device's
screen. It's true in most cases so their developers are somewhat justified in
making this assumption.  
However, with more and more tablets on the market, this is becoming an
increasingly dangerous assumption.

Also somewhat dangerous: the notion that your status bar's height will be
(your visible area's height - zero). Google never made any commitment that the
status bar will always start at pixel zero.

So, here is how I do it:

```java
Rect outerRect = new Rect();
Rect usableRect = new Rect();
Window window= Home.getInstance().getWindow();
window.getDecorView().getGlobalVisibleRect(outerRect);
window.getDecorView().getWindowVisibleDisplayFrame(usableRect);
statusBarHeight = usableRect.top - outerRect.top;
// Sometimes, status bar is at bottom...
int bottomGap = outerRect.bottom - usableRect.bottom;
if(bottomGap > statusBarHeight) {
    statusBarHeight = bottomGap;
}
```

