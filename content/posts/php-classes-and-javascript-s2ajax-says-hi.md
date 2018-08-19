---
title: "PHP classes and Javascript: S2ajax says \"hi()\""
description: "PHP classes and Javascript: S2ajax says \"hi()\""
slug: php-classes-and-javascript-s2ajax-says-hi
date: 2009-03-02 08:27:55
draft: false
summary: "Sajax is a ‘managed’ AJAX framework that was created by the fine folks at Modern Method a few years ago.What’s so great about it is the seamless communication between your back-end and the web page itself: you write your PHP code, tell Sajax which functions to export and they are now accessible from Javascript."
---


![S2ajax Logo](/images/s2ajax1.png)Sajax is a ‘managed’ AJAX framework that
was created by the fine folks at [Modern Method](http://www.modernmethod.com/sajax/index.phtml) a few years ago.  
What’s so great about it is the seamless communication between your back-end
and the web page itself: you write your PHP code, tell Sajax which functions
to export and they are now accessible from Javascript.

For instance -- from the ‘example_types.php’ file:  

```javascript
function return_string() {  
    return "Name: Tom / Age: 26";  
}  
```

The corresponding Javascript call would be:  

    Return as string  

OK so this is a pretty great package, no doubt.

Unfortunately there are exactly three things that bother me here:  

  

1. The choice to prefix all remote calls with ‘x_’ which feels less natural, even though it is a convenient way to avoid namespace collisions.  



2. More importantly, Sajax does not support PHP classes and I am not comfortable working with strictly procedural code. After all, object-oriented PHP has been around for quite some time now.  



3. Of course, it would seem that the last Sajax release happened sometime in 2006, which would explain #2  

  

Thus, S2ajax was born.

If supports classes and methods, does not require prefixing and the export()
calls are now more powerful.  
The syntax is still very straightforward and relies on clean Javascript code.  
And the license, obviously, is still the very open BSD.

Additionally, this S2ajax can be easily integrated with PHP 5’s magic class
and methods loading. For instance, it works with [my own PHP
framework](http://github.com/Fusion/lenses/tree/master).

As usual, all this goodness is [**available at
github.com**](http://github.com/Fusion/s2ajax/tree/master)!

