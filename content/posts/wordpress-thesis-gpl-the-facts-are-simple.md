---
title: "WordPress, Thesis, GPL: The Facts Are Simple"
description: "WordPress, Thesis, GPL: The Facts Are Simple"
slug: wordpress-thesis-gpl-the-facts-are-simple
date: 2010-07-18 03:13:01
draft: false
summary: "Update:Now a few days later, Thesis has been GPL'd and there isn't much left to say on this topic. However, for the sake of clarity, I would like to revisit a statement I made below: if Thesis contained *no* original WordPress code, considering that it is distributed on its own, and not shipped with a copy of WordPress, I am not sure how a court would see this. It is the intent of the GPL license that anything \"linked\" against GPL code becomes de facto GPL (if the executable and GPL code \"make function calls to each other and share data structures\") but I am not aware of a case where \"linking\" was the only, successfully argued point."
image: "701a3f6c-5caf-4142-878b-f2e6dfdb5abc.jpg"
---


[![](/images/gpl300.jpg)](http://www.flickr.com/photos/svensson/45394401/)
_ **Update:**_ Now a few days later, Thesis has been GPL'd and there isn't
much left to say on this topic. However, for the sake of clarity, I would like
to revisit a statement I made below: if Thesis contained *no* original
WordPress code, considering that it is distributed on its own, and not shipped
with a copy of WordPress, I am not sure how a court would see this. It is the
intent of the GPL license that anything "linked" against GPL code becomes _de
facto_ GPL ( _if the executable and GPL code "make function calls to each
other and share data structures"_ ) but I am not aware of a case where
"linking" was the only, successfully argued point.

_Disclaimer: I am a member of the Free Software Foundation and I work in a
corporate environment so I'd like to think that my views on open source are
fairly balanced._

The debate of whether Thesis should be licensed under the GPL (GNU Open-source
license) has been ongoing for a while but lately it has gotten more traction
following a fairly sad debate between Matt Mullenweg, founder of the WordPress
software and web sites, and Chris Pearson, who co-authored and distributes the
Thesis WordPress theme.

[Watch the video (50 minutes!)](http://wordpress.tv/2010/07/15/mixergy-
interview-pearson-mullenweg/)

This is another of these "debates" fueled by the notion that there are always
two sides to every issue. In many unfortunate cases, it turns out that the two
sides are "the facts" versus "stuff I just made up."

Let's get out the way the phrase that seems to be causing all the confusion:
it is claimed that Thesis works " **on top of** " WordPress. Well, that is
just plain misleading.  
Themes do not work "on top of" WordPress. They are not just dumb HTML tags;
they are PHP source code that is **linked** against WordPress's framework.

[Some bloggers](http://markjaquith.wordpress.com/2010/07/17/why-wordpress-
themes-are-derivative-of-wordpress/) have talked about the fact Chris lifted
some code from WordPress' original GPL'd code. Well, you know what? It is a
good point, yet  it does not even matter: even if that code was removed from
Thesis, its author would still have a problem.

WordPress is licensed under the GPL. The GPL stipulates that if you link
against a piece of GPL'd code, and run in the same process space, then you
have to GPL your code as well. This is very clearly stated in the
[FAQ:](http://www.gnu.org/licenses/gpl-faq.html#GPLIncompatibleAlone)

> **If license for a module Q has a requirement that's incompatible with the
GPL, but the requirement applies only when Q is distributed by itself, not
when Q is included in a larger program, does that make the license GPL-
compatible? Can I combine or link Q with a GPL-covered program?**  
>  If a program P is released under the GPL that means *any and every part of
it* can be used under the GPL. If you integrate module Q, and release the
combined program P+Q under the GPL, that means any part of P+Q can be used
under the GPL. One part of P+Q is Q. So releasing P+Q under the GPL says that
Q any part of it can be used under the GPL. Putting it in other words, a user
who obtains P+Q under the GPL can delete P, so that just Q remains, still
under the GPL.  
> If the license of module Q permits you to give permission for that, then it
is GPL-compatible. Otherwise, it is not GPL-compatible.  
> If the license for Q says in no uncertain terms that you must do certain
things (not compatible with the GPL) when you redistribute Q on its own, then
it does not permit you to distribute Q under the GPL. It follows that you
can't release P+Q under the GPL either. So you cannot link or combine P with
Q.

Chris is, maybe on purpose, showing a lack of understanding of the GPL
license. He argues that if you develop another application and wish to link it
to WordPress, then WordPress's license is, somewhat abusively, demanding that
you GPL your whole application.

That is not exactly true and the distinction matters.

_To be clear_ : GPL is not WordPress; it is disingenuous to paint WordPress as
a dictator who decides how you should license your code. All WordPress'
authors did was GPL WordPress' code, in effect saying "That's the license we
are adopting; please follow this license as well if you link to our product."

So, back to GPL: GPL does not necessarily require you to also GPL your code.
You have the alternative of NOT linking against GPL'd code. This is why the
FSF maintains a list of licenses known to be incompatible with GPL.

[GPL-Incompatible Licenses (gnu.org)](http://www.gnu.org/licenses/license-
list.html#GPLIncompatibleLicenses)

In a nutshell, it is the oldest rule in a free market: **if you do not like
our product, do not use it**.  
If you do not like WordPress' license, then link your code against another
CMS.

It is also very childish to claim that GPL cannot be enforced. Actually,
claiming that violating your partner'ss license (WordPress' GPL) is like
"getting away with a blowjob" is definitely not an argument that would hold
water in a court of justice.

[Michigan Finds GPL To Be
Enforceable](http://www.groklaw.net/article.php?story=20050225223848129)  
[Cisco settles with FSF on GPL
violations](http://www.linuxfordevices.com/c/a/News/Cisco-settles-with-FSF-on-
GPL-violations/)  
[Big GPL copyright enforcement win in Paris Court of
Appeals](http://arstechnica.com/open-source/news/2009/09/big-gpl-copyright-
enforcement-win-in-paris-court-of-appeals.ars)

Also, Google is your friend. It is very difficult to claim ignorance when all
the relevant information is so readily available.

