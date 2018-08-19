---
title: "Where is getElementsByClassName()?"
description: "Where is getElementsByClassName()?"
slug: where-is-getelementsbyclassname
date: 2007-01-15 00:11:00
draft: false
summary: "Since one of the goals of this blog is to show you how we resolved some of the issues we encounter when writing modern Web applications, allow me to repost this short article that I originall posted at goodjavascript.com"
---


Since one of the goals of this blog is to show you how we resolved some of the
issues we encounter when writing modern Web applications, allow me to repost
this short article that I originall posted at
[goodjavascript.com](http://www.goodjavascript.com)

It's an extremely common problem: you want to retrieve all the "special" links
embedded in your web page. Or all the text areas with a certain style.  
You looked at someone else's code and found that they use the method
**_getElementsByClassName()_** profusely.  
However, when you tried, there was no such method.  
  
 **Confused?**  
Here is the skinny on this method: it does not exist. Everybody has to code
their own. And most of the time, it is poorly coded and will catch  
unrelated classes in the process.

So, here is my implementation, which I kept as short as possible and yet, it
is reliable:  

```javascript
document.getElementsByClassName = function(className)  
{  
        var expression = new RegExp('(^| )'+className+'( |$)');  
        var allelements = document.body.getElementsByTagName('*');  
        var elements = [];  
        for(var i=0; ilength; i++)  
        {  
                var element = allelements[i];  
                if(expression.test(element.className))  
                {  
                        elements.push(element);  
                }  
        }  
        return elements;  
};
```

  
A quick explanation:

```javascript
var expression = new RegExp('(^| )'+className+'( |$)');
```
We create a regular expression that can find the class name we are looking for
anywhere in a string. Note that the DOM class attribute can contain a blank
space-separated-list of class names.

```javascript
var allelements = document.body.getElementsByTagName('*');
```
We retrieve all the elements in the current page.  
We could replace document.body with an existing DOM element and only perform a
search on a subtree of our page.

```javascript
if(expression.test(element.className))
```
Use the regular expression we created earlier to find whether an element uses
this class name.

