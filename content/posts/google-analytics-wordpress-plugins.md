---
title: "Google Analytics Wordpress Plugins"
description: "Google Analytics Wordpress Plugins"
slug: google-analytics-wordpress-plugins
date: 2010-05-26 00:25:34
draft: false
summary: "Google Analytics. I'm sure you're already familiar with it. If not, just know that it's a free service that gives you a pretty accurate idea of why people visit your blog, whether they, in fact, visit it at all, and what kind of demographics they represent. Unless you already use a better, but not free, analytics service, you really have nothing to lose, so just go ahead and sign up."
image: "ca1f2a89-77c5-4804-8f62-c908f79f4339.gif"
---


![](/images/analytics-195x65.gif)Google Analytics. I'm sure
you're already familiar with it. If not, just know that it's a free service
that gives you a pretty accurate idea of why people visit your blog, whether
they, in fact, visit it at all, and what kind of demographics they represent.
Unless you already use a better, but not free, analytics service, you really
have nothing to lose, so just go ahead and [sign up](http://www.google.com/analytics/).

Adding Analytics code to your blog is quite straightforward. You can either
copy/paste the Javascript code to your template's footer.php, or use one of
the many plugins that will do just that. But toda, I would rather focus on the
plugins that integrate Analytics reporting with your admin control panel.

## Adding Analytics Code to your page

  
I will mention these two plugins so that you know where to got to collect your
visitors' info. As I mentioned earlier, they are two among many plugins:

**Google Analytics 3 codes for WordPress**  
<http://www.prima-posizione.it/download/wp/google-analytics/>[  
](http://www.prima-posizione.it/download/wp/google-analytics/)  
 **Ultimate Google Analytics**  
<http://www.oratransplant.nl/uga/>[  
](http://www.oratransplant.nl/uga/)  
There isn't much to say about these guys. They add the code necessary to track
your visitors. They have nice admin control panel screens to configure who you
wish to track, and how. That is, they offer to not count certain roles,
differentiate outbound links, etc.  
I have tested these plugins against Wordpress 3.0 beta 2 which is about to be
released and in the process found several of them to not work anymore.

## Reporting Plugins

  
**Google Analyticator**  
[http://ronaldheft.com/code/analyticator/](/admin/blog/blogpost/123/t/)  
This is the first plugin I will mention because when using this one, you can
do without a "code" plugin as it will automatically do both jobs: insert the
relevant code in your pages, and provide reporting.  
It has the ability to not count visitors based on roles (administrator,
editor, etc.)  
Its reporting capabilities are found in a dashboard widget which lists current
trends, five top pages, referrers and seaches.  
![](/images/Dashboard-‹-The-Nexus-—-WordPress-1-1.png)  
Its support forums offer a very comprehensive FAQ and its community seems to
be very active.  
[easyreview title="Google Analyticator" cat1title="Features"
cat1detail="Tracking, Roles, Support" cat1rating="3" cat2title="Compatibility"
cat2detail="With Wordpress 3 and Google Analytics" cat2rating="5"
overall="false"]

**Wordpress Analytics**  
<http://imthi.com/wp-analytics>  
This plugin requires its own dashboard page; as such, it does not work with
the "one-stop" dashboard paradigm, but it makes up for this shortcoming by
offering more information than a typical dashboard widget. It offers a fairly
clear breakdown of visits versus geographic data. It also displays search
keywords, traffic sources and browsers types.  
A couple nice features to be aware of:  
1\. If it possible to navigate between dates using left and right arrow-shapes
buttons; this lets you visualize much more data than the default ten entries
displayed for each category;  
2\. The visitors history map is interactive and you can quickly visualise any
given day's information  
My only gripe with this plugin is that it does not integrate directly with
Google Analytics by asking Analytics to authorize it. Instead, you have to
enter your username and password in the plugin itself. It is not so bad,
though, as you have the plugin's source code that you can check if you are
worried about it "calling home" with your information.  
![](/images/BetaDesigns-Caliper-V1.02.jpg)  
[easyreview title="Wordpress Analytics" cat1title="Features"
cat1detail="Clear, Date ranges, Interactive" cat1rating="4"
cat2title="Compatibility" cat2detail="With Wordpress 3 and Google Analytics"
cat2rating="4" overall="false"]

**Google Analytics Dashboard**  
<http://www.ioncannon.net/projects/google-analytics-dashboard-wordpress-
widget/>  
It's a misleading name for this plugin. But wait! It's misleading in a good
way: it actually is more than just a dashboard widget.  
This plugin will also display analytics graphs next to each post. I would like
to talk about the dashboard widget itself but it's pretty much a run-of-the-
mill widget with a few nice touches: you can select which roles have access to
it (administrators, editors, etc.) and it can display Analytics goals.  
However, where it really shines is by providing an Analytics graph next to
each post: it quickly tells you how many page views a post received, how many
visitors left your site after reading this post and the tiny graph tells you
about the post's recent popularity history.

![](/images/BetaDesigns-Caliper-V1.02-1.jpg)

Yup...not all posts are created equal

  
Note that this login does not support direct Analytics integration either and
also requires you to provide your Analytics information.  
[easyreview title="Google Analytics Dashboard" cat1title="Roles, Goals, Posts
Details" cat1detail="Features offered by this plugin" cat1rating="4"
cat2title="Compatibility" cat2detail="With Wordpress 3 and Google Analytics"
cat2rating="4" overall="false"]

## The ones that make me sad

  
**Tantan Reports**  
<http://tantannoodles.com/toolkit/wordpress-reports/>  
On paper, this plugin has it all: it comes with a widget that you can use to
proudly show your stats to your visitors, it also reports on Feedburner...  
Unfortunately, beyond the fact that it, too, requires your username and
password, it happens to use a Google Analytics library written by the same
author, and that library uses a hack to log in to Analytics that seems to be
broken by a recent update to the Analytics website.  
[easyreview title="Tantan Reports" cat1title="Features" cat1detail="Publish,
Feedburner, Standard" cat1rating="3" cat2title="Compatibility"
cat2detail="With Wordpress 3 and Google Analytics" cat2rating="0"
overall="false"]

**iRedLog Google Analytics Stats**  
<http://iredlof.com/2009/04/iredlof-google-analytics-stats-wordpress-plugin/>  
This plugin displays several widgets using Flash. In fact, it would be more
accurate to say that it tries to display them as I could not get it to work in
any browser.  
Sill, I tried to view its online demo at http://blog.iredlof.com/wp-admin/ but
unfortunately that page does not offer to demo this plugin anymore.  
I have to assume that the plugin is not supported.  
[easyreview title="iRedLog Google Analytics Stats" cat1title="Features"
cat1detail="Beautiful, on paper at least" cat1rating="3"
cat2title="Compatibility" cat2detail="With Wordpress 3 and Google Analytics"
cat2rating="0" overall="false"]

**Local Analytics**  
<http://www.joycebabu.com/downloads/local-analytics>  
This would be an interesting concept, caching as much information as possible
to make your pages not dependent on Google Analytics' web site connectivity;
unfortunately this plugin has not been updated in two years. I hope someone
picks up its development.  
[easyreview title="Local Analytics" cat1title="Features" cat1detail="Tracking,
Subdomains, Caching" cat1rating="4" cat2title="Compatibility" cat2detail="With
Wordpress 3 and Google Analytics" cat2rating="0" overall="false"]

I will keep an eye on these plugins and update this blog if they get updated.

