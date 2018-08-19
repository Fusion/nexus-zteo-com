---
title: "Clean-up Wordpress and upgrade to 3.0"
description: "Clean-up Wordpress and upgrade to 3.0"
slug: clean-up-wordpress-and-upgrade-to-30
date: 2010-05-27 08:27:57
draft: false
summary: "That's something I had to do myself recently. It was not quite as painful as I feared it to be.My aging Wordpress install had certainly gone through its share of hacking: I started with a 1.x version, added multi-blog plugins, uninstalled them, moved to Wordpress MU, then back to single-blog Wordpress. In the process I wrote scripts to rename my tables, added multi-domains plugins...all the while manually upgrading to various 2.x releases.Things stopped working. Helpful things, such as JavaScript, just about everywhere."
image: "97092d35-098f-4a20-89fd-414a8606ef24.png"
---


[![](/images/3543295520_0ae9d41929_o-300x300.png)](http://www.flickr.com/photos/datacharmer/3543295520/)That's
something I had to do myself recently. It was not quite as painful as I feared
it to be.  
My aging Wordpress install had certainly gone through its share of hacking: I
started with a 1.x version, added multi-blog plugins, uninstalled them, moved
to [Wordpress MU](http://mu.wordpress.org/), then back to single-blog
Wordpress. In the process I wrote scripts to rename my tables, added multi-
domains plugins...all the while manually upgrading to various 2.x releases.  
Things stopped working. Helpful things, such as JavaScript, just about
everywhere.

Now, Wordpress 3.0 is about to be released, nightly builds are available, and
migrating to 3.0 is going to prove a challenge on its own since it re-
introduces multi-blogs support and, as a major release, existing Wordpress
installed databases will be quite -- but hopefully gently -- re-shaped by the
upgrade process.

So, here is what I consider the safest upgrade/clean-up path. I hope it works
for you as well as it does for me. Everything is now back to stable and
working and I am not seeing major incompatibilities with any of my existing
plug-ins.

## Cleaning-up the Database

This is something I recommend doing if you have been using Wordpress MU or any
other plug-in that renames your tables.  
First, dump your old database's content into a temporary file:

```bash
mysqldump old_database_name > tmp.sql
```

If you need to rename tables, edit tmp.sql; in my case, I use vi (sorry!) and
this command:

```plaintext
:%s/wp_xxxxxx_/wp_/g
```

where _wp_xxxxxx__ represents the prefix used by your plug-in. For instance,
when using Wordpress MU with the Nexus, it was something like
_wp_nexus_zteo_com__  
If you have a statistics plug-in, you may also reclaim a fantastic amount of
space by removing its data from your export file.

BTW, I have not tested it myself but there is a plug-in you might be
interested in using before you dump your old database: Wordpress Cleanup, by
Nisipeanu Mihai, discards comments tagged as spam as well as pages and posts
revisions: [plugin page](http://wiki.nisi.ro/my-wordpress-plugins/cleanup-
wordpress-plugin/).

## New Install

  
Create a new database, let's call it "new_database_name."  
You need to create a new install with the same version of Wordpress you are
currently running. It is very likely that you do not have the archive handy
anymore. It's not a problem: just go to
<http://wordpress.org/download/release-archive/> and download your version.

**Note:** You can check your current version in the Dashboard in the ACP
("Right Now")  
Expand the Wordpress archive to a new directory. By default, it will be
_wordpress/_. You can rename it to something else if you need to but I will
keep referring to it as _wordpress/_ in this post.  
Now, go to the link where your new "old" install can be found and install.
Provide your new database's info.  
When your pristine new blog is fully installed, import your cured file into
the new database, clobbering whatever was installed just now:

```bash
mysql new_database_name < tmp.sql
```

## Upgrade

This is where the magic happens. We are going to left Wordpress upgrade your
install.  
Until Wordpress 3.0 reaches final status, we will use Peter Westwood's plugin
to perform the upgrade. Get it from
<http://wordpress.org/extend/plugins/wordpress-beta-tester/>  
Activate the plug-in, then go to Tools > Beta Testing and select _Nightly
builds_.  
Finally, choose Tools > Upgrade.

Because you installed Wordpress in a new place, but you wish to preserve your
Google juice, you will want to make sure that your blog is still available at
the "old" place. Doing so requires playing musical chairs with your
directories. For instance:

```bash
mv old_directory bogus_name  
mv wordpress old_directory
```

But that's not all! You need to inform Wordpress of its relocation. In MySQL:

```sql
update wp_options set option_value=replace(option_value,'temporary_new_link','old_link');
```

For instance if your blog was originally found at http://example.com/blog and
you expanded your new Wordpress install at the same level, this new blog
should be found at http://example.com/wordpress.  
You would therefore type, from the command-line (you may also use a web
interface, simply adapt as needed):

```bash
mv blog old_blog  
mv wordpress blog
```

And in MySQL:

```sql
update wp_options set option_value=replace(option_value,'www.example.com/wordpress','www.example.com/blog');
```

You could, alternately, just completely remove your old directory. But it's
good practice to keep it around until you know that everything is spick and
span.

## Help! It's all messed up!

Well, let me know, I may be able to assist with that.  
Note that thanks to the paranoid steps we just took, it is extremely easy to
revert to your original install. Following the example we just used:

```bash
mv old_blog blog
```

Done!

