---
title: "Wordpress Plugin: Page-Theme...themes your pages!"
description: "Wordpress Plugin: Page-Theme...themes your pages!"
slug: wordpress-plugin-page-themethemes-your-pages
date: 2010-06-06 01:24:23
draft: false
summary: "I was quite surprised, when looking for a way to assign different themes to some pages, to not manage to find an easy way to do that. It is not baked into WordPress, and I could not find a suitable plugin either.I had, a while ago, created a tiny plugin that did just that for me but it was way too simple and unfriendly to configure. I eventually stumbled upon the 'domain theme' plugin which, even though it does not do what I need, at least showed me that there is a way to perform a proper theme switch cleanly.Note: if you've been reading this intro, thinking: \"But there is a way to switch templates!\", then you're right because there is; however I am not talking about templates but themes. Templates are pre-recorded page structures whereas themes are about changing your blog's complete look and feel, including logo, stylesheet, etc."
image: "7f4d63d7-ce0c-46ad-bf5f-586bf97f1e71.jpg"
---


![](/images/3295125837_3e01677dde_b-300x168.jpg)  
I was quite surprised, when looking for a way to assign different themes to
some pages, to not manage to find an easy way to do that. It is not baked into
WordPress, and I could not find a suitable plugin either.  
I had, a while ago, created a tiny plugin that did just that for me but it was
way too simple and unfriendly to configure. I eventually stumbled upon the
'domain theme' plugin which, even though it does not do what I need, at least
showed me that there is a way to perform a proper theme switch cleanly.  
Note: if you've been reading this intro, thinking: "But there _is_ a way to
switch templates!", then you're right because there is; however I am not
talking about templates but themes. Templates are pre-recorded page structures
whereas themes are about changing your blog's complete look and feel,
including logo, stylesheet, etc.

Hence, **page-theme** : a simple plugin with a friendly user interface that
lets you specify a given theme for any of your pages. Here is what it looks
like:  
![](/images/Page-Theme-Options-‹-The-Nexus-—-WordPress-1.jpg)

Two limitations you need to be aware of:

1. This plugin is called very early on during the process of rendering a web page; so early, in fact, that I had to come up with my own way to detect which page you are looking at. This works well as long as you are using "pretty links" (e.g. "yourdomain.com/2010/05/mypagename") but will not work with the other type of links (e.g. "yourdomain.com/?p=5")

1. Only pages are currently handled. Posts could also get their own theme, but I would need to modify the plugin to support this. Just let me know if you would like to see this feature implemented.

So, if you're interested, go get it now:  
<http://wordpress.org/extend/plugins/page-theme/>

