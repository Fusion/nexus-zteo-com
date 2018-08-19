---
title: "C!D v2 = nextBBS multi"
description: "C!D v2 = nextBBS multi"
slug: cd-v2-nextbbs-multi
date: 2006-12-10 09:26:00
draft: false
summary: "Well, after spending quite some time cleaning up the code, making sure that no 'dangerous' Admin CP operation is available in multi-boards mode, and identifying which settings need to be made immutable, we are almost there."
---

    
    ![nextBBS](/images/logo_nextbbs.png)Well, after spending quite some time cleaning up the code, making sure that no 'dangerous' Admin CP operation is available in multi-boards mode, and identifying which settings need to be made immutable, we are almost there.
    
    
    
    
    
    I am currently working on the automatic setup script. Remaining to do:  
     **mkdir**  
     servers/SERVERID  
    servers/SERVERID/attachments  
    servers/SERVERID/avatars  
    servers/SERVERID/emoticons  
    servers/SERVERID/lang  
    servers/SERVERID/lang/en  
    servers/SERVERID/uploads  
    servers/SERVERID/templates  
    servers/SERVERID/templates/*  
    servers/SERVERID/templates/*_c
    
    
    
    
    
    **cp**  
     servers/SERVERID/emoticons/*  
    servers/SERVERID/templates/*[!_c]/*
    
    
    
    
    
    Note that the only 'router' module currently ready is the one based on subdomains. But that's all Clic!Dev needs anyway.
    
    
    
    
    
    Of course,  as usual with everything nextBBS, this code will be available in the software's next release. Your first chance to take a look under Clic!Dev's hood.

