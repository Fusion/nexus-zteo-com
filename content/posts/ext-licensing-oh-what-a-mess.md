---
title: "Ext Licensing: Oh, what a mess."
description: "Ext Licensing: Oh, what a mess."
slug: ext-licensing-oh-what-a-mess
date: 2008-04-27 09:46:00
draft: false
summary: "When things start smelling \"funny\" in the open-source community, they tend to go to the dogs with the haste of a drunk marching band."
---


[![Lego Soap
Opera](/images/594290795_fb37c77e06_m.jpg)](http://www.flickr.com/photos/liquidx/594290795/
"Lego Soap Opera")When things start smelling "funny" in the open-source
community, they tend to go to the dogs with the haste of a drunk marching
band.

Today's drama is brought to you by your friendly ExtJS community. For those of
you not familiar with [ExtJS](http://extjs.com), it is a professionally made
Javascript library that allows web application developers to create very
elaborate desktop-like applications. Jack Slocum originally started this
project as a YUI extension. That extension being open-source. He's then
regularly improved it by adding support for different building stones such as
JQuery and finally a full-ExtJS solution, reaching ExtJS 2.0. For those of you
who have managed not to fall asleep while reading my ramblings, you already
know that I've used ExtJS myself, for instance when I created the ExtPHP
wrapper.

Where this gets complicated is that Jack decided to license the assets under a
different license, allowing him to retain all rights. I would like to make
very clear that it's **his** work and he can do **whatever he wants** with it.
I am just narrating, here. He also added a clause that supposedly completely
voids the LGPL license if someone attempted to use his work to create a
derivative framework.

After a lot of moaning in the community - to the drum of "that's a GNU
license, man, the whole idea is that you cannot add restrictions!", he decided
to change the LGPL license to a pure GPL one, while retaining a pure
commercial license on the side. I'll bet he thought, at that point, "At least
now things are clear."

Well, that was only the beginning of a real sh*tstorm that threatens to cause
a lot of damage to everyone involved, culminating -fleetingly, to be sure-
with Sanjiv Jivan's scathing [blog
post](http://www.jroller.com/sjivan/entry/my_response_to_jack_slocum). Sanjiv,
if I am correct, wrote a Ext "compiler" for the GWT library, called GWT-Ext -
note that there is another project, apparently endorsed by Jack, that connects
ExtJS and GWT. Sanjiv decided that he would fork the last LGPL release of
ExtJS and start a new project. You may remember that Jack tried to prevent
this by adding a provision in his license agreement.

The crux of Sanjiv's beef with Jack Slocum is this: Jack created a great
product, led people to believe that it was truly open-source when it wasn't,
and doesn't understand open-source licenses. Jack is greedy. Now, the crux of
Jack's beef with Sanjiv is this: Sanjiv created a nice tool based on hits
product, doesn't understand open-source licenses and, oh, is greedy.

So, our protagonists are not talking to each other. This love story was
consumed a long time ago. And potential "corporate" customers, like me, are
revisiting the possibility of building their product on top of pure JQuery
extensions and living happily ever after.  
Now, in a move that would shame any seasoned soap opera writer, a new
character enters left stage. And her name is
[OpenEXT](http://sourceforge.net/projects/openext/). Contrary to what Dion
Almar [wrote](http://ajaxian.com/archives/openext-the-fork), it is not a fork:
the idea is to create patches that can be dropped on top of ExtJS. Now, I am
curious: was Dion right when he posted his own piece on the topic? After all,
things seem to change at a meteoric pace around here.

Anyway, stay tuned for even more implausible developments!

