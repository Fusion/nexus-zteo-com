---
title: "Determining if an IP is within a specific range: redux"
description: "Determining if an IP is within a specific range: redux"
slug: determining-if-an-ip-is-within-a-specific-range-redux
date: 2009-04-30 08:11:05
draft: false
summary: "<div>I was reading Paul Gregg's very clear explanation of \"classless\" ranges comparison when I realized that his code was not as \"bare metal\" as could be.</div>"
image: "5cd62ec8-8c6d-4d02-8ac8-99884605bda7.jpg"
---
  
[![Submarine Net](/images/3025827461_5065a550e4_t.jpg)](http://www.flickr.com/photos/93752018@N00/3025827461/)I was reading Paul Gregg's very clear explanation of
"classless" ranges comparison when I realized that his code was not as "bare
metal" as could be.So, here is the code I've been using in nextBBS.It only
accepts ranges in the form "x.x.x.x/b" but it's short and all I needed,
really.  
  
```php
function isSubnet($subnet, $ip) {
    // Classless (in more than one way) comparison
    $cursubnet = explode('/', $subnet);
    $longsubnet = ip2long($cursubnet[0]);
    $longip = ip2long($ip);
    if(count($cursubnet){
        // Compare IP itself
        return ($longip==$longsubnet);
    }
    // IPv4 only!
    $subnetmask = 0xffffffff << (32-$cursubnet[1]);
    return (($longip & $subnetmask) == ($longsubnet & $subnetmask));
}
```

