---
title: "Your own Dynamic DNS in 3 steps"
description: "Your own Dynamic DNS in 3 steps"
slug: your-own-dynamic-dns-in-3-steps
date: 2011-12-29 02:00:48
draft: false
summary: "This is a \"niche\" post: it will really only appeal to you if you have access to your own -- or a friend's -- name servers and want to use your own domain to track your dynamic IP addresses, such as your home router's.You will still have to buy your own domain, cheap if you go to internet.bs or namecheap.com. I hear that the latter even provide their own dynamic DNS service although I cannot tell you anything about its quality/flexibility."
image: "74ea43b4-1e43-4294-a6b4-fa2f73e663ca.jpg"
---


[![Picture by Chazz Layne](/images/3849853039_7a466ff65a_z-225x300.jpg)](http://www.flickr.com/photos/chazzlayne/3849853039/in/photostream/)  
This is a "niche" post: it will really only appeal to you if you have access
to your own -- or a friend's -- name servers and want to use your own domain
to track your dynamic IP addresses, such as your home router's.  
You will still have to buy your own domain, cheap if you go to
[internet.bs](http://internet.bs) or [namecheap.com](http://namecheap.com). I
hear that the latter even provide their own dynamic DNS service although I
cannot tell you anything about its quality/flexibility.

So, why this post? It's for you, my friends, budding entrepreneurs who wish to
bootstrap your business and know that every cent counts. Maybe you feel that
you could host your product's web site on a home computer. Maybe you need more
control over what happens on that server. Or maybe you want to be able to log
on to your development machine from anywhere in the world.

Whatever your reasons, you're still here. So let's get started.

**1\. NTP**

First, for DNS updates to be accepted by BIND, the client that sends updates
needs for its internal clock to be closely in step with the DNS' clock. This
is, of course, achieved by running the network time protocol (NTP) at both
ends.

On RedHat:

```bash
yum install ntp
```

On Debian/Ubuntu/Mint:

```bash
sudo apt-get install ntp
```

OS X comes with NTP pre-installed.

Your NTP client should come with a configuration that will work with the
distro's own NTP servers. Check the content of _/etc/ntp.conf_. If no server
is provided, you can still test your configuration against
_**0.pool.ntp.org**_. It is nowhere near as nice as [adding your own ntp
server to the ntp system](http://www.pool.ntp.org/en/join.html) though.

Start the NTP daemon; this is typically done using:

```bash
/etc/init.d/ntpd start
```

Install this daemon so that it will always be automatically started:

```bash
chkconfig ntpd on
```

In OS X, this is a much easier configuration: open _System Preferences > Data
& Time_ and check 'Set date and time automatically'

On Windows, various options are available, including the open-source
[NetTime](http://www.timesynctool.com/).

**2\. BIND**

Here is a bit of info that you need to know: dynamic DNS will generate zone
files that will not be human-readable. Therefore you are not going to want to
maintain files that mix dynamic and static DNS information. That is why I
typically make a subdomain dynamic while leaving the domain itself static. For
instance, if you own the domain **mydomain.com** , I would recommend that you
create a new zone for **d.mydomain.com** and only that zone will be dynamic.

If, on the other hand, you do not need to maintain both static and dynamic
IPs, you obviously can make the whole **mydomain.com** dynamic.

OK, so that's where I'm lying. By omission. After all there is nothing
preventing you, as we shall soon see, to maintain a set of static addresses
alongside the dynamic ones in your update script.

Let's declare a dynamic zone in _/etc/named.conf_ (or
_/var/named/chroot/etc/named.conf_ if running BIND in a chroot environment):

```json
zone "d.mydomain.com" {  
        type master;  
        file "/var/named/data/d.mydomain.com.db";   
        allow-update { key host1.d.mydomain.com.; };  
    };
```

This tells BIND that a client providing the correct key 'host1.d.mydomain.com'
is allowed to update this zone file (d.mydomain.com.db)

This key needs to be present in named.conf as well:

```json
key host1.d.mydomain.com. {  
        algorithm hmac-md5;  
        secret "< your public key here >";  
};
```

We will see very soon where we get this key from. Note that you could decide
that you wish to be cleaner and store that key in an external file.

So, that was easy. However, this approach gives access to a full domain (
**d.mydomain.com** ) to a single user as long as they have the correct private
key in their possession.  
What if you wish to share a domain among multiple users, each only allowed to
modify their own host name?

That's where 'update-policy' can be useful.  
Here is your updated named.conf file to allow two different users to update
their respective host info:

```json
zone "d.mydomain.com" {  
    type master;  
        file "/var/named/data/d.mydomain.com.db"; 

    update-policy {  
        grant host1.d.mydomain.com. name host1.d.mydomain.com. A TXT;  
        grant host2.d.mydomain.com. name host2.d.mydomain.com. A TXT;  
    };  
};
```

Of course, the keys 'host1.d.mydomain.com' and 'host2.d.mydomain.com' need to
be present in the same file.

OK, we're almost there. Just one last bit of preparation will go a long way,
though: make sure that the user BIND is running as has write-access to the
zone hierarchy! Keep in mind that BIND will end up generating zone files,
unlike with static zones.

**3\. UPDATES**

Now, to update these zones remotely, we will rely on a traditional BIND tool
known as _**nsupdate**_.  
It is available on Linux and OS X. Instructions for installing on Windows can
be found [here](http://wiki.inisec.com/index.php/Nsupdate_for_windows) and, of
course, as usual Cygwin provides its own version.

Let's generate a key for our host1.d.mydomain.com. host:

```bash
dnssec-keygen -a hmac-md5 -b 128 -n USER host1.d.mydomain.com.
```

This will output two files:  
 _Khost1.d.mydomain.com.XXXXX.key_  
and  
 _Khost1.d.mydomain.com.XXXXX.private_

Get the key from the first file (just the segment that ends in '==') and use
it to replace '< your public key here >' in named.conf.

You can now focus on the client.

Here is a sample script I wrote that will perform a very minimal update every
half-hour. This script lives in /home/< your home dir >/DNS_KEY along with the
_Khost1.d.mydomain.com.XXXXX.private_ file.  
Obviously you will need to modify < your home dir >, < master DNS name >,
host1.d.mydomain.com and Khost1.d.mydomain.com.XXXXX.private:

```bash
#!/bin/bash

# Servers: http://dynupdate.no-ip.com/ip.php,
http://www.antedes.com/getip.php, ..?  
# Less straifghtforward: http://checkip.dyndns.org/, ...  
IPS=http://dynupdate.no-ip.com/ip.php

DNSP=/home/< your home dir >/DNS_KEY

while true; do

# First, retrieve IP address  
CURIP=`curl -s $IPS | awk '{ print $1 }'`  
OLDIP=`cat $DNSP/oldip`

# Compare to previously saved IP  
[ "$CURIP" == "$OLDIP" ] && continue  
echo $CURIP > $DNSP/oldip

# If different, tell DNS  
echo "server < master DNS name >" > $DNSP/zone  
echo "zone d.mydomain.com" >> $DNSP/zone  
echo "update delete host1.d.mydomain.com. A" >> $DNSP/zone  
echo "update add host1.d.mydomain.com. 14400 A $CURIP" >> $DNSP/zone  
echo "show" >> $DNSP/zone  
echo "send" >> $DNSP/zone  
/usr/bin/nsupdate -k $DNSP/Khost1.d.mydomain.com.XXXXX.private $DNSP/zone

# Sleeeeeeep I tell you  
# 1800 = 30 minutes  
sleep 1800  
done
```

You can install this script on Linux as your own daemon or run it manually
using 'nohup < scriptname > &' or get rid of the loop and use crontab.  
On OS X, I ask [Lingon](http://www.peterborgapps.com/lingon/) to start it
early on.

Do not modify the 30 minutes sleep time; be polite to these services that
provide your IP for fre.

**CONCLUSION**

Of course, you want to remember to restart BIND so that it will read its new
configuration. It will not need to be restarted again; it will automatically
integrate all dynamic updates.  
Hope this helps and as usual if you have questions I will try not to ignore
them for too long :)

