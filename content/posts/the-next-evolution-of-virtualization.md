---
title: "Virtual Machines Are Not The Future Of Virtualization"
description: "Virtual Machines Are Not The Future Of Virtualization"
slug: the-next-evolution-of-virtualization
date: 2014-03-24 06:16:02
draft: false
summary: "I usually reserve this kind of wall of text for my poor coworkers but not today. Share the pain!"
image: "cdc45e3c-d96b-403a-9c63-b08de33b292f.jpg"
---


![](/images/containers_500.jpg) I usually reserve this kind of wall of text for my poor coworkers but not today. Share the pain!_

You may know this about me or you may not but over the years I have been a
kind of closet futurist: I mean by that that I will occasionally come up with
a proof of concept for something that may happen within the next few years but
I rarely take the time to do much more at it does not align with my current
goals.  
No, I did not predict the existence of [the Moto 360](http://www.xda-
developers.com/android/try-a-few-simple-apps-for-the-android-wear-emulator/);
like most of us I do not do well with the future of sexiness.  
More importantly, I can only conceptualize what really hits me in the face
every day. I am a slow learner.

I was, however, evangelizing [UML](http://user-mode-linux.sourceforge.net/)
(User Mode Linux) as early as 2001. I think I was right as virtual machines
seem to have gotten some traction since then :)

Note that I am talking I about UML rather than a more big gun product such as
vmware.

Then, roughly four years before docker saw the light of day, I created [a tech
demo called Condo](/condo/). I guess you can see where both names can describe
a similar concept.  
  
This is where the "every days" concept comes into play: I used to run a
somewhat small [web hosting company](http://hostinggroup.com/). Our offering
consisted of shared hosting, dedicated servers and some vps (virtual private
servers) and very occasionally rack space colocation.

Here is what you quickly learn in this business: you can make money of
dedicated servers but only if you sell tens of thousands of them. Thousands or
even hundreds of servers? Your margins are laughable and you have no leverage
with your vendors.  
Colocation? Why not, as long as you are sure to front all the costs associated
with renting rack cages upfront and realize that bandwidth is not your biggest
cost (think power and, if the hopefully carrier neutral data center you are
leasing in is not local, the cost of remote  
hands)  
So you are left with shared hosting and vps. Of course the former is rarely
done right and ends up being a maintenance nightmare while the latter does not
scale well for anyone, customer or provider.

I believe the **challenges** faced by **enterprise** data centers these days
are **very similar** to those seen in shared data centers.  
A one size fits all solution such as virtual machines can help businesses save
on hardware costs but in the end they are heavy to manage; on the other hand,
simpler solutions based on a shared environment offer little advantages with
regards to resource allocation and security. This is why I wrote Condo in '09.

The ways I see it, more customized solutions such as **properly virtualized
containers** , are where the real value comes from. I would wager money that
in the next few years we are going to see the emergence of companies we have
never heard of in that domain: software vendors who specialize in building
**tailored environments** based on common templates.

This is something we are seeing today on a per-application basis; beyond the
whole SaaS movement, lies what I cannot refer to as a cottage industry
anymore; a cloud of development contractors specializing in tailored CMS
installs, running on top of Drupal or Wordpress.

I believe the future of virtualization is similar: with the technologies now
available to container creators (jails, network namespaces, active quotas,
etc) the line between shared resources and virtualized machines is
increasingly blurred.

There are many things that Docker does extremely well; for instance, unlike
Condo, support for COW (Copy On Write) was baked in early on and you can
snapshot and roll back images. However, managing Docker instances remains an
arcane art.  
Where third parties have focused on managing virtual machines, it seems
logical to me that the first company to offer an easy **turnkey management
solution** for **Docker containers** should make a pretty penny.

Furthermore, I believe that less generic, more **project-focused virtualized
environments** are inevitably coming: not necessarily pure containers but
virtual machines rebuilt to run specific applications. This is where UML/KML
could provide the building blocks, while mixing this approach with less
resource hungry designs used in containers.

If you are still reading, I apologize for taking you along for what ends up
being mostly a stream of consciousness post. Hopefully I will have time to
revise it with more concrete technical data.

So, this is my bet. Let's see how much of a fool it makes me look like within
the next two to three years. Those who know me may remember my early claims
that " the iPhone makes no sense; everybody wants a physical keyboard!" so
there is that.

