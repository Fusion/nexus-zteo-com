---
title: "Create your own WebTop in php/js in no time"
description: "Create your own WebTop in php/js in no time"
slug: create-your-own-webtop-in-phpjs-in-no-time
date: 2007-01-01 04:00:00
draft: false
summary: "They are everywhere: protopage, pageflakes, netvibes et al are free, easy to use -as long as you have a powerful browser- and moderatly eye-pleasing."
---


They are everywhere: [protopage](http://www.protopage.com/),
[pageflakes](http://www.pageflakes.com/), [netvibes](http://www.netvibes.com/)
et al are free, easy to use -as long as you have a powerful browser- and
moderatly eye-pleasing.

**SO?**

A couple months ago, I wondered how long it would take me to build my own
'WebTop' ([You can play with it here](http://home.clicdev.com/)). The
challenge would be to get it to a satisfactory state over a week-end.  
Of course, I decided to use existing open-source code for the applications'
primary needs.  
  
 _These needs being_ :  
1\. Users should be able to play with the application without being logged in  
2\. They need to know that if they do log in, the state of their webtop will
be memorized for their next session  
3\. Webtops are windows-based; webtops' dimensions are virtually unlimited and
windows can be laid out anywhere in that immense space.  
4\. Also, windows may need to be iconified and when they are, displaying a
relevant icon would provide great visual clues.

I decided to use these four libraries:

* Sebastien Gruhier's [Prototype Window](http://prototype-window.xilinus.com/)  
* Mohamed Ahmed's [Users Login System](http://www.maaking.com/demos/login/)  
* Michal Migursky and Matt Knapp's [Json class](http://pear.php.net/pepr/pepr-proposal-show.php?id=198)  
* InputParser.php, which I extracted from my very own [nextBBS](http://www.nextbbs.com/)' source tree

Oh, and the wonderfully simplistic red icons are the creation of [P.J.
Onori](http://somerandomdude.net/srd-projects/bitcons/) (thanks Sam!).

Of course, you could obviously use any piece of technology you like; I simply
picked these four because they allowed me to hit the ground running.

**HACKING AWAY**

The one piece I heavily added to is Prototype Window.  
For instance, I added a drop-down contextual menu to windows, activated when
clicking on the new 'menu' button, next to the 'close', 'expand' and 'iconify'
buttons.  
![home.clicdev.com Contextual
Menu](/images/contextualmenu.png)  
These three menu items let the user:

1\. Change the background color of the iconified version of the window  
![home.clicdev.com Color
Picker](/images/colorpicker.png)  
Let's say...purple  
![home.clicdev.com
Iconified](/images/iconified.png)  
Well...it *is* purple

2\. Change the window's overall theme  
[![home.clicdev.com Window Theme
1](/images/wintheme1.thumbnail.png)](http://nexus.zteo.com/files/2006/12/wintheme1.png
"home.clicdev.com Window Theme 1") [![home.clicdev.com Window Theme
2](/images/wintheme2.thumbnail.png)](http://nexus.zteo.com/files/2006/12/wintheme2.png
"home.clicdev.com Window Theme 2")

3\. Reload the content of the window

To create these menus, I went with my usual method of creating HTML elements
that I position and display on demand, instead of re-creating them every time.  

    
    
      
    
    
      
    
    
    ![](/images/day.gif); Icon Color
    
      
    
    
    ![](/images/day.gif) Window Theme
    
      
    
    
    ![](/images/loop.gif) Reset
    
      
    

  



  
I had to further modify the code of Prototype Window because it did not offer
anything for iconified windows.  
What I am doing is hide the actual window, create a square window that is a
representation of the hidden one and slap a relevant icon in the middle of it
-if I manage to retrieve one-.  
 _About this icon_ : I simply query the server hosting the iconified
application for its default favicon and download it for caching purpose - see
below.

To implement these features, I only added a few hooks to window.js, leaving
Sebastien's code relatively untouched, and piling up my dirty code in cfr.js
instead.

**BEHAVIOURS**

* I had to add a hook to catch the fact that a user is leaving the current webpage, asking them whether they really wish to do this and canceling the event if they do not.  
This was easily implemented using Javascript's onbeforeunload(), which happens
to work in all the browsers I tested.  

    
    
    $obfulstr = "onbeforeunload="return 'For some reason, you are about to leave this page:nIt could be your decision or an application, such as Yahoo, trying to force its way out.nMAKE SURE THAT YOU SAVED YOUR DESKTOP!';"";

  
* The login window itself is simply Mohame's login code embedded within an iframe, which in turn I turned into a CSS window.  
[![home.clicdev.com Login
Screen](/images/loginscreen.thumbnail.png)](http://nexus.zteo.com/files/2006/12/loginscreen.png
"home.clicdev.com Login Screen")  

    
    
    function cfrNewLogin()
    
    
    
    
    
    {
    
    
    
    
    
      _loginwin = _doOpenWindow('Login', ROOTPATH+'login/', false, 340, 240);
    
    
    
    
    
    }

  
 **AJAX**

As you can imagine, Ajax is used fairly heavily. Here is how: all frontend
queries are channeled through a method in cfr.js, called _talkToMe()  
This method uses Prototype's Ajax implementation -but you could use any other
implenentation here- to contact the backend.  

    
    
      
    case 'minimize':
    
    
    
    
    
      var iconcolor;
    
    
    
    
    
        if(win && win.element.getAttribute('iconcolor'))
    
    
    
    
    
          iconcolor = win.element.getAttribute('iconcolor');
    
    
    
    
    
        else
    
    
    
    
    
          iconcolor = '-';
    
    
    
    
    
        var myAjax = new Ajax.Request(
    
    
    
    
    
          'backend/index.php',
    
    
    
    
    
          {
    
    
    
    
    
            method: 'get',
    
    
    
    
    
            parameters:
    
    
    
    
    
              'action=minimize&id='+id+'&title='+prepare(message)+'&iconcolor='+prepare(iconcolor)+'&url='+prepare(url),
    
    
    
    
    
    onComplete: getMinimizeReply
    
    
    
    
    
          });
    
    
    
    
    
        break;

  
The backend class BE, defined in index.php, extends BackEnd which itself
implements low-level communications using Json and/or XML.  
The backend has knowledge of the code of the various widgets requested by the
frontend and has the ability to retrieve favicons from other websites. The
latter is done through the very straightforward use of fopen() and
file_get_contents().  

    
    
      
    // Build path to favicon.ico
    
    
    
    
    
    preg_match("/^(http://)?([^/]+)/i", $url, $matches);
    
    
    
    
    
    $prepath = $matches[1].$matches[2];
    
    
    
    
    
    $path = $prepath.'/favicon.ico';
    
    
    
    
    
    // Does this guy exist?
    
    
    
    
    
    $bFound = false;
    
    
    
    
    
    $f = @fopen($path, 'r');
    
    
    
    
    
    if($f)
    
    
    
    
    
    {
    
    
    
    
    
      // /favicon.ico
    
    
    
    
    
      @fclose($f);
    
    
    
    
    
      $contents .= @file_get_contents($path);
    
    
    
    
    
      axlog("FOUND CONTENTS=".strlen($contents));
    
    
    
    
    
      if(strlen($contents)>0)
    
    
    
    
    
        $bFound = true;
    
    
    
    
    
      }
    
    
    
    
    
      if(!$bFound)
    
    
    
    
    
      {
    
    
    
    
    
        // Get page contents
    
    
    
    
    
        @fclose($f);
    
    
    
    
    
        $contents .= @file_get_contents($url);
    
    
    
    
    
        $c = preg_match("//i", $contents, $matches);
    
    
    
    
    
        if($c > 0)
    
    
    
    
    
        {
    
    
    
    
    
          $s = &$matches[0];
    
    
    
    
    
          $c = preg_match("/href=(.+?)(['">])/i", $s, $matches);
    
    
    
    
    
          if($c > 0 )
    
    
    
    
    
          {
    
    
    
    
    
            $s = str_replace(array("'", """), array('', ''), $matches[1]);
    
    
    
    
    
            // Build new URL
    
    
    
    
    
            if(strpos($s, '://')===false)
    
    
    
    
    
            {
    
    
    
    
    
              if($s[0]=='/')
    
    
    
    
    
                $path = $prepath . $s;
    
    
    
    
    
              /** @todo 'else : relative path' */
    
    
    
    
    
              axlog("Found relative favicon @ $path");
    
    
    
    
    
            }
    
    
    
    
    
            else
    
    
    
    
    
            {
    
    
    
    
    
              axlog("Found absolute favicon @ $path");
    
    
    
    
    
              $path = $s;
    
    
    
    
    
            }
    
    
    
    
    
          }
    
    
    
    
    
          else
    
    
    
    
    
            $path = 'themes/window.gif';
    
    
    
    
    
        }
    
    
    
    
    
        else
    
    
    
    
    
          $path = 'themes/window.gif';
    
    
    
    
    
      }

  
 **DATABASE**

Since we are using Mohamed's login script, database connectivity comes for
free.  
Note that his script uses one table: _maaking_users_  
We need to add our own two tables:

_maaking_session_ \- each entry in this table will be a user window:  

    
    
    CREATE TABLE `maaking_session` (
    
    
    
    
    
     `id` int(11) NOT NULL auto_increment,
    
    
    
    
    
    `userid` int(11) NOT NULL default '0',
    
    
    
    
    
    `url` text,
    
    
    
    
    
    `useTop` tinyint(1) default NULL,
    
    
    
    
    
    `useLeft` tinyint(1) default NULL,
    
    
    
    
    
    `top` int(10) default NULL,
    
    
    
    
    
    `bottom` int(10) default NULL,
    
    
    
    
    
    `left` int(10) default NULL,
    
    
    
    
    
    `right` int(10) default NULL,
    
    
    
    
    
    `title` text,
    
    
    
    
    
    `width` int(10) default NULL,
    
    
    
    
    
    `height` int(10) default NULL,
    
    
    
    
    
    `hidden` tinyint(1) default NULL,
    
    
    
    
    
    `iconcolor` varchar(10) default NULL,
    
    
    
    
    
    `contents` text,
    
    
    
    
    
    `usertheme` varchar(16) default '',
    
    
    
    
    
    PRIMARY KEY  (`id`),
    
    
    
    
    
    KEY `userid` (`userid`)
    
    
    
    
    
    );

  
and _maaking_favicons_ :  

    
    
    CREATE TABLE `maaking_favicons` (
    
    
    
    
    
    `id` int(11) NOT NULL auto_increment,
    
    
    
    
    
    `url` varchar(255) NOT NULL default '',
    
    
    
    
    
    `icon` text,
    
    
    
    
    
    PRIMARY KEY  (`id`),
    
    
    
    
    
    KEY `url` (`url`)
    
    
    
    
    
    );

  
This is it for now. [Download the zip
package](http://downloads.sourceforge.net/forums/home.zip?use_mirror=osdn),
play with it, let me know what you think or if you have any questions!

