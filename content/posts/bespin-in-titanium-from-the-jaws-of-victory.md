---
title: "Bespin in Titanium: From The Jaws Of Victory..."
description: "Bespin in Titanium: From The Jaws Of Victory..."
slug: bespin-in-titanium-from-the-jaws-of-victory
date: 2009-04-06 07:31:59
draft: false
summary: "bespin is really an intriguing project. Since I've grown frustrated with the inconsistencies between the various code editors that I have been using -- I work on Leopard at home and Ubuntu at work -- I thought that creating my own editor would be the answer to that. Nothing fancy, mind you. Just something consistent."
---


[bespin](https://bespin.mozilla.com/) is really an intriguing project. Since
I've grown frustrated with the inconsistencies between the various code
editors that I have been using -- I work on Leopard at home and Ubuntu at work
-- I thought that creating my own editor would be the answer to that. Nothing
fancy, mind you. Just something consistent.

My first impulse was to use Flex. And it almost worked! Using `mx:html` I was
able to wrap a nice web page in an otherwise very ActionScript-y application.  
And then, catastrophe! Flex Webkit's canvas implementation is subpar and I
could only get a very mamed version of bespin. Nothing usable, anyway.

Thus, I turned to [Titanium](http://titaniumapp.com/).  
After some light trial and error, I got it to work!

Unfortunately, the result is less than awesome: Titanium's Webkit gets easily
overwhelmed and, worse, crashes reliably ( :g: ) as soon as I ask it to do
some medium lifting.

This video shows the original victory followed by the vexing defeat:

Note that, to get it to work, I replaced _embed.js_ with my own version that
works around any `dojo.request()/eval` issue:  

```javascript
(function() {  
    // -- Load Script  
    var loadme = new Array();  
    var loadScript = function(src, onload) {  
        var embedscript = document.createElement("script");  
        embedscript.type = "text/javascript";  
        embedscript.src = src;  
        embedscript.onload = onload;  
        document.getElementsByTagName("head")[0].appendChild(embedscript);  
    }  
    var onScriptLoaded = function() {  
        var src = loadme.shift();  
        if(src)  
            loadScript(src, onScriptLoaded);  
    }  
        
    var componentRequires = function() {  
        dojo.require("bespin.bespin");  
            
        dojo.require("bespin.util.canvas");  
        dojo.require("bespin.util.keys");  
        dojo.require("bespin.util.navigate");  
        dojo.require("bespin.util.path");  
        dojo.require("bespin.util.tokenobject");  
        dojo.require("bespin.util.util");  
        dojo.require("bespin.util.mousewheelevent");  
        dojo.require("bespin.util.urlbar");  
            
        dojo.require("bespin.client.filesystem");  
        dojo.require("bespin.client.settings");  
        dojo.require("bespin.client.status");  
        dojo.require("bespin.client.server");  
        dojo.require("bespin.client.session");  
            
        dojo.require("bespin.editor.actions");  
        dojo.require("bespin.editor.clipboard");  
        dojo.require("bespin.editor.cursor");  
        dojo.require("bespin.editor.editor");  
        dojo.require("bespin.editor.events");  
        dojo.require("bespin.editor.model");  
        dojo.require("bespin.editor.toolbar");  
        dojo.require("bespin.editor.themes");  
        dojo.require("bespin.editor.undo");  
            
        dojo.require("bespin.syntax.base");   
        dojo.require("bespin.syntax.simple._base");  
            
        dojo.require("bespin.cmd.commandline");  
        dojo.require("bespin.cmd.commands");  
        dojo.require("bespin.cmd.editorcommands");  
            
        dojo.require("th.helpers"); // -- Thunderhead... hooooo  
        dojo.require("th.css");  
        dojo.require("th.th");  
        dojo.require("th.models");  
        dojo.require("th.borders");  
        dojo.require("th.components");        
    }  
        
    loadScript("js/dojo/dojo.js.uncompressed.js", function() {  
        dojo.require = function(src) {            
            loadme.push('js/' + src.replace(/\./g, '/') + '.js');  
        }  
        componentRequires();  
        dojo.require("bespin.editor.component");  
        loadScript(loadme.shift(), onScriptLoaded);  
    });  
})();  
```

As you can see, I override dojo.request() with my own, stack up all the
component names, then load them one by one, waiting for each to be fully
loaded before moving on.

