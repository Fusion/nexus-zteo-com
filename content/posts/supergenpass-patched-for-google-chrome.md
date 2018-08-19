---
title: "SuperGenPass patched for Google Chrome"
description: "SuperGenPass patched for Google Chrome"
slug: supergenpass-patched-for-google-chrome
date: 2009-12-01 03:25:35
draft: false
summary: "I am a huge fan of SuperGenPass. There are so many obvious reasons why it's a great concept that I won't bore you with a rehash of all of them.Unfortunately, in Google Chrome, SuperGenPass chokes on some pages. I do not blame Chrome for that: it's for security reasons."
image: "3e8598f9-a6bb-419f-8fbb-1f6d2e15493e.jpg"
---


[![](/images/2460905893_0c3fc213c5-300x225.jpg)](http://www.flickr.com/photos/rattodisabina/2460905893/)I
am a huge fan of [SuperGenPass](http://supergenpass.com/). There are so many
obvious reasons why it's a great concept that I won't bore you with a rehash
of all of them.  
Unfortunately, in Google Chrome, SuperGenPass chokes on some pages. I do not
blame Chrome for that: it's for security reasons.

I've patched the basic version of SuperGenPass so that it can now work on
those pages. I am not sure that it fixes everything for everybody but I hope
it makes your life easier, like it does mine.

Just **[go to this page](http://www.voilaweb.com/tools/sgpchrome.html)** and
get the patched bookmark.

If you are using a customized bookmark, I am afraid that you will have to
patch it yourself. Here is what the patch looks like:

_Look for_

```javascript
var%20FrameTest=window.frames[i].src;
```

_Replace with_

```javascript
var%20FrameTest=window.frames[i].src;var%20FrameTest=window.frames[i].src;FrameTest=window.frames[i].document.forms;
```

Done!

