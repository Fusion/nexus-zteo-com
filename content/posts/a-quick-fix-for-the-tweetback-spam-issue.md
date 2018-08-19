---
title: "A quick-fix for the Tweetback spam issue"
description: "A quick-fix for the Tweetback spam issue"
slug: a-quick-fix-for-the-tweetback-spam-issue
date: 2009-01-19 01:17:01
draft: false
summary: "I do not get it. I am a big fan of Smashing Magazine and I think that it was very nice of @jdevalk to write a plug-in that gives us full control over \"Tweetbacks\". See this blog entry.Where Smashing Magazine and the author lose me, though, is that I have not seen any reaction, either on the magazine's web site, or the author's blog, regarding the issue that many blogs who installed the plug-in seem to now be suffering: they are being  inundated with thousands of spammy Tweetbacks, most of them containing text like \"This is a test\", presaging a potentially much more virulent attack when the spammers get their tool working.In fact, it may not be spam, but simply some tests gone wrong, but whatever the reason it caused grief to many blog owners -- including me."
---


[![Yahoo Censorship Still Sucks, Part
Four](http://farm1.static.flickr.com/166/420604426_4498065bdc_t.jpg)](http://www.flickr.com/photos/51035555243@N01/420604426/
"Yahoo Censorship Still Sucks, Part Four")I do not get it. I am a big fan of
Smashing Magazine and I think that it was very nice of
[@jdevalk](http://twitter.com/jdevalk) to write a plug-in that gives us full
control over "Tweetbacks". See this [blog entry](http://yoast.com/tweetbacks-
wordpress/).  
Where Smashing Magazine and the author lose me, though, is that I have not
seen any reaction, either on the magazine's web site, or the author's blog,
regarding the issue that many blogs who installed the plug-in seem to now be
suffering: they are being inundated with thousands of spammy Tweetbacks, most
of them containing text like "This is a test", presaging a potentially much
more virulent attack when the spammers get their tool working.  
In fact, it may not be spam, but simply some tests gone wrong, but whatever
the reason it caused grief to many blog owners -- including me.

After de-activating the plug-in, here is the SQL command you can use to get
rid of these Tweetbacks:  

```sql
delete from wp_comments where comment_author_url like 'http://twitter.com/%/statuses/%';  
```

If you do not have access to your database, contact me, I may end up writing a
short plug-in that will wrap this query.

Again, I really like Smashing Magazine and that is why I am very surprised by
their silence on this issue.

