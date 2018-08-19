---
title: "Android: Create a \"lite\" version of your application"
description: "Android: Create a \"lite\" version of your application"
slug: android-create-a-lite-version-of-your-application
date: 2010-10-20 04:10:41
draft: false
summary: "\nLike many Android developers, I recently realized that pushing a \"lite\" version of my application to the Android Marketplace would improve my application's visibility."
image: "9f879eda-1f5a-4fd8-90ed-075ab4f25a9e.jpg"
---
![](/images/4408737402_e9cd02c8ff_z-200x300.jpg)

Like many Android
developers, I recently realized that pushing a "lite" version of my
application to the Android Marketplace would improve my application's
visibility.

(My application:
[SplitAndTip](http://www.appbrain.com/app/splitandtip/com.voilaweb.mobile.splitcheck);
[light version](http://www.appbrain.com/app/splitandtip-lite/com.voilaweb.mobile.splitandtiplite))

It's not as easy as it seems because Android uses your application's main
class' full path to identify it. Therefore, simply compiling two versions of
the same source code with, say, two different certificates -- the Adobe
approach -- does not work.

You need to use different package names, potentially different databases,
depending on your preference, etc.

When I was looking for a solution I read [this article](http://blog.donnfelker.com/2010/08/05/howto-android-full-and-lite-versions/) with great interest.  
It relies on Project Libraries and you need to re-organize your code into its
own library, then simply invoke it from two different packages.  
It's a bit or work but nothing too horrible using Eclipse's refactoring
abilities.

Unfortunately, what I realized after playing with it for a few hours is that
this method is only available to you if you only care about devices running
Froyo (2.2)  
Personally, it is an absolute show stopper as I write my applications to be
compatible with versions of the Android SDK dating back to version 1.5. Only
supporting Froyo, according to [Google's own figures](http://developer.android.com/resources/dashboard/platform-versions.html), means that your application is unavailable totwo-thirds of the
Android market.

My approach, then, was to write a small script that will create a copy of my
original application and modify what needs to be modified to turn this copy
into a light version.  
I never modify the light version directly; instead I added a test to the
original application that will be used at runtime to decide which application
type we are running. Here it is, ready for consumption:

```java
this.lite = context.getPackageName().toLowerCase().contains("myliteapp");
```

Obviously you will want to replace "myliteapp" with your own package name.

And here is the (Bash) script where all the magic takes place:

[download id="4"]  
.

