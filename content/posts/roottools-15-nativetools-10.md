---
title: "RootTools 1.5, NativeTools 1.0"
description: "RootTools 1.5, NativeTools 1.0"
slug: roottools-15-nativetools-10
date: 2011-11-22 02:51:52
draft: false
summary: "I am both happy and relieved to announce RootTools 1.5 and NativeTools 1.0."
image: "32406981-a6c2-40d9-b78d-912f76099f04.png"
---


![](/images/project_roottools_thumb.png)I am both happy and
relieved to announce [RootTools 1.5](http://code.google.com/p/roottools/) and
[NativeTools 1.0](https://github.com/Fusion/NativeTools).

**What's new in RootTools 1.5?**

Mostly build improvements: a new AndroidManifest.xml file for easier building
in Eclipse; example version number is now taken from the manifest file; new
makejar.ant for building and zipping the library.

This version also offers a new function: _isNativeToolsready()_. This function
does a silent install/check for correct install of the nativetools binary (you
could conceivably use your own binary as you provide your resource id to the
function)

**What is NativeTools 1.0?**

It's the piece that has been, until now, missing from the equation. I
recommend reading readme.md for more information but the short version is that
NativeTools provide C/C++ functions in a convenient package that you can
invoke to perform all sorts of operations (retrieve partition size, get file
content, etc) without having to worry about the current device's shell
idiosyncrasies.

Its other advantage is that is runs much, much faster that performing the same
operations recursively in Java.

