---
title: "Leopard: Quick Removal of iCalFix"
description: "Leopard: Quick Removal of iCalFix"
slug: leopard-quick-removal-of-icalfix
date: 2008-01-04 02:48:00
draft: false
summary: "Great news: with Leopard, there is no need for iCalFix anymore!Bad news: iCalFix is not compatible with the new version of iCal and the latter keeps complaining about the former.A lot of people have asked the author -BTW: thanks again, Robert, for creating iCalFix when it was needed- how to remove iCalFix but never got a reply."
---


![](/images/she-leopard.jpg) Great news: with
Leopard, there is no need for iCalFix anymore!  
Bad news: iCalFix is not compatible with the new version of iCal and the
latter keeps complaining about the former.  
A lot of people have [asked the
author](http://www.robertblum.com/articles/2007/10/16/ive-been-appled) -BTW:
thanks again, Robert, for creating iCalFix when it was needed- how to remove
iCalFix but never got a reply.

  

Here is a veeery simple fix:

  

Simply remove the input manager from /Library/InputManagers  
  
Using the shell:  
 _sudo rm -rf /Library/InputManagers/iCalFix_

