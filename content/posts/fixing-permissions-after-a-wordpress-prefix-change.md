---
title: "Fixing permissions after a Wordpress prefix change"
description: "Fixing permissions after a Wordpress prefix change"
slug: fixing-permissions-after-a-wordpress-prefix-change
date: 2009-02-14 01:48:55
draft: false
summary: "Let's say that you renamed your Wordpress tables.There may be several reasons for this. For instance, you installed Virtual Multiblog to support more than one blog with the same setup."
---


[![Do not
enter](http://farm3.static.flickr.com/2208/2268492152_3ecb52ff81_t.jpg)](http://www.flickr.com/photos/63301294@N00/2268492152/
"Do not enter")Let's say that you renamed your Wordpress tables.  
There may be several reasons for this. For instance, you installed [Virtual
Multiblog](http://striderweb.com/nerdaphernalia/features/virtual-
multiblog/?cp=21#comments) to support more than one blog with the same setup.

And now, you are facing the dreaded "You do not have sufficient permissions to
access this page"  
What to do, what to do?

Turns out, after some research, I found out that there is a proper procedure
for us lazy webmasters:

1\. Download the [force-
upgrade](http://markjaquith.wordpress.com/2006/03/28/wordpress-error-you-do-
not-have-sufficient-permissions-to-access-this-page/#comment-89003) script and
run it. It's a fairly old script but since it all it does is invoke Wordpress'
upgrade mechanism, it still works very well with 2.7. I know, it's not an
upgrade! But you can also run the script to right some wrongs...

2\. Using your favourite SQL editor, edit the "usermedata" table. Let's say
that your old table prefix was 'wp_' and your new prefix is 'wp_new_' you
would type this simple SQL command to make sure that your first user is still
admin:  

```sql
update wp_new_usermeta set meta_value='a:1:{s:13:"administrator";b:1;}' where meta_key='wp_new_capabilities' and user_id=1;  
```

You're all set.

