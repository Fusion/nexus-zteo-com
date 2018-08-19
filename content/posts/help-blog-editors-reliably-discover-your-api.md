---
title: "Help Blog Editors Reliably Discover Your API"
description: "Help Blog Editors Reliably Discover Your API"
slug: help-blog-editors-reliably-discover-your-api
date: 2009-10-20 05:07:36
draft: false
summary: "It seems that tons of people have the same complaint: the Wordpress application for iPhone does not discover their blog and, therefore, is of no use to them.The same goes for many desktop-based applications.I, too, spent quite a lot of time trying to figure that one out but now that I have succeeded, here is how I would recommend working on this issue if your blog is affected:"
image: "bda85704-c1e5-4eba-b938-59829a9c25eb.jpg"
---


[![Wordpress Schawg](/images/2913018697_ccbb33e993_t.jpg)](http://www.flickr.com/photos/71813425@N00/2913018697/"Wordpress Schawg")It seems that [tons of people](http://iphone.forums.wordpress.org/topic/xml-rpc-service-for-you-blog-
cannot-be-found/) have the same complaint: the Wordpress application for
iPhone does not discover their blog and, therefore, is of no use to them.  
The same goes for many desktop-based applications.  
I, too, spent quite a lot of time trying to figure that one out but now that I
have succeeded, here is how I would recommend working on this issue if your
blog is affected:

1. Go to your blog home page and select "View source"

1. Look for **_< link ref="EditURI"..._** you will see that this line contains a URL ending with **_xmlrpc.php?rsd_**. Point your browser to that URL. A rather empty page should be displayed. Check its source; if it is XML, it's all good.

1. If the previous step fails, go to the same URL but without **_?rsd_**. If this fails too, you need to check that you have a file called **xmlrpc.php** and that: _a._ No rewrite rule messes up your URL; _b._ No plugin renders it invisible -- e.g. "private"

1. If both steps work well, it is VERY likely that the blog editor you are using -- or trying to use, more accurately -- is choking on malformed XHTML code. It is what seems to mystify most of us.

  
To convince your blog editor to "discover" your blog, we are going to give it
a nicely formed XHTML page:

First, make a copy of index.php: **cp index.php index.o.php**

Now, create a new index.php page with this code:

  
Of course, you need to replace all instances of **_nexus.zteo.com_** with your
own blog's information; for instance **_myblog.mydomain.com_**

Discover your blog using your favourite blog editor.

Restore your index.php: **cp index.o.php index.php**

Done!

