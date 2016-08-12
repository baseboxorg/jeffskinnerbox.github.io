
* [Mount an external USB media as root fs on OpenWRT](http://www.rooot.net/en/geek-stuff/openwrt/36-mount-external-usb-root-partition-openwrt.html)
* [OpenWrt as a wifi client](http://www.rooot.net/en/geek-stuff/openwrt/8-openwrt-wifi-client.html)
* [My complete OpenWrt Setup Guide](http://www.jauu.net/2015/03/03/complete-openwrt-guide/)
* [Node-RED on WRTnode](http://blog.thestateofme.com/2014/12/03/node-red-on-wrtnode/)

## OpenWrt
[OpenWrt][40] is a descendant of the firmware used for the classic [Linksys WRT54G][39] router.
In fact, this classic Linksys series of routers lead to [DD-WRT][41], [OpenWrt][40], [Tomato][42],
and countless other open-source firmwares.
Read "[The Open Source WRT54G Story][43]" if you want more of a history lesson.

OpenWrt is described as a Linux distribution for embedded devices,
and primarily used on embedded devices to route network traffic.
Like other Linux distributions,
it offers a built-in package manager that allows you to install packages from a software repository.
It can be used for anything that an embedded Linux system can be used for,
including functioning as an SSH server, VPN, or [traffic-shaping][26] router.

Most people will be happy with their router’s default firmware,
while many power users will want a drop-in replacement firmware like [DD-WRT][27].
OpenWrt is more flexible – it’s basically an embedded Linux distribution that
can be installed on various routers.

The main components are:

* [Linux kernel][15] - manages input/output requests from software,
and translates them into data processing instructions the CPU
* [util-linux][13] - standard package of the Linux operating system
* [uClibc][14] - small C standard library intended for Linux kernel-based operating systems
* [BusyBox][16] - software that provides several stripped-down Unix tools in a single executable file
* [Wireless Utilities][68] - utilities for WiFi spcific to the WRTnode implementation of OpenWrt

OpenWrt provides a fully writable filesystem with package management,
allowing you to [customize the device][17] through the use of packages to suit any application.
Also OpenWrt supports a framework to build an application without having to
build a complete firmware around it and is fully customizable.

Another component, but not considered part of OpenWrt, is the [bootloader][48].
The Bootloader is a piece of software that is executed every time the hardware device is powered up.
It is executable machine code, and quite heavily device-specific.
Its main task is to initialize all the low-level hardware details.
The bootloader is commonly on flash storage.

Unlike other router softwatre like DD-WRT,
OpenWrt is completely command line based.
The standard OpenWrt distribution package doesn't include a GUI,
but you can install one called the OpenWrt Configuration Interface, [LuCI][65].

OpenWRT also supports quite a number of hardware platfroms for routers.
You can check whether your particular model is supported
by reviewing the [OpenWrt's hardware table][66].
OpenWRT also supports many security features that you might find useful,
including a firewall based on ipchains, WiFi Protected Access (WPA) encryption,
Remote Authentication Dial-In User Service (RADIUS) authentication,
Dropbear Secure Shell (SSH) server, OpenVPN, amonug others.

### Linux Kernel
There are so many Linux distributions out in the wild,
but there is only one de facto thing that they have in common:
the [Linux kernel][57].
[So what is a kernel][59]?
It’s the kernel that does the grunt work of the operating system.
The kernel’s job is to talk to the hardware and software,
and to manage the system’s resources as best as possible.
It talks to the hardware, via the drivers,
when applications submit there request to the kernel.
The kernel make sure that there is enough memory available for an application to run,
as well as to place an application in the right location in memory
The kernel coordinate these and many other things.
This kernel circus act is [illustrated here][58]
and the Linux kernel [anatomy here][60].

With just a kernel, it’s nearly impossible to do anything with the operating system.
You also need some additional applications/utilities to be bundled with it.
These utilities use the kernel's [system calls][62] to perform useful task,
and a [shell][63] for user interaction.
These additional application  include util-linux, uClibc, and BusyBox discussed below.

### util-linux
util-linux is a standard package of the Linux operating system.
The [util-linux code repository][55] is used by all variants of Linux.
This package contains a number of important utilities,
most of which are oriented towards maintenance of your Linux system.
Some of the more important utilities included in this package allow
you to partition your hard disk, view kernel messages, and create new filesystems.
These utilities are not the every day utilities like vim, grep, cat, etc.
(see Busybox for these)
but instead are operating system utilities.
See [this page][56] for a listing of the utilities within util-linux.

util-linux doesn't contain everything you need for
administering your Linux.
For example, utilities to manage the WiFi on the WRTnode will not be within util-linux.

### uClibc
[uClibc][51] is a small C standard library intended for Linux kernel-based
operating systems for embedded systems and mobile devices.
uClibc is to provide as much functionality as possible in a small amount of space.
uClibc is much smaller than [glibc (GNU C Library)][61]
which is normally used with Linux distributions.
uClibc is specifically focused on embedded Linux and
features can be enabled or disabled according to space requirements.

If you choose to compile programs with uClibc,
you'll to have your own uClibc toolchain. A toolchain consists of
[GNU binutils][52], the [gcc compiler][53], and uClibc,
all built to produce binaries for your target system linked with uClibc.
You can build your own native uClibc toolchain using the [uClibc buildroot system][54].

### BusyBox
[BusyBox][11] is a tool loaded into the OpenWrt environment.
BusyBox combines tiny versions of many common UNIX utilities into a single small executable.
It provides minimalist replacements for most of the utilities you usually find
in GNU fileutils, shellutils, includes [`vi`][12], etc.
BusyBox is extremely configurable, allowing you to include only the components you need.
The utilities in BusyBox generally have fewer options than their full-featured GNU cousins;
however, the options that are included provide the expected functionality
and behave very much like their GNU counterparts.

BusyBox is extremely modular so you can easily include or exclude commands
(or features) at compile time.
This makes it easy to customize your embedded systems.
To create a working system, just add some device nodes in `/dev`,
a few configuration files in `/etc`, and a Linux kernel.

For a listing of Busybox's utilities, check out the [Busybox Manual Page][28].
[BusyBox is a multi-call binary][12], that is,
a single binary acts like a large number of utilities.
BusyBox has built-in utility programs (called applets)
can share code for many common operations.
So it has the following syntax:

```bush
busybox <applet> [arguments...]  # or

<applet> [arguments...]          # if symlinked

Where the applets would include ls, awk, sed, wc, ....
and many other of your favorate Linux commands
```

### WiFi Utilities
Like in standard Linux, WiFi support, wireless in general,
is fragmented.
Wireless devices have an API different from that of Ethernet devices
because the specifications of IEEE 802.11 covers the whole communications process.
The available of some tools depend entirely on your drivers writen for the hardware.
[Tools available through OpenWrt][71], and therfore, support most hardware platforms,
including WRTnode, are:

* `iwconfig` - is the configuration utility for the now obsolete [Wireless-Extensions (WEXT) API][69],
which is scheduled for removal.
* `iw` - is the configuration utility replacing `iwconfig` supporting the [nl80211 API][70].
* `iwinfo` - is a frontend to the custom library, which assembles information from various places.
* `hostapd` - this package contains a full featured IEEE 802.1x/WPA/EAP/RADIUS Authenticator.
* `wpa-cli` -  this is a WPA Supplicant command line interface

Beyond what utilities OpenWrt povides for WiFi,
WRTnode comes with some [custom utilities][68] (`aps`/`setwifi`/`ia`/`vw`/`nr`/`wifi`)
for the up-link part of the router inside of WRTnode.

* `aps` - is a WRTnode customized command which scans the WiFi SSIDs available.
* `vw` - is used to make changes to `/etc/config/wireless` where WiFi configuration information is stored, using the file editor `vi`.
* `nr` - is a WRTnode customized command which will reset the network side.  After 5 seconds it is possible to connect again to WRTnode's SSID.
* `ia` - is the WRTnode equivalent to `ifconfig`, the Linux network interface configuration, control, and query tool.
* `wifi` -  is a WRTnode customized command which will reset the network side. After 10 seconds it is possible to connect again to WRTnode's SSID.
* `setwifi` - is used to connect to an access point when give its SSID and password

[OpenWrt also support many WiFi modes][72] such as AP, Monitor, Ad-Hoc, [802.11s][73], and more.

### Bootloader
The WRTnode incldues a customized [uboot][29] which is a popular [bootloader][30] that
supports multiple architectures (ARM, MIPS, AVR32, Nios, Microblaze, 68K and x86)
and filesystems (FAT32, ext2, ext3, ext4 and Cramfs).

Strictly speaking, a bootloader is not required to boot Linux.
The use of one (or several) bootloaders in a row to chainload (or [bootstrap][49])
a Kernel is not a categorical necessity,
but it is a preferred method to start an operating system.
The main advantage for OpenWrt is,
that the existence of a bootloader offers users and developers
additional possibilities to [debrick][50] a device.




[13]:http://en.wikipedia.org/wiki/Util-linux
[14]:http://en.wikipedia.org/wiki/UClibc
[15]:http://en.wikipedia.org/wiki/Linux_kernel
[16]:http://en.wikipedia.org/wiki/BusyBox
[17]:http://www.makeuseof.com/tag/what-is-openwrt-and-why-should-i-use-it-for-my-router/
[18]:
[19]:
[20]:
[21]:
[22]:
[23]:
[24]:
[25]:
[26]:http://en.wikipedia.org/wiki/Traffic_shaping
[27]:http://en.wikipedia.org/wiki/DD-WRT
[28]:http://linux.die.net/man/1/busybox
[29]:http://www.linuxjournal.com/content/handy-u-boot-trick
[30]:http://www.addictivetips.com/mobile/what-is-bootloader-and-how-to-unlock-bootloader-on-android-phones-complete-guide/
[31]:
[32]:
[33]:
[34]:
[35]:
[36]:
[37]:
[38]:
[39]:http://en.wikipedia.org/wiki/Linksys_WRT54G_series
[40]:https://openwrt.org/
[41]:http://www.dd-wrt.com/site/index
[42]:http://www.polarcloud.com/tomato
[43]:http://www.wi-fiplanet.com/tutorials/article.php/3562391
[44]:
[45]:
[46]:
[47]:
[48]:https://en.wikipedia.org/wiki/Booting#BOOT-LOADER
[49]:https://en.wikipedia.org/wiki/Bootstrapping#Computing
[50]:https://wiki.openwrt.org/doc/howto/generic.debrick
[51]:https://www.uclibc.org/
[52]:https://sourceware.org/binutils/
[53]:https://gcc.gnu.org/
[54]:https://buildroot.org/
[55]:https://git.kernel.org/cgit/utils/util-linux/util-linux.git/
[56]:http://www.linuxfromscratch.org/lfs/view/development/chapter06/util-linux.html
[57]:https://kernel.org/
[58]:http://www.makelinux.net/kernel_map/
[59]:http://www.howtogeek.com/howto/31632/what-is-the-linux-kernel-and-what-does-it-do/
[60]:http://www.ibm.com/developerworks/library/l-linux-kernel/
[61]:https://en.wikipedia.org/wiki/GNU_C_Library
[62]:https://en.wikipedia.org/wiki/System_call
[63]:https://en.wikipedia.org/wiki/Shell_(computing)
[64]:
[65]:https://wiki.openwrt.org/doc/howto/luci.essentials
[66]:https://wiki.openwrt.org/toh/views/toh_extended_all
[67]:
[68]:http://wiki.wrtnode.cc/index.php?title=%E5%A6%82%E4%BD%95%E9%80%9A%E8%BF%87%E6%97%A0%E7%BA%BF%E8%BF%9E%E4%B8%8A%E4%BA%92%E8%81%94%E7%BD%91/en
[69]:http://linuxwireless.org/en/developers/Documentation/Wireless-Extensions/
[70]:http://linuxwireless.org/en/developers/Documentation/nl80211/
[71]:https://wiki.openwrt.org/doc/howto/wireless.utilities
[72]:https://wiki.openwrt.org/doc/techref/wireless.modes
[73]:https://wiki.openwrt.org/doc/howto/mesh.80211s
[74]:
[75]:
[76]:
[77]:
[78]:
[79]:
[80]:
