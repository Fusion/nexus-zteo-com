---
title: "Condo"
description: "Condo"
slug: condo
date: 2012-11-21 09:16:36
draft: false
summary: "Condo is brand-new multi-environment hosting project that is currently in its early development stage."
---

## [August 2018 update]

*Condo was my very modest contribution to envisioning a future where we would use containers instead of VMs and dedicate them to specific, isolated tasks.*

*Less than a year after I created Condo, Docker was released and I shelved my amateurish attempt.*
*Now, reading the text below, I have mixed feelings: a good attempt, but no quite ambitious enough.*

---

## What ~~is~~ was Condo?

Condo is a brand-new multi-environment hosting project that is currently in its
early development stage.

## Condo in action



  
**A few interesting facts about this video:**  
  
* It runs in a virtual machine. Condo is compatible with VMs because Condo itself is not a VM; it is a jailed environment.  
  
* First, the super user creates an account for "Mr Johns." Mr Johns logs in, starts his own instance of lighttpd and MySQL and installs a couple applications.  
  
* It gets more interesting around 4:36, when the super user creates "Mr Smith." Mr Smith then starts his own instances, sets up security and installs his applications.  
  
* Notice how, when using the command-line, each sees their own file systems and processes. Because these processes are very lightweight, you can create many more environment, even in a VM!  
  
  
  

## Why Condo? Current brain dump



![](/images/braindump.jpg)



