---
title: "SEO: How I killed a highly successful message board with just ONE mistake (and how you can avoid it)"
description: "SEO: How I killed a highly successful message board with just ONE mistake (and how you can avoid it)"
slug: seo-how-i-killed-a-highly-successful-message-board-with-just-one-mistake-and-how-you-can-avoid-it
date: 2007-09-09 08:16:00
draft: false
summary: "Do you have any idea how much disregarding basic SEO (Search Engine Optimization) rules can cost you? I have the answer and it's \"a lot\". And take my word for it: I am not an SEO consultant and have nothing to sell, here."
---


[![Redirect](/images/325566874_1859c6575f_m.jpg)](http://www.flickr.com/photos/jm3/325566874/)Do you have any idea how much disregarding basic **SEO** ( _Search
Engine Optimization_ ) rules can **cost you**? I have the answer and it's "
**a lot** ". And take my word for it: I am not an SEO consultant and have
nothing to sell, here.

Up until last year, one of my sites was wildly popular:
[militate.com](www.militate.com). Note that after achieving success through
word of mouth, it plateaued and never exceeded 300 simultaneous users. It even
started a slow descent that would end up in its **much smaller** audience
today.

What was the horrible **mistake** that lead to that, then?

Simple.  

> Rule #1 of SEO: when you're getting good Google juice through heavy pages
indexing, _**do not** , under any circumstance_, turn your site into a dead
links farm.

  
And that's exactly what I did: at first people could access the site under a
directory labeled /forums; after its first overhaul it became /site; later on
I changed the domain name. And finally I changed /site to simply /

This, alone, is no crime. But **I never told Google where to find the pages
that were being relocated**.

As a result, a web site that had steadily grown to more than 600,000 topics
suddenly **stalled** and **withered**. OK, there are more factors: the site
team was losing interest in its main topic, among many. But even when this
happens, you can keep a niche site likes this one through sheer popularity.
You really have to be a **hairless monkey** to mess that up.

So, how do you avoid such an unfortunate situation?

In my case, here is what I should have done. This relies entirely on issuing a
status '301', which search engines understand to mean "This is my new home.
Follow me!"

Solution #1: use ~~mod_rewrite~~ Redirect  
This is the usual answer and it **works** fairly well. Let's see how we do it
for our move from forums/ to site/

1\. Create a file called .htaccess at the root of your old directory (
"forums" ) and put the following inside:  
```apacheconf
RewriteEngine on  
RewriteBase /  
RewriteRule /forums/(.*) /site/$1 [R=301,L]
```


Oh, wait: it is now as simple as
```apacheconf
RedirectMatch 301 /forums/(.*) /site/$1
```

2\. That's it. Make sure that .htaccess has the correct access rights.

Well, that was easy.

Now, let's say that you are looking for a more **advanced solution** ; for
instance you change your CMS/Forum Software and what used to be
_/forums/index.php?act=topic &page= _ **105**_ &p=1_ now becomes
_/site/index.php?act=topic &n= _ **1**_ &p=1_ because your old software's
topics started at number 105 but now that you imported them in your new
software, they were renumbered and start at 1.

Here is a simple solution, that will also work if you do not have mod_rewrite
(sorry, only a php example for now; I may write a **Ruby** example as well if
**requested** ):

1\. Create a file called notarealpage.php; again at the root of your old
directory:  

```php
$directory = preg_replace('#^/forums/#', '', $_SERVER['REDIRECT_URL']); // Remove original directory  
$querystr = $_SERVER['REDIRECT_QUERY_STRING'];  
if(empty($querystr))  
        $qm = '';  
else  
{  
        $qm = '?';  
        // Renumber  
        $querystr = preg_replace_callback(  
                '#&id=([0-9]+)#',  
                create_function(  
                        '$matches',  
                        'return "&n=" . ($matches[1]-104);'),  
                $querystr);  
}  
$newurl = '/site/' . $directory . $qm . $querystr;  
print $newurl;  
```

  
2\. In your .htaccess file, simply put:
```apacheconf
ErrorDocument 404 /forums/notarealpage.php
```

Voila! Simple as that.

**_A note_** : again, I recommend that you look at the 'Plain Code' since the
highlighter plug-in translates all html entities. I have to take this plug-in
apart someday...

