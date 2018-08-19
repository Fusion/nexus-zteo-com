---
title: "PHP PDO class and XAMPP/\"exotic\" MySQL configurations"
description: "PHP PDO class and XAMPP/\"exotic\" MySQL configurations"
slug: php-pdo-class-and-xamppexotic-mysql-configurations
date: 2009-10-01 09:26:51
draft: false
summary: "Last night I was trying to setup a @mail server but the installer kept choking when attempting to connect to my local database."
---


Last night I was trying to setup a [@mail](http://atmail.com) server but the
installer kept choking when attempting to connect to my local database.

I am posting here my quick workaround in case you too, dear reader, get a
dreaded "PDO" error message complaining about your attempt to " _connect to
unix://_ "

Here is I how I solved the issue for @mail: I opened
**library/Zend/Db/Adapter/Pdo/Abstract.php** , found the line that creates the
PDO object (" _new PDO(..._ ") and, in this example, the first argument passed
to the constructor was **$dsn**.

The problem is that PDO sees that this variables references " _localhost_ "
and decides that, since the database is local, it is going to use
**mysql.sock** (hence the _unix://_ scheme)

This works as long as the file is found in its default location. If it is
elsewhere, you are out of luck. This happens, for instance, if you use
[XAMPP](http://www.apachefriend.org).

Here is my quick fix, inserted right before the creation of the PDO object:

```php
$dsn = str_replace('host=localhost', 'unix_socket=/opt/lampp/var/mysql/mysql.sock', $dsn);
```

All done.

Note: I have not investigated enough to know whether this is something missing
in the Zend Framework or in @mail itself.

