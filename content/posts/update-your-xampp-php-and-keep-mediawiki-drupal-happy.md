---
title: "Update your XAMPP PHP and keep Mediawiki & Drupal happy"
description: "Update your XAMPP PHP and keep Mediawiki & Drupal happy"
slug: update-your-xampp-php-and-keep-mediawiki-drupal-happy
date: 2010-09-22 07:19:29
draft: false
summary: "Once again, the -- otherwise very nice, I'm sure -- PHP people have done this thing that has made me miserable with my own open-source code and is now also affecting Mediawiki: in PHP 5.3.1, references passed to __call() are silently turned into values.Apparently, this bug was fixed but a contract was broken in the process: even if packages such as Wikipedia or Drupal were wrong in the way they were passing references, this used to work. Now, when running the same code, not only is a warning issued -- good -- but the function is not called. The latter is quite hard to justify.Of course, this means that a simple &ldquo;dot&rdquo; upgrade can render your whole website unusable; it&rsquo;s a pill that&rsquo;s a tad hard to swallow."
image: "73eeef74-26e5-4918-a6b3-36745bbf1b08.jpg"
---


![](/images/4331595990_614ef8f1b6-289x300.jpg)Once again,
the -- otherwise very nice, I'm sure -- PHP people have done this thing that
has made me miserable with my own open-source code and is now [also affecting
Mediawiki](http://bugs.php.net/bug.php?id=50394): in PHP 5.3.1, references
passed to ___call()_ are silently turned into values.  
Apparently, this bug was fixed but **a contract was broken** in the process:
even if packages such as Wikipedia or Drupal were wrong in the way they were
passing references, this used to work. Now, when running the same code, not
only is a warning issued -- good -- but the function is **not called**. The
latter is quite hard to justify.  
Of course, this means that a simple "dot" upgrade can render your whole
website **unusable** ; it's a pill that's a tad hard to swallow.

If you are running a LAMP stack, such as XAMPP, from
[ApacheFriends](http://www.apachefriends.org/), you may feel that you are
sorry out of luck. XAMPP, for instance, currently ships with PHP 5.3.1 and the
Mediawiki updater encourages you to either upgrade or downgrade your version
of PHP. How do you do this when running a full stack? XAMPP Beta, for
instance, does not come with an upgrade path to the next release. I scoured
the their forums and did not find much advice on how to get things back up and
running without pain.

So, here is how to **upgrade your PHP version** \-- and PHP only -- to 5.3.3,
while Apache, MySQL, etc. remain untouched. Oh and that 's on Linux.

Go to your XAMPP root directory. Typically:

```bash
cd /opt/lampp
```

Make a backup of your current PHP files (or not, it's up to you):

```bash
tar cvf BEFORE_php533.tar bin/php* etc/php* etc/pear* lib/* modules
```

Download XAMPP Beta from [http://www.apachefriends.org/en/xampp-
beta.html](/admin/blog/blogpost/134/)

Extract XAMPP Beta to, say, ~/Tmp/

Stop Apache:

```bash
/opt/lampp/lampp stopapache
```

Now, copy all the files you will need:

```bash
cp -rf ~/Tmp/lampp/bin/* bin/  
cp -f ~/Tmp/lampp/etc/p* etc/  
cp -rf ~/Tmp/lampp/lib/php lib/  
cp -f ~/Tmp/lampp/lib/libssl.so* lib/  
cp -f ~/Tmp/lampp/lib/libcrypto.so* lib/  
cp -f ~/Tmp/lampp/lib/libldap* lib/  
cp -f ~/Tmp/lampp/lib/liblber* lib/  
cp -rf ~/Tmp/lampp/modules lib/
```

Start Apache:

```bash
/opt/lampp/lampp startapache
```

## I want something simpler

  
OK, then. Simply download the "patch" below and extract it in your XAMPP root
directory. You will still need to restart Apache.

[Caution! 15MB Download.](http://rapidshare.com/files/420492816/php533up.tgz)

