---
title: "Notes on enabling multisites in WP3.0"
description: "Notes on enabling multisites in WP3.0"
slug: notes-on-enabling-multisites-in-wp30
date: 2010-05-29 08:17:48
draft: false
summary: "This is not a real article per se. It is more intended to be a conversation because Twitter would make this a tad difficult, with its 140 characters limit."
image: "1011f9d9-6c21-4a1c-8984-5903d7feb58b.jpg"
---


[![\(c\) Davide Guglielmo](/images/182229_7006-225x300.jpg)](http://www.sxc.hu/photo/182229/)
_This is not a real article per se. It is more intended to be a conversation
because Twitter would make this a tad difficult, with its 140 characters
limit._

Two notes on moving to multisites:

1\. Wordpress 3.0 final has not been released yet; I have no idea whether a
safe upgrade can be guaranteed after enabling multisites

2\. Multisites based on subdomains are possible; if you blog is not recent,
you will **not** be offered directory-based sites

First, edit wp-config.php, add towards the top:

```php
define('WP_ALLOW_MULTISITE', true);
```

In the ACP, go to Tools > Network

This page shows how to modify your default wp-config.php and your .htaccess
(for SEO links)  
Do not worry if some of the text looks similar to what you already have in
your existing wp-config.php; it is, in fact, different and necessary.

When this is done, your current blog should work as before; you may see some
things that needs fixing if using some new features such as "make thumbnail."
See below.

Your last step in the ACP, whether you are migrating from Wordpress or
Wordpress MU, is to go to Super Admin > Update and let Wordpress update all
your blogs.

**Update** : Do not forget to also create, under wp-content/, a directory
called _blogs.dir_ and make it writable by your web server.  
Next, you may, for historical reasons, have some loose files lying around,
e.g. images, which will not be displayed correctly anymore; for instance,
Thumbnails.  
If this happens, using the command-line again, go to where these files are
located (typically _/files/_ or _/wp-content/uploads/_ ) and type:

```bash
cp -R * ../wp-content/blogs.dir/1/files/
```

Now, let's say your site can be found at http://example.com  
Your subdomains/blogs should be created at http://blog1.example.com
http://anotherblog.example.com etc.  
You can either place a wildcard record in your DNS configuration, e.g.:

```conf
*       14400        IN A  1.1.1.1
```

where 1.1.1.1 is your IP address;  
Or you can create a new DNS entry for each subdomain.

You will also need to tell your web server that subdomains are enabled. The
way to do this varies based on your web server and control panel. Or
configuration files if you are more of the command-line creed.

If you wish to use different domains altogether, this is still untested but I
will give it a try eventually; there are plug-ins, in the _extend_ database,
that map domains to sub-domains.

## What about SEO?

I know. You've noticed that even your main blog now has slightly different
URLs: where it used to be something like 'www.example.com/2009/11/26/...' it
now is 'www.example.com/ **blog/** 2009/11/26/...'  
Fear not! Wordpress is nice enough to keep these old links ready for any
visitor following a link from elsewhere. The old address simply returns a '301
- Moved permanently' header which will tell search engines that your content
has not disappeared but simply relocated, and where.

