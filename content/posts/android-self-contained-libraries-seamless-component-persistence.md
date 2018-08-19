---
title: "Android: self-contained \"libraries,\" seamless component persistence"
description: "Android: self-contained \"libraries,\" seamless component persistence"
slug: android-self-contained-libraries-seamless-component-persistence
date: 2011-12-31 09:33:02
draft: false
summary: "\nSlider by Yamanaka Tamaki"
image: "50dbafdd-45db-4290-b8df-ef8646a496f6.jpg"
---
[![](/images/1402365_aa34336932_z-300x225.jpg)](http://www.flickr.com/photos/tamaki/1402365/)

Slider by Yamanaka Tamaki

  
Hello. Today, I am going to write about persisting a component's values
simply, using a hidden dialog; and how to turn a set of classes and assets
into a "library" that other developers will not need to refactor prior to
using it.

A few months ago, needing an Android widget that would let me select values
"naturally" using one or more sliders, I found Daniel Berndt's excellent
[DateSlider](http://code.google.com/p/android-dateslider/).

I added a few functionalities to it:

1\. Cohabitation of sliders in a tabbed interface  
2\. An "Enumeration" type of slider (so, not necessarily dates anymore!)  
3\. Sliders can now belong to a dialog or be embedded in an activity (ala
progress bar)  
4\. Now truly self-contained in ajar zip file.

For more information on the new features, have a look at the additional
[readme file](https://github.com/Fusion/DateSlider/blob/develop/CFR_README) I
created.

For those of you who have tried to play with these concepts, you will
immediately identify a few painful items here:

1\. How can a component be a dialog's content, or not, at will?  
2\. How can a single component automatically persist its values, for instance
over an orientation change?  
3\. How do you include all assets in a jar file when the SDK dislikes that?

These are the challenges that I had to address. I exchanged a few emails with
Daniel about pushing these changes back to DateSlider's main branch but I
guess we've both been working on other things since July.

The source code is, of course, available on
[GitHub](https://github.com/Fusion/DateSlider) so for in-depth understanding,
I would recommend having a look at the commit history.

Regarding the three annoyances mentioned above:

**How can a component be a dialog's content, or not, at will?**

This was the easiest one. I simply refactored the parent class (DateSlider) so
that it is now a child of LinearLayout rather than Dialog.  
This object is now instanced normally, and two methods, _asDialog()_ and
_asEmbed()_ , allow you to get the component properly wrapped.

**How can a single component automatically persist its values, for instance
over an orientation change?**

The idea I had is a bit appalling but not too bad, in my opinion: dialogs come
with their own _onSaveInstanceState()_ method, which is automatically invoked
when your application is about to be paused. That is, as long as this dialog
was displayed using _showDialog()_ rather than directly realized in your code.
This takes care of dialogs.  
Components found in a regular activity, however, have no such method. So, what
to do?  
My approach is to use an inner class representing an invisible dialog --
conveniently called FauxDialog -- that sits next to the slider, and that
dialog is the one whose methods get invoked for saving and restoring your
component's state.

That invisible dialog's style is:

    
    
        

and its save method can be as simple as:

```java
@Override  
public Bundle onSaveInstanceState() {  
    Bundle savedInstanceState = super.onSaveInstanceState();  
    if (savedInstanceState==null) savedInstanceState = new Bundle();  
    savedInstanceState.putSerializable("time", getTime());  
    return savedInstanceState;  
}  
```

**How do you include all assets in a jar file when the SDK dislikes that?**

This one is actually VERY simple, thanks -- again -- to the guys at
[CommonsWare](http://commonsware.com/).

They provide an incredibly convenient file called
[ParcelHelper.java](https://github.com/Fusion/DateSlider/blob/develop/src/com/commonsware/cwac/parcel/ParcelHelper.java)  
This file allows developers to invoke a package's resources through a class
called, obviously ParcelHelper.

Therefore, all I had to do to turn DateSlider into a usable jar library, was:

1\. Create a class called SliderController, that uses the singleton pattern to
return an instance of ParcelHelper (I know! A singleton! Where is my
pitchfork?)  
2\. Replace direct references to resources, such as

```java
R.styleable.ScrollLayout_childWidth
```

with their helper counterpart:

```java
SliderController.instance().getParcel().getStyleableId("ScrollLayout", "childWidth")
```

3\. Rename the resources, prefixing them a string specified in ParcelHelper's
_getParcel()_ method  
4\. And finally, after generating the jar file, store it into a zip file along
with its own resources (i.e. icons and layouts)

Now, any developer who wishes to use this "library" can simply extract this
zip file at the root of their project and the jar file and the renamed
resources will be made available to their own code.

As usual, feel free to ask questions if there are things that make little
sense to you in this fairly succinct write-up.

