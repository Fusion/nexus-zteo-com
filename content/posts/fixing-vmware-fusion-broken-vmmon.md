---
title: "Fixing Vmware Fusion Broken Vmmon"
date: 2019-02-23T14:06:09-08:00
draft: true
---
Obviously, this post is MacOS-specific. This is about when Fusion throws the dreaded

> /dev/vmmon: broken pipe

or

> /dev/vmmon: No such file or directory


Here are three different fixes, because this is definitely nor a "one size fits all" scenario:

## 1-If Fusion complains about not being authorized

Go to the {{< simpleitem 1>}}Security and Privacy{{< /simpleitem >}} control panel; make sure that both App Store and signed applications are authorized; check that Fusion is not explicitely blacklisted.

## 2-Starting with Mojave: is disk access authorized?

In the same control panel, go to the {{< simpletab 1>}}Privacy{{< /simpletab >}} tab and make sure that Fusion is allowed to write to disk...

## 3-If Fusion still complains about not being authorized

Check if it's because the image itself got quarantined: run

```bash
xattr -l ~/Downloads/VMware-Fusion-*.dmg | grep quarantine
```

If you are getting any output, this is going to be a bit more work: you need to uninstall Fusion; run the command below; re-install Fusion:

```bash
xattr -dr com.apple.quarantine ~/Downloads/VMware-Fusion-*.dmg
```

## 4-If that still did not help

Maybe you have loaded too many kernel extensions (kext files) -- this can happen easily if you also installed VirtualBox, Parallels, etc.

Run:

```bash
kextstat | grep com.vmware |  awk '{print $6}'
```

You should get something similar to:

>com.vmware.kext.vmci

>com.vmware.kext.vmnet

>com.vmware.kext.vmx86

>com.vmware.kext.vmioplug.18.1.2

If you are getting fewer rows, this could be your issue. Now, you need to select what other software you wish to sacrifice to allow Fusion to work.

Let's say you decide on VirtualBox. First, remove it from your system. I find something like [App Zapper](https://www.appzapper.com/) to be quite thorough. Unfortunately, even this little guy will not remove the kexts. You will need to remove them manually.

As super user, run:

```bash
for kext in $(ls /Library/Application\ Support/VirtualBox); do
  kextutil /Library/Application\ Support/VirtualBox/${kext} \
    -r /Library/Application\ Support/VirtualBox;
done
```

Voila. (I hope!)
