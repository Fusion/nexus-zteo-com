---
title: "S2ajax v1.0 connects simply PHP and JavaScript"
description: "S2ajax v1.0 connects simply PHP and JavaScript"
slug: s2ajax-v10-connects-simply-php-and-javascript
date: 2009-10-07 08:18:49
draft: false
summary: "Here comes S2ajax v1.0!And it was long overdue. Six months already since I posted S2ajax says \"hi()\" I can hardly believe it."
image: "33b3049c-7751-42bd-afec-f00aef8afed6.png"
---


![S2ajax](/images/S2ajax2.png)Here comes S2ajax v1.0!  
And it was long overdue. Six months already since I posted [_S2ajax says "hi()"_](/2009/03/02/php-classes-and-javascript-s2ajax-says-hi/) I can hardly
believe it.

What I think of as v1.0's main feature is that it is now possible to simply
**export classes** in PHP and these classes can be instantiated in JavaScript.
Whenever these instances are modified through asynchronous method calls, these
modifications are transparently **persisted** server-side.

# The concept

  
Is it a PHP class? Is it a JavaScript class? Why, it's both! The class is
defined in PHP on the server. Instances of the class are created on demand
using JavaScript on the client. Whatever modifications are made to an instance
are serialized on the server.  
You can create a complex application using as many classes and instances as
you need.

![100](/images/100.png)

# Under the hood

  
The PHP class is exported; the proxy JavaScript code is generated.  
Whenever the client needs to access one of the class' properties/methods, the
proxy **transparently** talks to the class; the class lives server-side.

![99](/images/99.png)

# The Client's point of view

  
An arbitrary number of **instances** of the class can be created in
JavaScript.  
The only hint that you are using a client-server architecture is the fact that
when invoking a method, its return value is obtained through a callback. This
mechanism allows your client interface to remain responsive while the server
is preparing a response.

![101](/images/101.png)

# The server's point of view

  
S2ajax automatically persists your instances' **state** and **data** between
consecutive asynchronous calls. You still get the benefits of the "shared
nothing" approach of PHP but complex objects can be manipulated through an
unlimited number of clients requests.

![102](/images/102.png)

# A code sample

#### Server-side

  
Let's create a class that will increment an instance variable every time a
method is invoked. Let's keep it as simple as possible:

```php
class CounterTester  
{  
    private $counter;

    function __construct() {  
        $this->counter = 0;  
    }

    public function increment_counter() {  
        $this->counter++;  
        return $this->counter;  
    }  
}  
```
Clearly, every time **increment_counter()** is invoked, _$counter_ will be
incremented and its new value returned.

#### Client-Side

  
First, an instance of our class is created. Then, when a user click on the
button labeled 'Increment counter', the instance's **increment_counter()**
method will be invoked and the new _$counter_ value returned to our callback
and displayed.

Increment counter  
  
Note that we could create as many instances of our class as we wish and
provided we display the matching buttons, we could independently increment
multiple counters.

# Get it now!

  
Click our valiant friend "Octocat", artistically represented below, to go to
S2ajax's Github page. If you just wish to use the library, look for the
[Download] button:

[![Git!](https://avatars2.githubusercontent.com/u/6265563?s=460&v=4)](http://github.com/Fusion/s2ajax)

Git!

