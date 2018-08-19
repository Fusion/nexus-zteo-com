---
title: "How to host ZeroNet in a private IP container"
description: "How to host ZeroNet in a private IP container"
slug: How-to-host-ZeroNet-in-a-private-IP-container
date: 2015-05-15T21:30:25Z
draft: false
summary: "Not an issue, but I wasn't sure where to post this tip (so I posted it on Github, obviously)"
image: "733613cc-3abe-456e-812b-f5228367745e.png"
---
Not an issue, but I wasn't sure where to post this tip:
And, yes, I am aware that you may then want to protect your ZeroNet install(!)

Here is a typical configuration:

* Host machine runs haproxy
* ZeroNet in a Docker or OpenVZ container

1-Make the main UI available to the world:

In the container: 
```bash
python zeronet.py --ui_ip 0.0.0.0
```

On the host, you need to configure this container's IP in haproxy -- for instance, edit haproxy.conf:
```lighttpd
frontend http_in
    acl host_zeronet hdr(host) -i zeronet.example.com
    use_backend be_zeronet if host_zeronet
backend be_zeronet
    balance lastconn
    option httpclose
    server pub_zeronet :43110 cookie pub_zeronet check
```
Restart haproxy.

2-Make the file server available: I would recommend using NAT to avoid any surprise. In /etc/../iptables:

nat:
```
# we will nat incoming packets on port 15441
-A PREROUTING -i eth0 -p tcp -m tcp --dport 15441 -j DNAT --to-destination <container ip>:15441
-A PREROUTING -i eth0 -p udp -m udp --dport 15441 -j DNAT --to-destination <container ip>:15441
```
filter:
```
# host forwards incoming container packets
-A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -s <container network>/24 -i <bridge interface> -j ACCEPT
# host
accepts incoming container packets to its own services
-A INPUT -s <container network>/24 -i <bridge interface> -j ACCEPT
```
Cleanup your iptables configuration then
```
iptable-restore < etc/../iptable
```
And you're good to go! (in theory)

