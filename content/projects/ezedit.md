---
title: "ezEdit"
description: "ezEdit"
slug: ezedit
date: 2012-11-21 09:16:36
draft: false
summary: "ezEdit is a very unintrusive script. It serves two different purposes:"
---


ezEdit is a very unintrusive script. It serves two different purposes:

1. Work as a mini-CMS that you can add to your existing website. 
2. Work as a prototyping tool, to see "what if:" what would happen if you modified a page's content

![](/images/ezedit_google.png)

### ezEdit as a mini-CMS

ezEdit can be installed by dropping in place two files: _ezedit.js_ and
_ezedit.php_.  
Including ezEdit in your existing web pages is as simple as:

    
    
    <script src="ezedit.js"></script>

This will load the short bootstrap code that will then be able to load an
online editor and communicate with the back-end (ezedit.php)  
When submitting a modification, it will be sent to ezedit.php, which will in
turn update the web page being edited.

### ezEdit as a mock-up tool

All you need to do is upload _ezedit.js_ and include it in your web page as
described earlier. You can now edit any part of your web page and see how this
edit would impact your page overall appearance.

### ezEdit as a bookmarklet

This is pretty much the same feature as the "mock-up" one, save for a couple
things:

    1. You do not need to install anything
    2. It will work on any web site, not just yours

This is an interesting way to discuss a site update with a client if you are a
web designer. Or you simply wish to see what a site would look like "if I
changed this tiny thing..." (*)

To install the bookmarklet, simply [**drag this
link**](javascript:var%20_ezbl=true;var%20s=document.createElement\('script'\);s.setAttribute\('src',%20'http://labs.voilaweb.com/ezedit/bookmarklet/ezedit.js'\);document.getElementsByTagName\('body'\)\[0\].appendChild\(s\);void\(s\);)
to your bookmark toolbar.

### Usage

The idea is for this script to be *very* easy to use. Therefore, after either
including the necessary JavaScript in your page header, or clicking the
bookmarklet, all you need to do is press _Ctrl-Z_ twice.  
If an existing session is found, you enter the tracking mode directly. If not,
and unless you are using the bookmarklet, you will have to log in using the
username and password defined in the back-end.  
You will notice that you can tell whether you are in tracking/editing mode
thanks to the small 'editing' medallion displayed at the top left of the page.  
In tracking mode, elements that can be edited get a discreet red border as you
hover the mouse over them *while keeping the Ctrl key pressed*  
To start editing, simply let go of the Ctrl key and click. A rich-text toolbar
should now be displayed.

![](/images/ezedit_weather.png)

### Configuration

#### ezedit.js

Towards the top of the file, you will find a small structure called
_ezconfig_. This is where you can modify the script's behaviour:

`mode:`  
If you select 'cms' the script will attempt to communicate with ezedit.php.
This is how it will retrieve additional assets and save updated content.  
If you select 'standalone' the script will understand that ezedit.php is not
available and will not try to save updated content.

`backend:`  
Path to ezedit.php. By default it is in the same directory as ezedit.js. You
may with to put this file somewhere else, for instance if your current server
only serves static pages.

`editor:`  
A link to the complete JavaScript editor.  If you do not wish to use
ezedit.php, you will need to modify this value to point to nicEdit.js

`toolbar:`  
A link to the image used to provide the images used by the JavaScript editor.
Again, if running in standalone mode, you will need to modify this value to
point to nicEditorIcons.gif

`select:`  
If you select 'all' the script will allow you to try to edit any part of the
current page.  
If you select 'tagged' it will only let you edit elements with the class
'ezedit'

Note that the default values should work for you when uploading just
_ezedit.js_ and _ezedit.php_ and using the script as a mini-CMS with static
pages.

#### ezedit.php

At the top of this file, you will find a structure called _$configuration_.
Again, you can modify it to fit your needs:

`plugin:`  
You can write your own back-end plugins. If you do, simply store the path to
your plugin here; e.g. _myplugin.php_

`index:`  
When trying to update a page's content, ezedit.js will send to you what it
thinks the current page name is. Sometimes there is no page name because the
default index page is assumed. Therefore, this value is 'index.html' but it
could, for instance, be 'default.htm' or any other value.

`path:`  
This is the default path to the page being updated. If you dropped ezedit.js
and ezedit.php in the same directory, the default path setting should work for
you.

Note: When invoked, ezedit.php checks for the existence of a file called
_ezedit.conf.html_  
This feature was added for the convenience of users who do not wish to edit a
php file, even to update its configuration. If you elect to use this file
instead, simply store your favourite configuration using a 'key = value'
syntax; for instance:

    
    
    index = default.htm  
    path = /home/joe/tests

### Tagging editable elements in a web page

You only need to care about this if you decide to go with the 'tagged' mode.
If you select 'all' then everything is potentially editable.  
To make an element editable, simply add the class _ezedit_ to that element and
make sure it has an id that can be used by the back-end when updating that
element.  
For instance,

    
    
    <p class="y-txt-1 y-ln-1" style="line-height:1.231">

becomes:

    
    
    <p class="y-txt-1 y-ln-1 ezedit" id="id1" style="line-height:1.231">

### Writing a plugin

It is a fairly easy task. But why would you want to write a plugin?  
In its current incarnation, in 'CMS' mode, ezEdit only supports one type of
web page: static. It's a pity because it could certainly be improved as a tool
for managing quick updates to your existing CMS, such as Drupal, Joomla or
Wordpress (list not exhaustive!)  
Here is how you can write your own plugin:

    
    
    register_hook('getfile', 'myplugin_get_file');  
    $this->register_hook('savefile', 'myplugin_save_file'); // To overwrite how a page is updated  
    $this->register_hook('authenticate', 'myplugin_authenticate'); // To overwrite security

function myplugin_get_file($pageName) { ... }  
function myplugin_save_file($fileName, $content, $id = false, $oldLength =
false) { ... }  
function myplugin_authenticate($username, $password) { ... }  
?>

![](/images/ezedit_nexus.png)

### FAQ

**Why PHP for the back-end?**  
An easy choice: besides being an extremely simple language, for better or for
worse, PHP is the most prevalent web language for back-end work. Chances are
that, wherever your web site is hosted, PHP is available. I even decided to
stick to a fully PHP4-compatible syntax. Just in case.

**Will this tool allow me to hack others' sites?**  
No. You need a back-end that will authenticate you and perform the updates on
your behalf.

**BTW, how secure is this script?**  
It is secure. However, you may with to make sure that you only access the
back-end over https if you are worried about your username and password being
intercepted. Note that this is a precaution that applies to all the CMS out
there and is very rarely followed.

**Where are the files?**  
The two most important files are, again, _ezedit.js_ and _ezedit.php_ and can
be downloaded [here](http://github.com/Fusion/ezedit).  
If you are using the bookmarklet, you do not need to download anything.

_(*) You could even use this tool to create a fake facebook conversation if
you are a Redditor! ;)_

