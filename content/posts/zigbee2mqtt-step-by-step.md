---
title: "Zigbee2mqtt Step by Step"
date: 2018-12-25T16:24:11-08:00
draft: false
image: "zigbee-logo.jpg"
---



Here is a solution to build and use your own Zigbee controller. It will work with most Zigbee devices out there, simply because it doesn't come with any manufacturer-specific assumptions.

<!--more-->

This is achieved by using your own hardware to sniff Zigbee packets and correctly interpreting these packets to feed relevant information to your iOT platform of choice. In my case: [Home Assistant](https://www.home-assistant.io/).

The name of this project is [Zigbee 2 MQTT](https://github.com/Koenkk/zigbee2mqtt) and you can get support directly from Koen Kanters on the [Home Assistant forum topic](https://community.home-assistant.io/t/zigbee2mqtt-getting-rid-of-your-proprietary-zigbee-bridges-xiaomi-hue-tradfri).

It is a bit tricky to get working because every step needs to be performed in the correct order. So, here goes.

# Hardware

First, you need hardware that will work with this project. You will be using a Texas Instruments CC2531USB sniffer to read/write Zigbee RF packets. I found mine in this eBay listing: [CC2531 CC2540 Sniffer Protocol Analyzer USB Dongle&BTool + Downloader for Zigbee](https://www.ebay.com/itm/CC2531-CC2540-Sniffer-Protocol-Analyzer-USB-Dongle-BTool-Downloader-for-Zigbee/202095932748?ssPageName=STRK%3AMEBIDX%3AIT&var=502090253363&_trksid=p2057872.m2749.l2649). Yes, it comes with its own download cable.

![Example image](/images/cc2351.jpg)

You also need to flash a specific firmware om this dongle. The firmware can be found [here](https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator/CC2531/bin) and the box to flash it in this listing: [CC Debugger and Programmer Downloader for RF System-on-Chips ICSH015A](https://www.ebay.com/itm/CC-Debugger-and-Programmer-Downloader-for-RF-System-on-Chips-ICSH015A/291997463057?ssPageName=STRK%3AMEBIDX%3AIT&_trksid=p2057872.m2749.l2649).

![Example image](/images/ccdebugger.jpg)



It should get a couple weeks for these components to arrive after you order them.

[This page](https://koenkk.github.io/zigbee2mqtt/getting_started/flashing_the_cc2531.html) does a pretty good job of explaining how to flash the firmware. A few things that are not immediately clear, though:

- Make sure that **both** the programmer/debugger box and the cc2351 dongle are connected to your computer's USB ports!
- On Windows, if the programmer shows in your Device Manager as an unknown device, you need to manually update its device driver. Right-click, select *Properties* then *Update Driver*. From the CC Debugger Driver archive, select *cebal/win_64bit_x64/* or from the *SmartRF Tools* folder itself, select *Drivers/Cebal/win_64bit_x64*.
- The programmer may not be able to "see" the dongle. In this case, you may need to first upgrade the programmer itself: using the same tools recommended in this page, you can not only flash the dongle itself, but you can also update the programmer's firmware as well: select the firmware from *SmartRF Tools/Firmware/CC Debugger/cebal_fw_sf05dbg.hex* and in the tool itself under "What do you want to program?" select "Program Evaluation Board"

If, despite all this, the programmer's light remains red, triple-check your connections. If this doesn't fix it, I am sorry to have to tell you that some of these guys may be defective (check there is no bridge in the jumper headers, these amazingly cheap components sometime suffer from some shoddy soldering)

# Connectivity

Now, for what you might expect to be the "easier" part. It may not be.

When you insert the dongle in a Linux box's USB port, a new device should show up: likely */dev/ttyACM0* or */dev/ttyUSB0*. In my case, because I already had a ZWave USB stick in another port, the Zigbee dongle ended up being */dev/ttyACM1*.

## Nothing shows up...

First check the output of `dmesg` and see if anything suspiscious is in there. If you see a message informing you that some unknown USB device was added, but nothing more, your kernel may be missing a driver for the 'gadget' protocol.

Run this command:

```bash
lsmod | grep cdc_acm
```

If it does not return anything, you will need to add this driver.  Sorry, but this case would require its own blog post. Or... you could take the easy path, if you have another Linux laptop where this driver is installed.

If it does return something, however, the kernel may simply have missed the insertion. Try reloading the driver:

```bash
rmmod cdc_acm && modprobe cdc_acm
```

### What was that about another laptop?

Ah, yes. In my case, the laptop I was trying to run Zigbee2mqtt on is running an older version of RancherOS. But, since I had another laptop running a less exotic kernel, I decided to share the device between the two laptops. This is pretty easy.

On the device with the "good" kernel, install `socat` and run:

```bash
sudo tcp-l:4001,keepalive,reuseaddr /dev/ttyACM0
```

On the laptop you wish to mount this device:

```bash
sudo socat pty,link=/dev/lio0,user=rancher,group=dialout,mode=660,ignoreof,waitslave tcp:{connected host ip}:4001
```

**By the way** do not forget to add your user to the group this device will belong to. For instance:

```bash
usermod -aG dialout {your user}
```

# Pairing

* Install Zigbee2mqtt as described [here](https://koenkk.github.io/zigbee2mqtt/getting_started/running_zigbee2mqtt.html). An easy way to install the pre-requisite Node is to use [nodenv](https://github.com/nodenv/nodenv)

```bash
nodenv install 10.14.2
echo 'export PATH=~/.nodenv/versions/10.14.2/bin:~/.nodenv/bin:$PATH' >> ~/.bashrc
exec bash
```

- In the configuration file (*data/configuration.yaml*) make sure that you have:

```yaml
homeassistant: true
permit_join: true
mqtt:
  base_topic: zigbee2mqtt
  server: 'mqtt://{IP address of your mqtt broker}'
serial:
  port: /dev/ttyACM0
```

- Insert the dongle into the USB port. The green LED turns on.
- Push the tiny *debug* button next to the USB connector. The LED should turn off. Do not skip this step!
- Run Zigbee2mqtt:

```bash
npm start
```

When the server tells you it is ready, you can start pairing your device.

In my case, I am installing a [Sengled lightbulb](https://us.sengled.com/products/element-classic-kit). To initiate pairing, I turn it on, then off-on 10 times.

After a while, you should start seeing log entries about receiving messages from an unknow device. Eventually, this unknown device will become known. Score!

## It doesn's show up in Home Assistant

In Home Assistant's *configuration.yaml* check your `mqtt` entry.

If you are also using a Smartthing MQTT bridge, you will need to remove the filter. Delete:

```yaml
  discovery_prefix: smartthings
```

You also need to tell mqtt what topics to pay attention to:

```yaml
mqtt:
  broker: {IP address of your mqtt broker}
  discovery: true
  birth_message:
    topic: 'hass/status'
    payload: 'online'
  will_message:
    topic: 'hass/status'
    payload: 'offline'
```

Restart Home Assistant!

## I need to remove the pairing

This could happen because you have had unsuccessful attempts at discovering the new device. Now, when Zigbee2mqtt comes up, it reminds us how it "knows" about this device. Maybe it does. Maybe not well enough. Maybe Home Assistant does not want to hear about this device *again*.

Let's make both Zigbee2mqtt and the dongle forget about this device.

Software-side, it is as simple as removing our local database:

```bash
rm data/database.db
```

Dongle-side, let's write a quick program that will perform a hard reset:

```js
# cfr.js

const ZShepherd = require('zigbee-shepherd');
const zserver = new ZShepherd('/dev/ttyACM0');

zserver.on('ready', function () {
    zserver.reset(0, function (err) {
        if (!err)
            console.log('reset successfully.');
        else
            console.log("error: " + err);
    });
});


zserver.start(function (err) {
    if (err)
        console.log(err);
});
```

You need to fix a minor bug in Zigbee2mqtt due to Node's library updates:

In `node_modules/zigbee-shepherd/lib/shepherd.js` look for 'baudrate' and update the line with 'baudRate'

```js
    spCfg.options = opts.hasOwnProperty('sp') ? opts.sp : { baudRate: 115200, rtscts: true };
```

Then

```bash
node cfr.js
```

You can now restart Zigbee2mqtt and attempt the pairing procedure again. Make sure the dongle is in debug mode!

## Debugging MQTT

The simplest way is to install this Chrome extension: [MQT Lens](https://chrome.google.com/webstore/detail/mqttlens/hemojaaeigabkbcookmlgmdigohjobjm?hl=en).

Configure a connection to your broker's IP address, port 1883. 

Then, subscribe to `#` 'at least once' -- you will now see all MQTT messages.

When Zigbee2mqtt comes up:

```yaml
zigbee2mqtt/bridge/state: online
```

When a device is pairing:

```yaml
homeassistant/light/0x....
homeassistant/sensor/0x....
-- etc --
```

You should now find the corresponding devices in Home Assistant's device state page.

## systemctl

So, after getting all this working, you've been following [these instructions](https://koenkk.github.io/zigbee2mqtt/getting_started/running_zigbee2mqtt.html) but it's not working.

If, like me, you are using `nodenv`, then you need to adapt the startup script a smidge. In my example:

```toml
ExecStart=/home/chris/.nodenv/versions/10.14.2/bin/node index.js
```

And, to keep debugging your server and devices' lifecycle, log output can now be found here:

```bash
journalctl -u zigbee2mqtt.service -f
```

