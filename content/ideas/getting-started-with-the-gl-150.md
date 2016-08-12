[!AR150](http://www.gl-inet.com/wordpress/wp-content/uploads/2015/09/ar150_marks_800.jpg)
[!AR150](http://www.gl-inet.com/wordpress/wp-content/uploads/2015/08/700x500_p1.jpg)
* My favorate is a hackable product, the [GL-AR150-ext smart router][11].
*  it come with 16MByte Flash and 64MByte RAM, WiFi 802.11b/g/n 150Mbps, models supporting intrnal or external antenna,
powered vi MicroUSB  port, Ethernet ports for WAN and LAN connections, USB 2.0 type A port,
hardware toggle button for reset and On/Off switch, USB Power control via GPIO 6
It has good [documentation][12] and even a [blog][13] for the hacker community.
* [OpenWrt page for GL-AR150](https://wiki.openwrt.org/toh/gl-inet/gl-ar150)

For a "getting started" discription of OpenWrt,
check out "Getting Started with the OpenWRT".

[short video telling you how to open the case ][01]
[GL.iNet AR150 Website][02]


# Step 0: XXX
For the GL-AR150, you'll find details on how to use and configure the router
on the [GL.iNet GL-AR150 Wiki][12].
Within this Wiki, there are articles [firmware upgrading][08], [adding a real-time clock][09],
working with [UART & serial][07], [using uboot][06], etc.
Additional information can be found within the [GL.iNet Blog][13],
which covers topics like [building OpenWRT firmware][03],
[Uboot Web UI][04], [flashing firmware to the GL-AR150][05].

# Step X: Flashing Firmware
https://wiki.openwrt.org/doc/howto/generic.flashing
https://wiki.openwrt.org/toh/gl-inet/gl-ar150
http://www.gl-inet.com/flash-your-own-firmware-to-the-router/

The GL-AR150 already runs on OpenWRT, but this is a customised version by GLiNet.
The objectie here is to replace it with the offical OpenWRT software.
You have two paths to do this: using the devices UI to do the upgrade
or flash the device via a USB stick.
The late approach requires openning the device and placing jumpers on the GPIO pins.

# Step X: OpenWrt as a WiFi Client
* [OpenWrt as a wifi client](http://www.rooot.net/en/geek-stuff/openwrt/8-openwrt-wifi-client.html)

# Step X: Mount an External USB Media as Root Filesystem
* [Mount an external USB media as root fs on OpenWRT](http://www.rooot.net/en/geek-stuff/openwrt/36-mount-external-usb-root-partition-openwrt.html)
* [The OpenWrt Flash Layout](https://wiki.openwrt.org/doc/techref/flash.layout)

# Step X: QoS for OpenWrt
* [QoS for OpenWrt](http://www.rooot.net/en/geek-stuff/openwrt/1-qos-openwrt.html)



[01]:http://www.gl-inet.com/how-to-open-the-case-of-gl-mini-routers/
[02]:http://www.gl-inet.com/ar150
[03]:http://www.gl-inet.com/build-your-openwrt-firmware-in-30-minutes/
[04]:http://www.gl-inet.com/how-to-enter-the-uboot-web-ui/
[05]:http://www.gl-inet.com/flash-your-own-firmware-to-the-router/
[06]:http://www.gl-inet.com/docs/wiki/#!diy/uboot.md
[07]:http://www.gl-inet.com/docs/wiki/#!diy/serial.md
[08]:http://www.gl-inet.com/docs/wiki/#!mini/firmware.md
[09]:http://www.gl-inet.com/docs/wiki/#!mini/ar150rtc.md
[10]:
[11]:http://www.amazon.com/GL-AR150-ext-External-Antenna-150Mbps-Pre-installed/dp/B015CYI8DY/ref=sr_1_2?ie=UTF8&qid=1454383159&sr=8-2&keywords=GL-AR150
[12]:http://www.gl-inet.com/docs/wiki/#!index.md
[13]:http://www.gl-inet.com/blog/
[14]:
[15]:
[16]:
[17]:
[18]:
[19]:
[20]:
