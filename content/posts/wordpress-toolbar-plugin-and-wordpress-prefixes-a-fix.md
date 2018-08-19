---
title: "Wordpress Toolbar Plugin and Wordpress Prefixes: A Fix"
description: "Wordpress Toolbar Plugin and Wordpress Prefixes: A Fix"
slug: wordpress-toolbar-plugin-and-wordpress-prefixes-a-fix
date: 2009-02-17 03:23:45
draft: false
summary: "First of all, that's an awesome plugin that will allow your visitors to have a look at external links while retaining the ability to comment locally on your blog. Get it!"
---


[![Bandaid](http://farm2.static.flickr.com/1276/1350963678_6a230ad476_s.jpg)](http://www.flickr.com/photos/96878569@N00/1350963678/)First of all, that's an awesome plugin that will allow your visitors
to have a look at external links while retaining the ability to comment
locally on your blog. [Get it](http://abhinavsingh.com/blog/2009/02/wordpress-toolbar-plugin/)!

Unfortunately, if you have modified your Wordpress database prefix, for
instance because you are using Wordpress MU or the [Virtual Module](http://nexus.zteo.com/2009/02/13/fixing-permissions-after-a-wordpress-prefix-change/), the toolbar will fail to display.

Here is my very modest fix that will make it work.

1\. Open wordpress-toolbar/toolbar.php

2\. Find, near the top of the file:  

```php
$resultset = $wpdb->get_results("SELECT * FROM wp_options where option_name in ('wordpress_toolbar_social','wordpress_toolbar_excludedomains','wordpress_toolbar_skin','wordpress_toolbar_custom')");  
```

Replace with:  

```php
$resultset = $wpdb->get_results("SELECT * FROM {$wpdb->options} where option_name in ('wordpress_toolbar_social','wordpress_toolbar_excludedomains','wordpress_toolbar_skin','wordpress_toolbar_custom')");  
```

3\. That's it!

