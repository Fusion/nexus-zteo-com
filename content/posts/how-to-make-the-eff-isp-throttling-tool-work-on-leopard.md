---
title: "How To Make The EFF ISP Throttling Tool Work On Leopard"
description: "How To Make The EFF ISP Throttling Tool Work On Leopard"
slug: how-to-make-the-eff-isp-throttling-tool-work-on-leopard
date: 2008-08-02 22:54:00
draft: false
summary: "I love the idea of Switzerland, the new EFF tool for checking ISP throttling; unfortunately as of release Zero.0.5, Leopard seems to still be a mere afterthought. Here is how I worked around the few things that were not working out of the box."
---


![Switzerland
Logo](https://www.eff.org/files/action_images/switzerland_text_logo.png)I love the idea of [Switzerland](http://www.eff.org/press/archives/2008/07/31),
the new EFF tool for checking **ISP throttling** ; unfortunately as of release
Zero.0.5, Leopard seems to still be a mere afterthought. Here is how I worked
around the few things that were not working out of the box.

First, Switzerland is written in **Python** and will require **Psyco**. It's a
good thing since Psyco is all about performance. If you do not have it already
installed:  

```bash
svn co http://codespeak.net/svn/psyco/dist/ psyco-dist  
cd psyco-dist/  
sudo python setup.py install  
cd ..  
```

Download Switzerland from
<https://sourceforge.net/project/showfiles.php?group_id=233013>  
Extract it and change to its directory; eg  

```bash
tar zxvf switzerland-0.0.5.tgz  
cd switzerland-0.0.5  
```

The **FastCollector** provided doesn't work. So...  

```bash
rm bin/FastCollector.darwin  
```

Now when we build FastCollector, it will be available in
_/usr/local/bin/FastCollector_

Here comes the only moderately scary thing for non-developers. Use the
_**patch**_ command to modify _switzerland/client/PacketListener.py_. This is
the input for patch:  

```plaintext
diff --git a/switzerland/client/PacketListener.py b/switzerland/client/PacketListener.py  
    index 211b68f..dc0bbcc 100755  
--- a/switzerland/client/PacketListener.py  
+++ b/switzerland/client/PacketListener.py  
@@ -93,8 +93,7 @@ class PacketListener(threading.Thread):  
            p = platform.system()  
            # Implementing the recommendations from  
            # http://www.net.t-labs.tu-berlin.de/research/hppc/  
-        if p[-3:] == "BSD" or p == "Darwin":  
-          print p  
+        if p[-3:] == "BSD":  
            cmd = ["sysctl","-w","net.bpf.bufsize=10485760"]  
            try:     # Recent FreeBSDs  
                proc = Popen(cmd, stdin=PIPE, stdout=PIPE)  
@@ -110,6 +109,14 @@ class PacketListener(threading.Thread):  
                proc = Popen(cmd, stdin=PIPE, stdout=PIPE)  
                assert proc.wait() == 0  
    
+        elif p == "Darwin":  
+          cmd = ["sysctl","-w","debug.bpf_bufsize=10485760"]  
+          proc = Popen(cmd, stdin=PIPE, stdout=PIPE)  
+          assert proc.wait() == 0  
+          cmd[2] = "debug.bpf_maxbufsize=10485760"  
+          proc = Popen(cmd, stdin=PIPE, stdout=PIPE)  
+          assert proc.wait() == 0  
+  
            elif p == "Linux":  
            vars = [("/proc/sys/net/core/rmem_default", "33554432"),  
                    ("/proc/sys/net/core/rmem_max", "33554432"),
```

Let's build and install everything:  

```bash
sudo python setup.py install  
```

Well, it was easy (if it worked!)

Let's create a log directory for Switzerland:  

```bash
sudo mkdir /var/log/switzerland-pcaps  
sudo chmod a+wx /var/log/switzerland-pcaps  
```

And finally let's run it:  

```bash
sudo switzerland-client  
```

  
or if you wish to run your own server (you need to advertise it too!)  

```bash
sudo switzerland-client --server yourserveraddress  
```

Questions?

