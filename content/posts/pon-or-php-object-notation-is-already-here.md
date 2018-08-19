---
title: "PON or “PHP Object Notation” Is Already Here"
description: "PON or “PHP Object Notation” Is Already Here"
slug: pon-or-php-object-notation-is-already-here
date: 2008-02-09 01:01:00
draft: false
summary: "UPDATE"
---


 **UPDATE**

_MJ7's post, below, reminded me of the existence of this long forgotten post.  
As I had written in the comments, this tongue-in-cheek post was not meant to
be taken seriously. **Please, do not do this**._

![JSON](/images/json.jpg) JSON, or JavaScript
Object Notation, is fairly popular.  
This is just my modest take on a 'PHP Object Notation' implementation.  
Note that it is meant to follow how your **mind** works rather than being
syntactically correct; therefore, associative arrays are used in a loose
manner where you have to worry about associative syntax as little as possible.  
Basically, type away until your object is fully described.

Here is a notation sample:  

```php
array(  
        'root level' => array(  
                'sublevel 1' => array(  
                        'sublevel 2' => 'sublevel 3',  
                ),  
        )  
);  
```

This syntax can then be used the same way JSON is used, using _**eval**_. Here
is how and you will immediately notice how the eval() syntax has to differ
from the JavaScript one:  

```php
    $remote_str = << array(  
                'sublevel 1' => array(  
                        'sublevel 2' => 'sublevel 3',  
                ),  
        )  
);  
EOB;  
// ...  
eval('$local_str='.$remote_str.';');  
```

Feels a bit clumsy. Fortunately, starting with PHP4, if you are not too sad
about introducing a statement in your remote string, you can rewrite it like
this:  

```php
$remote_str = << array(  
                'sublevel 1' => array(  
                        'sublevel 2' => 'sublevel 3',  
                ),  
        )  
);  
EOB;  
// ...  
$local_str = eval($remote_str);  
```

Better, isn't it?

In this last listing, you will find the very simple code I wrote to
**traverse** the object. Note that I invoke a **callback** for every element,
otherwise this code would not be very helpful.

Note that this is just a concept for something I needed to throw together
quickly therefore there are some **limitations** ; for instance, you cannot
have numeric keys since in this context their "keyness" is ignored and even
feared.  

```php
$children)  
        {  
                if(!is_numeric($level))  
                {  
                        $my_uid = $callback($level, $padding, $uid);  
                        traverse_tree($callback, $children, $curdepth + 2, $my_uid);  
                }  
                else  
                {  
                        $callback($children, $padding, $uid);  
                }  
        }  
}

function do_something($name, $padding, $uid)  
{  
        $iid = 0; // Bogus value  
        print $padding.$name." ($iid)n";  
        return $iid;  
}

// -----------------------------------------------------------  
// Here we go  
// -----------------------------------------------------------  
if(count($argv) != 2)  
        die("nSyntax: ".$PHP_SELF." 'root_node_name'nn");  
$rootnodename = &$argv[1];

$INS = array(  
        $rootnodename => array(  
                'Bikes' => array(  
                        'Yamaha' => 'Fz',  
                        'Honda',  
                        'Norton'  
                        ),  
                'Trikes',  
                'Cars' => array(  
                        'Chevrolet' => array(  
                                'Corvette' => array('Z06', 'Convertible', 'Coupe'),  
                                'Camaro',  
                                'Jimmy'  
                                ),  
                        'Ford' => array(  
                                'Mustang' => array('GT', 'Premium', 'Shelby', 'Other'=>'Roush'),  
                                'Explorer',  
                                'Crown Victoria'  
                                ),  
                        'Chrysler' => array(  
                                'Dodge' => 'Charger',  
                                '300X',  
                                'Le Baron'  
                                ),  
                        )  
        )  
);

traverse_tree(do_something, $INS, 0, 1);

print "DONE\n\n";  
?>  
```

Invoke with:  

```bash
    php my_php_script.php "Vehicles"  
```

"What is this $iid variable?" you may ask.  
You will notice that this piece of code is particularly convenient if you want
to add a whole tree structure to your database. Say the you are using
**MySQL** and want to create **categories** and sub-categories, using the
column 'pid' as a category's **parent id**. You would rewrite _do_something_ :  

```php
function do_something($name, $padding, $uid)  
{  
        mysql_query("INSERT INTO my_cat_table(pid, title) VALUES({$uid}, '{$name}')");  
        $iid = mysql_insert_id();  
        print $padding.$name." ($iid)n";  
        return $iid;  
}  
```

Voila!

