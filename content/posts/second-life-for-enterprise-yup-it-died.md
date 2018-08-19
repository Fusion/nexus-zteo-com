---
title: "Second Life for Enterprise: Yup, it died"
description: "Second Life for Enterprise: Yup, it died"
slug: second-life-for-enterprise-yup-it-died
date: 2012-03-15 23:21:40
draft: false
summary: "Note: an improved, cleaned up version of this post is available on the Hypergrid Business website."
image: "2674e18f-3aca-48f6-a705-0313597f541d.jpg"
---


 _ **Note: an improved, cleaned up version of this post is available on [the
Hypergrid Business website](http://www.hypergridbusiness.com/2012/03/second-
life-enterprise-was-a-costly-mistake/).**_

[![Credit: slwtf.com](https://slwtf.files.wordpress.com/2008/05/fujitsusiemens1.jpg)](https://slwtf.wordpress.com/2008/05/22/unashamed-of-what-it-is/)

How Bad Was Second Life Enterprise?

This is the first post in a series about Virtual Reality in an Enterprise
environment. I expect to talk about more positive experiences in future posts
but I need to start somewhere, so why not with what did not work for us?

## My (and my company's) experience

Second Life for Enterprise was a failure, in my case, for several reasons.
Note that this experience is my own, maybe other beta users had a better one.
Linden Labs announced the end of the experiment in August 2010.

Let's see what really did not pan out despite the promises of the platform.

## Ideal conferencing - not.

Features that would really have brought it closer to the ideal conferencing
tool were still far in the future:

1. Face capture and video feed embedded in avatar: this would allow other users to measure one's state of mind through their facial expressions. We were sold on the idea through a cool video of Ashton Kutcher's face mapped to this avatar's "head" showing him interact with Second Life and expressing obvious delight at what he was seeing.

1. Seamless Office documents integration: what a leap in the future this would have been! The only alternative available when giving a presentation using Powerpoint was to take screenshots of every slide, convert them using suitable jpg settings, then map them as textures to wall surfaces in Second Life. Supposedly this painful exercise was about to become a thing of the past "anytime soon."


## Not worth the cost

"cost" can be interpreted in - at least - two different ways, both of which
apply here.

Firsly, the entry cost to simply be a part of the beta, was between $50,000
and $100,000. For the first year.

For that money, you would receive two servers and access to an online help
desk. Tickets only.

Secondly, the ownership cost was just too high. So many prerequisites would
pop up as we progressed through the setup process that I reached a point when
I became quite convinced that the Linden people had never talked to anyone who
works in a big company. I could not imagine a use case that their process
would satisfy.

To wit:

* the customer did not have root access to their machines; that part I can understand. However, in order to perform simple configuration, I needed to be able to get our IT department to poke a hole for incoming SSH sessions in our firewall at the most random times. The Linden gremlins would then come in through this wall and type whatever one-liner was required.

* software upgrades were performed by swapping the existing hard drives with new hard drives they sent in the mail. In order to perform the swap successfully, I needed to work with our IT guys to have unfettered access to the data center for two days. Alternately, I could ask for an IT guy's time to be dedicated to this task for two days. The Linden people expected us to have someone continuously available to be on the phone with them as the upgrade went through. Note that, even if I did the upgrade myself, basic security rules require for IT personnel to be present in the data center at the same time as a non-IT person (me!) We originally thought this would be a non-issue as the tool was being marketed as a "turnkey" solution.

* support tickets could go unanswered for days and in some instances weeks. After several weeks of this frustrating dance, I finally realized what was going on: they were using the same ticket system for both enterprise customers and public grid Second Life users. Now, I do not know what their triage policy was but considering the delays in getting any kind of reply, I suspect it was not what an enterprise customer would have expected.

* I was not trying to do anything fancy; simply getting the servers up (which I eventually did) and run a few grids. Some of my basic questions left them dumbfounded. Questions I would have expected other beta testers to have asked as well.

* No tool was available to automatically export our existing public grid area and import it to our private grid. Instead, we had to compile a full inventory of every single prim, mesh, texture, animation, etc., and send them this list along with proof that we had all the copyrights cleared for all of them. They would then, after an indefinite period of time, send us an archive containing, hopefully, our stuff. That's when I started looking into the banned tools that some enterprising users had created to "steal" content and transfer it to OpenSim (or sometimes for quite shadier purposes)


## Irony

An important aspect of owning our private grid was using it to provide
training to our customers. We already had at least one major account asking
for virtual training since it would allow us to train geographically dispersed
technicians. We were also considering the potential for internal training and
this was obviously the first direction we would have taken the grid's design.

Unfortunately, educational tools such as
(http://www.sloodle.org/moodle/)[SLoodle] were only available for OpenSim, the
free and open-source competing virtual world package.

Worse, Linden Labs added a paragraph to their "leasing agreement" (I do not
remember what it was called exactly) that stipulated that we could only use
the grid internally, which meant keeping customers' employees off the grid. I
talked to the salesperson about my concern with that clause and got verbal
assurance that we would not have to worry about it. The agreement was not
amended, though.

Unfortunately, that's when I decided that it was definitely "not worth it."

## The aftermath

It is now obvious that Linden Lab's proverbial heart was never really in the
whole endeavor. Unfortunately, this means that the technologies I listed
earlier, such as real-time face capture and seamless office integration, were
never deployed in the enterprise.

Instead, we spent time and resources attempting to set up a product that did
not offer the minimum set of features that would have benefitted our company.
The vendor, likely realizing that they had waded in quicksands they knew or
cared little for, threw the towel not long after I had decided to cut our
losses.

An interesting take away lesson here is that, had we gone with an open-source
alternative, we would now be working with a product that's more current, was
not end-of-lifed and for which plenty of support is available. And the return
on investment would be, in comparison, astronomical.

