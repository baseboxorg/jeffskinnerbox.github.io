[My complete OpenWrt Setup Guide](http://www.jauu.net/2015/03/03/complete-openwrt-guide/)

![Mesh Network](https://wellness.wikispaces.com/file/view/nwarch02.jpg/30138489/nwarch02.jpg =376x205 "MESH is a federated/distributed node structure in which any nodes can communicate with any other nodes.")(https://wellness.wikispaces.com/Network+Architectures)

![CJDNS](https://upload.wikimedia.org/wikipedia/commons/f/f8/Cjdns_logo.png =668x257 "CJDNS is a networking protocol, a system of digital rules for message exchange between computers. The philosophy behind cjdns is that networks should be easy to set up, protocols should scale up smoothly and security should be ubiquitous.")
In my exploration of my mesh networking options,
I found [CJDNS][47].
The CJDNS protocol operates at layer 3 locally,
and it can [peer][53] with other distant CJDNS networks via a UDP interface on layer 3.
CJDNS implements an encrypted IPv6 network using public-key cryptography for address allocation
and a distributed hash table for routing.
It also claims to provide near-zero-configuration networking,
and prevents many of the security and scalability issues that plague existing mesh networks.
CJDNS is the protocol behind the global mesh network [Hyperboria][48]
(formerly known as [Project Meshnet][49]).
You'll find additional documentation concerning CJDNS and Hyperboria [here][50].
CJDNS has been built to run on multiple Linux platforms and OpenWrt.
You'll also find a collection of scripts, called [Meshbox][50],
used to build and test the CJDNS routing protocol with OpenWrt.

# What is OpenWrt
OpenWrt is a desendent of the firmware used for the classic [Linksys WRT54G][71] router.
In fact, this classic Linksys series of routers lead to [DD-WRT][73], [OpenWrt][72], [Tomato][74],
and countless other open-source firmwares.
Read "[The Open Source WRT54G Story][58]" if you want more of a history lesson.

OpenWrt is described as a Linux distribution for embedded devices,
and primarily used on embedded devices to route network traffic.
Like other Linux distributions,
it offers a built-in package manager that allows you to install packages from a software repository.
It can be used for anything that an embedded Linux system can be used for,
including functioning as an SSH server, VPN, or [traffic-shaping][68] router.

Most people will be happy with their router’s default firmware,
while many power users will want a drop-in replacement firmware like [DD-WRT][69].
OpenWrt is more flexible – it’s basically an embedded Linux distribution that
can be installed on various routers.

The main components are:

* [Linux kernel][65] - manages input/output requests from software,
and translates them into data processing instructions the CPU
* [util-linux][63] - standard package of the Linux operating system
* [uClibc][64] - small C standard library intended for Linux kernel-based operating systems
* [BusyBox][66] - software that provides several stripped-down Unix tools in a single executable file

OpenWrt provides a fully writable filesystem with package management,
allowing you to [customize the device][67] through the use of packages to suit any application.
Also OpenWrt supports a framework to build an application without having to
build a complete firmware around it and is fully customizable.

## Linux Kernel
The [Linux Kernel][34], or just kernel, is the lowest level of easily replaceable software
that interfaces with the hardware in your computer.
It is responsible for interfacing all of your applications that are running in
“user mode” down to the physical hardware, and allowing processes, known as servers,
to get information from each other using inter-process communication (IPC).

## Util-Linux
The [`util-linux`][38] package contains a large variety of essential,
low-level system utilities that are necessary for a Linux system to function.
Most of the utilities are oriented towards maintenance of your system.
Some of the more important utilities included in this package allow you to partition your hard disk,
view kernel messages, and create new filesystems.

## uClibc
[`uClibc`][32] (aka µClibc/pronounced yew-see-lib-see) is a C library for developing embedded Linux systems.
It is much smaller than the GNU C Library, `glibc`,
but nearly all applications supported by `glibc` also work perfectly with `uClibc`.
Porting applications from glibc to `uClibc` typically involves just recompiling the source code.

## BusyBox
[BusyBox][61] is a tool loaded into the OpenWrt envirnment.
BusyBox combines tiny versions of many common UNIX utilities into a single small executable.
It provides minimalist replacements for most of the utilities you usually find
in GNU fileutils, shellutils, includes [`vi`][62], etc.
BusyBox is extremely configurable, allowing you to include only the components you need.
The utilities in BusyBox generally have fewer options than their full-featured GNU cousins;
however, the options that are included provide the expected functionality
and behave very much like their GNU counterparts.

BusyBox is extremely modular so you can easily include or exclude commands
(or features) at compile time.
This makes it easy to customize your embedded systems.
To create a working system, just add some device nodes in `/dev`,
a few configuration files in `/etc`, and a Linux kernel.

For a listing of Busybox's utilities, check out the [Busybox Manual Page][70].
[BusyBox is a multi-call binary][62]
(i.e. a single binary acts like a large number of utilities).
BusyBox has built-in utility programs (called applets)
can share code for many common operations.

```bush
busybox <applet> [arguments...]  # or

<applet> [arguments...]          # if symlinked
```

## OpenWrt Feeds - modify for CJDNS
To integrate CJDNS with OpenWRT we could use [OpenWrt's feeds system][37].
In OpenWrt, a "feed" is a collection of packages which share a common location.
Feeds typically reside on a remote server
or in any other location addressable by a single name (path/URL)
over a protocol with a supported feed method.

OpenWrt can load binary from the feeds via the [opkg package manager][40].
The feeds that will be used by `opkg` is in the `/etc/opkg.conf` file.
This file contains a list of feeds.
Each feed line consists of 3 whitespace-separated components:
_feed-method feed-name feed-source_.
You must put the CJDNS feed in this file and this could be done via the editor `vim`,
or via LuCI, use the path `System > Software > Configuration`.

The [quick mesh project][42] website and its [development site][41] instructs you
to place the following line in `/etc/opkg.conf`:

```
src/gz qmp http://repo.qmp.cat/ar71xx/packages/
```

##########################
# LininoIO
Linino is a Linux distribution, based on OpenWrt.
The boards supported by Linino distribution are available on the webside http://www.linino.org.
The binary of Linino distribution are available on http://download.linino.org

LininoIO is a software framework able to integrate microcontroller
features inside the microprocessor environment.
You can simply write your application using Node.js, Python, Bash, etc., on linux side using LininoOS to control completely the board and all the devices attacched.

http://www.linino.org/
https://linino2013.wordpress.com/about/
##########################


# Selecting a Gateway Router
I plan to have one of my mesh network routers act as my [gateway router][56]
and be the router from which a provide some monitoring and management of the other routers.
Therefore, this router may need more memory and CPU horsepower than the other smaller routers.
I happened to have several late versions of [Linksys WRT54G Wireless-G Routers][55]
and [Cisco-Linksys WRT54G2 Wireless Routers][54] that may do the trick.
Unfortunately, it is stated repeatedly on the OpenWrt blogs that
OpenWrt does **NOT** support, and will never support,
WRT54G greater than or equal to version 5.
This appears to be due to the policy to not supporting only units with at least 4M of flash,
where the WRT54G version 5 and greater has only 2M flash memory and 8M of RAM.
OpenWrt also doesn't support my Linksys WRT54G2 router.
To top it off,
OpenWrt [flatly refuses][02] to recommend any hardware or manufacturer!

So I searched the Internet for some advice on
[what to buy for an OpenWrt router][05],
and little more searching popped up specific recommendations:

* [WD My Net N600][03] with [16MB Flash ROM and 256MB RAM][17] ([OpenWrt says][11])
* [TP-Link TL-WDR3500][04] with 8MB Flash ROM and 128MB RAM ([OpenWrt says][12])
* [TP-Link TL-WDR3600][06] with 8MB Flash ROM and 128MB RAM ([OpenWrt says][13])
* [TP-Link TL-WDR4900][05] with 16MB Flash ROM and 128MB RAM ([OpenWrt says][14])

I went with the [Western Digital My Net N600][26].
The WD My Net N600 has the Qualcomm [Atheros architecture][11].
(Specifically, its the Atheros AR71xx, as you can tell from `cat /etc/opkg.conf`)
It has at least one USB, more than enough Flash and RAM,
physically sleek in appearance,
at a reasonable price ($33),
plus a on/off switch which is good for how I plan to use it.
I suspect I got the good price, despite the better or equivalent features to the other routers,
because its an older model, isn't a Gigabit Ethernet switch, and lacks whip antennas.

# Installing OpenWrt

# Flashing the Router
The first step for bring up the mesh network is to install [OpenWrt][16].
The [OpenWrt website][15] gives extensive documentation concerning its
purpose, structure, history, installation, hardware supported, etc.
Also, my posting on "Getting Started With WRTnode" provides additional insight.

The [installation procedure outline at the OpenWrt website][11]
requires the configure of your computers IP address to `192.168.1.10`
and connecting to a LAN port on the router.
That is, provide a static IP address and no longer use [DHCP][10] to acquire the IP address.
I found a post concerning [installing OpenWrt install via LAN connection][08]
which provided some guidance.

## OpenWrt Console Access
The steps below assume you have WiFi or Ethernet connectivity to the router
so you can flash it's memory.
An alternative is [console access][57].
For the WD My Net N600,
the OpenWrt Wiki also provides [guidance and pictures][11] for gaining physical access
to the consoles UART via a [TTL to USB][19] or other such serial converter.
I choose not to do this right now,
but could be useful if you don't have WiFi or Ethernet connectivity.

* [RS-232 vs. TTL Serial Communication](https://www.sparkfun.com/tutorials/215?_ga=1.132009867.562203984.1457131060)

## Step 1: Installing OpenWRT
I first attempted to followed the [procedures outlined by the OpenWrt Wiki][11].
I downloaded [`openwrt-ar71xx-generic-mynet-n600-squashfs-factory.bin`][27] firmware.
On some Linux boxes, you need to edit the `/etc/network/interfaces` file
so you can be part of the routers network at IP address `192.168.1.10`.
The original file looks like:

```bash
# The primary (ethernet) network interface
auto etho
iface eth0 inet dhcp
```

and you temporarily converted it to:

```bash
# static IP address
iface eth0 inet static
    address 192.168.1.10
    netmask 255.255.255.0
    gateway 192.168.1.1
```

Then restart your network interface with `sudo /etc/init.d/networking restart`.

I didn't need to do all this, since my Linux box is running Ubuntu
(which manages networking in mysterious, dynamic ways via the [NetworkManager][51] daemon).
I just plugged my Linux box into the router.
Also, I didn't need to reset the router, as instructed in the OpenWrt instructions
(in fact it didn't work following the instructions).
I simply sent my browser to `http://192.168.1.1`,
which brought me to [LuCI][39] (OpenWrt's web user interface),
and I navigated to the screens for uploading firmware.

## Connect Router to Router
For my mesh network, it is my plan to use my Home Router as its path to the Internet,
therefore, I need to connect my two routers together.
In this LAN-to-LAN router bridge scenario ([see this site][28]),
the Home Router is my my Internet provider's router (aka my home router),
which is connected to the service directly (cable in my case).
The Router is the WD My Net N600.

My Home Router, like almost all routers service the home comsumer,
is configured as a [class C subnet][43], with a 192.168.1.X IP block
(this has a subnet mask = 255.255.255.0,
broadcast address = 192.168.1.255,
usable IPs = 192.168.1.1 to 192.168.1.254,
default gateway = 192.168.1.1,
and DHCP allocated IPs = 1 to 100)
On the other hand,
**the mesh network will be configured with a 172.30.22.X IP block**
the mesh network will be configured with a 192.168.2.X IP block
(this has XXX).

Login to a router using ssh or console.

[Add a second Router to your LAN](http://www.computing.net/howtos/show/add-a-second-router-to-your-lan/243.html)

On my Home Router, the static routes are:
Destination     Gateway         Netmask         Metric
192.168.2.0     192.168.1.200   255.255.255.0   1

On the mesh Router, the static routes are:
Destination     Gateway         Netmask         Metric
192.168.1.0     192.168.2.1     255.255.255.0   1

###########################
I'm connecting one of the Ethernet ports Home Router
to one of the Ethernet ports the Mesh Router.
This type of cascading requires the Home Router and the Mesh Router
to be on the same [network segment][XXX] to allow the computers
and other devices to connect to both routers.
To do this, you need to statically define the Mesh Router IP address,
and disable the Mesh Router's DHCP server.
In OpenWrt, you do this via the menu / tabs / button sequence
`Network > Interfaces > LAN > Edit`
(The [OpenWrt documentation states][33] that the
Eathernet `lan` and the wireless interface/interfaces `wlan0` / `wlan1`
are bridged together to make `br-lan`)
On this screen, change the IPV4 address to `192.168.1.200`
and disable the DHCP.
(**NOTE:** Prior to the update, do a `sudo nmap -sP 192.168.1.0/24`
to make sure the address isn't already assigned.
It is unlikely, since `200` fails outside of the DHCP allocation range.)
Once completed, plug a computer into the Mesh Router
and see if you can reach the Internet.
If so, everything is good to go.

Going forward, to access the Mesh Router administrative screen,
you need to sent your browser to `http://192.168.1.200`.
Your Home Router's administrative screen is still at `http://192.168.1.1`.
###########################

###########################
* Linksys
    * [Cascading or Connecting a Linksys router to another router](http://kb.linksys.com/Linksys/ukp.aspx?pid=80&vw=1&articleid=3733)
    * [Setting up static routing between a router and another network](http://kb.linksys.com/Linksys/ukp.aspx?pid=80&vw=1&articleid=17589)
* Ham Radio
    * [Integrating HSMM-MESH into an existing network](http://ohiopacket.org/index.php/Integrating_HSMM-MESH_into_an_existing_network)
* General
    * [Introduction to Linux IP Routing Fundamentals (Part 1)](http://www.thegeekstuff.com/2012/04/ip-routing-intro/)
    * [Setting up static routing between a router and another network](http://kb.linksys.com/Linksys/ukp.aspx?pid=80&vw=1&articleid=17589)
    * [When Do I Need Static Routes?](http://www.coyotepoint.com/files/downloads/StaticRoutes.pdf)
    * [Add Static Routing](http://www.cyberciti.biz/faq/centos-linux-add-route-command/)
    * [Linux route Add Command Examples](http://www.cyberciti.biz/faq/linux-route-add/)
    * [Linux Advanced Routing Mini HOWTO](http://www.linuxhorizon.ro/iproute2.html)
    * [The Routing Table](http://docstore.mik.ua/orelly/networking_2ndEd/tcp/ch02_04.htm)
###########################

## Configure OpenWrt
In OpenWrt, you should [configure several settings][30].
You do this via the menu / tabs / button sequence listed here:

* [Secure Access][29] - `System > Administration`
(**Important** since OpenWrt will [revert to default configuration settings][33] until the password is set.)
* [Enable Wireless][31] - `Network > WiFi`
* Set Hostname - `System > Administration`
* Set Time - `System > General Settings > Provide NTP server`
* Archive Configuration Settings - `Systems > Backup / Flash Firmware > Actions > Generate archive`

Now that the root login has been set, you should be able to login via [`ssh`][35].
Test it out with `ssh root@192.168.1.200`.
This is important, because later on in the Mesh Router install,
you may xxxxxxxxxxxxxxxxxxxxxxxx

With this all done, save the OpenWrt configuration via
`Systems > Backup / Flash Firmware > Actions > Generate archive`.

# Installing CJDNS
[Meshbox - cjdns on OpenWrt](https://github.com/SeattleMeshnet/meshbox)


[01]:http://support.linksys.com/en-us/support/routers/WRT54G
[02]:http://wiki.openwrt.org/toh/buyerguide
[03]:http://rooftopbazaar.com/routerfirmware/
[04]:http://blog.vx.sk/archives/43-Choosing-a-router-for-OpenWRT-1407-Barrier-Breaker.html
[05]:http://zo0ok.com/techfindings/archives/1663
[06]:http://blog.michael.kuron-germany.de/2013/04/tp-link-tl-wdr3600/comment-page-1/
[07]:http://goughlui.com/2013/09/20/tp-link-tl-wr740n-cheapest-dd-wrtopenwrt-router-ever/
[08]:http://www.pebra.net/blog/2014/02/07/installing-openwrt-on-wd-mynet-n600/
[09]:
[10]:http://whatismyipaddress.com/dhcp
[11]:http://wiki.openwrt.org/toh/wd/n600
[12]:http://wiki.openwrt.org/toh/tp-link/tl-wdr3500
[13]:http://wiki.openwrt.org/toh/tp-link/tl-wdr3600
[14]:http://wiki.openwrt.org/toh/tp-link/tl-wdr4900
[15]:http://wiki.openwrt.org/
[16]:http://en.wikipedia.org/wiki/OpenWrt
[17]:http://www.smallnetbuilder.com/wireless/wireless-features/31794-inside-story-apple-airport-express-2012-and-wd-my-net-n900?start=1
[18]:
[19]:http://www.adafruit.com/product/954
[20]:
[21]:
[22]:
[23]:
[24]:
[25]:
[26]:http://www.wdc.com/wdproducts/library/UM/ENG/4779-705072.pdf
[27]:http://downloads.openwrt.org/barrier_breaker/14.07/ar71xx/generic/openwrt-ar71xx-generic-mynet-n600-squashfs-factory.bin
[28]:http://kb.linksys.com/Linksys/ukp.aspx?pid=80&vw=1&articleid=3733
[29]:http://wiki.openwrt.org/doc/howto/secure.access
[30]:http://wiki.openwrt.org/doc/howto/basic.config
[31]:http://wiki.openwrt.org/doc/howto/wireless.overview
[32]:https://uclibc.org/about.html
[33]:http://wiki.openwrt.org/doc/howto/firstlogin
[34]:http://www.makeuseof.com/tag/linux-kernel-explanation-laymans-terms/
[35]:http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man1/slogin.1?query=ssh&sec=1
[36]:http://bmx6.net/projects/bmx6
[37]:http://wiki.openwrt.org/doc/devel/feeds
[38]:http://www.catonmat.net/blog/util-linux-cheat-sheet/
[39]:http://wiki.openwrt.org/doc/techref/luci
[40]:http://wiki.openwrt.org/doc/techref/opkg
[41]:http://dev.qmp.cat/projects/qmp/wiki/Packages
[42]:http://qmp.cat/Get_the_software
[43]:http://en.wikipedia.org/wiki/IPv4_subnetting_reference
[44]:
[45]:
[46]:
[47]:https://github.com/cjdelisle/cjdns/blob/master/doc/Whitepaper.md
[48]:http://hyperboria.net/
[49]:https://projectmeshnet.wordpress.com/
[50]:https://docs.meshwith.me/
[51]:https://wiki.gnome.org/Projects/NetworkManager
[52]:https://github.com/SeattleMeshnet/meshbox
[53]:https://en.wikipedia.org/wiki/Peering
[54]:http://downloads.linksys.com/downloads/userguide/1224642019596/WRT54G2_V15_UG_NC-WEB.pdf
[55]:http://www.netwood.net/support/manuals/Linksys_WRT54G_v8.pdf
[56]:https://en.wikipedia.org/wiki/Default_gateway
[57]:https://en.wikipedia.org/wiki/Linux_console
[58]:http://www.wi-fiplanet.com/tutorials/article.php/3562391
[59]:
[60]:
[61]:http://www.busybox.net/
[62]:http://en.wikibooks.org/wiki/Learning_the_vi_Editor/BusyBox_vi
[63]:http://en.wikipedia.org/wiki/Util-linux
[64]:http://en.wikipedia.org/wiki/UClibc
[65]:http://en.wikipedia.org/wiki/Linux_kernel
[66]:http://en.wikipedia.org/wiki/BusyBox
[67]:http://www.makeuseof.com/tag/what-is-openwrt-and-why-should-i-use-it-for-my-router/
[68]:http://en.wikipedia.org/wiki/Traffic_shaping
[69]:http://en.wikipedia.org/wiki/DD-WRT
[70]:http://linux.die.net/man/1/busybox
[71]:http://en.wikipedia.org/wiki/Linksys_WRT54G_series
[72]:https://openwrt.org/
[73]:http://www.dd-wrt.com/site/index
[74]:http://www.polarcloud.com/tomato
[75]:

