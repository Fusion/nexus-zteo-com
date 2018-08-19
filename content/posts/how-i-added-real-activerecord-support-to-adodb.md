---
title: "How I added real ActiveRecord support to adodb"
description: "How I added real ActiveRecord support to adodb"
slug: how-i-added-real-activerecord-support-to-adodb
date: 2008-07-26 08:49:00
draft: false
summary: "For my new projects, I have decided to use PHP5, mostly because at least a couple projects will be worked on by a team and the learning curve is fairly forgiving.I decided, however, to follow the model offered by Rails.  I looked into a few PHP frameworks, such as Akelos, but realized that they were too constraining for our purpose. That's when I decided to develop my own thin layer framework."
---


[![Dead hard drive](/images/134586223_76a9fdeeeb_m.jpg)](http://www.flickr.com/photos/hindesite/134586223/)For my new projects, I have decided to use **PHP5** , mostly
because at least a couple projects will be worked on by a team and the
learning curve is fairly forgiving.  
I decided, however, to follow the model offered by **Rails**. I looked into a
few PHP frameworks, such as Akelos, but realized that they were too
constraining for our purpose. That's when I decided to develop my own thin
layer framework.

An excellent productivity tool is the **ActiveRecord** pattern. After all, it
doesn't matter what it is, that's being mapped; whether it's database tables
or web services should not be relevant to the controller.  
I have, in the past, used [adodb](http://adodb.sourceforge.net/) successfully
and I was happy when I realized that it comes with a ADOdb_Active_Record
class.

Unfortunately, that class does a very basic job of mapping **one** class to a
database table and that's it. Therefore, support for **has_many** or
**belongs_to** clauses.  
I know that AR offers more features that those but I thought that these fit
the very minimum requirement for them to be useful.  
And that's how I ended up modifying ADOdb_Active_Record to support these.

This article is mostly a series of listings that show the modifications-a bit-
and how to use them-a bit more. First, here is how I am using them in my
framework:  
Let's imagine a database that contains songs, artists and genres. Let's look
at the definition of a Song object:  

```php
belongsTo('artist');  
                $this->belongsTo('genre');  
        }  
}  
?>
```

and an Artist object:  

```php
hasMany('songs');  
        }  
}  
?>  
```

let's have a look at a very basic controller that will allow us to retrieve
our artists. Their songs will also be retrieved, since artists are defined as
having many songs:  

```php
artists = &$artist->find(ALL, "artists.id=1", array('loading'=>ADODB_LAZY_AR));  
        }  
}  
?>  
```

Through the magic of my framework, which is outside the scope of this post, we
will then be able to display our artists with their respective songs like so:  

```php
        {$artist->name}

";  
                foreach($artist->songs as $song)  
                {  
                        print "    TITLE:{$song->title}  
";  
                }  
        }  
        ?>
```

Note that, for this example, I removed as many irrelevant pieces of code as
possible. For instance, we are always retrieving artist #1. The array that we
are passing to the find() statement allows us to configure some of AR's
behaviours. In this example, we are passing ADODB_LAZY_AR, which is a hint
that we do not wish to perform massive joins, but retrieve related objects
**on demand**. If we wished to retrieve everything upfront, we could have used
ADODB_JOIN_AR instead.

Now, our model classes are subclasses of ActiveRecord, which is another one of
my framework classes, which provides a light abstraction on top of
ADOdb_Active_Record. The relevant piece, for you, would be this one since we
invoke it:  

```php
        function find($mode, $condition=null, $extra=array(), $bindArr=false, $pKeyArr=false)  
        {  
                // id?  
                if(ctype_digit($mode))  
                        return $this->load($mode);





                // return one row  
                if(FIRST == $mode)  
                        return parent::load($condition);





                // Assumption: ALL == $mode - return multiple rows  
                return parent::find($condition, $bindArr, $pKeyArr, $extra);  
        }  
```

It is interesting because the last line contains the actual call to
ADOdb_Active_Record's find() method.

In adodb itself, two files were modified: adodb-active-record.php and
adodb.inc.php.

The former now contains two new structures: _hasMany and _belongsTo. ARs are
now aware of the concept of foreign name, which is the name by which this
object will be known to another object if a relationship is defined. This
allows us, among other things, to naturally _inflect_ tables names.

The latter was modified so that it accepts extra parameters, for instance in
GetActiveRecordsClass(), and handle massive joins. Note that joins can be
deferred through the use of ADODB_LAZY_AR. In which case I will use the model
objects' __get() method to load missing properties on-demand.

**"Buyer Beware"**  
I hope to publish my full PHP framework in the near future; in the meantime,
this hacked version of adodb has been very helpful in my work. I hope you too
find it helpful. Beware, though: this is an early work and I would rather
offer it to John Lim and let him integrate it in adodb-or can it if he's too
horrified!  
I am aware of at least one bug, which may happen when using the join method on
belongs_to objects. It could also do more things for you. Definitely not the
cat's meow.  
But if you like it and need help, drop me a line.

[![Download](/images/download.png)](http://twitterified.com/file/get/adodb-
ext-ar.zip "Download patched adodb files")

