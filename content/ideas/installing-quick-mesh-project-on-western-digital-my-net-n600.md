![qMp logo](/images/qmp_logo.png = 500x500 "Quick Mesh Project is a system for easily deploying Mesh/MANET networks using WiFi technology.")

* I plan to dive into [openHAB][20],
loading it on a [Raspberry Pi][21],
and create a sensor network for some home automation/monitoring devices.
* I plan to use [OpenWrt][22] and [qMp][09] as the network (I choose [mesh networking][23],
really its a [MANET][24] using a [layer 3 mesh routing protocol][36],
not because it will be easy but because it will be fun)
* Nodes in this mesh network will be managed via an inexpensive router
([Western Digital My Net N600][26]) and the nodes will be [WRTnode][25].
The nodes will then have sensors attached to them.
* The ideas I have for sensors include ultrasonic water level monitor for my sump pump,
 designed LED lighting for the deck, whole house water leak detection, etc.

An ambitious project I know, but for me, its all about the journey,
not the destination!

[Quick Mesh Project (qMp)][09]
is a system for easily deploying Mesh/MANET networks using WiFi technology.
The qMp firmware, based on OpenWrt, works on many embedded WiFi network devices. 
The [qMp website states][18] that, in general
every device supported by OpenWrt with 4 MB+ Flash and 32 MB+ RAM can work with qMp.
I have an old [Linksys WRT54G][01] V8 wireless router
and I want to use it as my main node (that is, the node I'll use to mange the network)
for a [Quick Mesh Project (qMp)][09] network.
The main node needs to be beefy enough so support a web server, network management tools, etc.
All the other node, much smaller nodes, will be using WRTnode.

Unfortunately, it is stated repeatedly on the OpenWrt blogs that
OpenWrt does **NOT** support, and will never support,
WRT54G greater than or equal to v5.
This appears to be due to the policy to not supporting only units with at least 4M of flash,
where the WRT54G >= v5 has only 2M.
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

I went with the Western Digital My Net N600.
It has at least one USB, more than enough Flash and RAM,
physically sleek in appearance,
at a reasonable price ($33),
plus a on/off switch which is good for how I plan to use it.
I suspect I got the good price, despite the better or equivalent features to the other routers,
because its an older model, isn't a Gigabit Ethernet switch, and lacks whip antennas.

# Installation
The first step for bring up qMp is to install [OpenWrt][16].
The [OpenWrt website][15] gives extensive documentation concerning its
purpose, structure, history, installation, hardware supported, etc.
Also, my posting on "Getting Started With WRTnode" provides additional insight.

The [installation procedure outline at the OpenWrt website][11]
requires the configure of your computers IP address to `192.168.1.10`
and connecting to a LAN port on the router.
That is, provide a static IP address and no longer use [DHCP][10] to acquire the IP address.
I found a post concerning [installing OpenWrt install via LAN connection][08]
which provided some guidance.

# Installing OpenWRT
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
(which manages networking in mysterious, dynamic ways).
I just plugged my Linux box into the router.
Also, I didn't need to reset the router, as instructed in the OpenWrt instructions
(in fact it didn't work following the instructions).
I simply sent my browser to `http://192.168.1.1`,
which brought me to [LuCI][39] (OpenWrt's web user interface),
and I navigated to the screens for uploading firmware.

## Connect Router to Router
For my qMp network, it is my plan to use my Home Router as its path to the Internet,
therefore, I need to connect my two routers together.
In this LAN-to-LAN router bridge scenario ([see this site][28]),
the Home Router is my my Internet provider's router (aka my home router),
which is connected to the service directly (cable in my case).
The qMp Router is the WD My Net N600.

My Home Router, like almost all routers service the home comsumer,
is configured as a [class C subnet][43], with a 192.168.1.X IP block
(this has a subnet mask = 255.255.255.0,
broadcast address = 192.168.1.255,
usable IPs = 192.168.1.1 to 192.168.1.254,
default gateway = 192.168.1.1,
and DHCP allocated IPs = 1 to 100)
On the other hand,
**the qMp network will be configured with a 172.30.22.X IP block**
the qMp network will be configured with a 192.168.2.X IP block
(this has XXX).

Login to a router using ssh or console.

[Add a second Router to your LAN](http://www.computing.net/howtos/show/add-a-second-router-to-your-lan/243.html)

On my Home Router, the static routes are:
Destination     Gateway         Netmask         Metric
192.168.2.0     192.168.1.200   255.255.255.0   1

On the qMp Router, the static routes are:
Destination     Gateway         Netmask         Metric
192.168.1.0     192.168.2.1     255.255.255.0   1

###########################
I'm connecting one of the Ethernet ports Home Router
to one of the Ethernet ports the qMp Router.
This type of cascading requires the Home Router and the qMp Router
to be on the same [network segment][XXX] to allow the computers
and other devices to connect to both routers.
To do this, you need to statically define the qMp Router IP address,
and disable the qMp Router's DHCP server.
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
Once completed, plug a computer into the qMp Router
and see if you can reach the Internet.
If so, everything is good to go.

Going forward, to access the qMp Router administrative screen,
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

Now that the root login has been set, you should be able to login via `[ssh][35]`.
Test it out with `ssh root@192.168.1.200`.
This is important, because later on in the qMp install,
you may xxxxxxxxxxxxxxxxxxxxxxxx

With this all done, save the OpenWrt configuration via 
`Systems > Backup / Flash Firmware > Actions > Generate archive`.

# Installing qMp
The source for my insights on the installation of qMp are from the
[qMp homepage][09], [qMp development site][32], and the
[Quick deployment network using MANET][38] document. 

I also discovered that some of the configurations above
for OpenWrt will be undone by the qMp install.

The [qMp software repository][34] list multiple methods for the installation of the qMp binary.
I choose to use the OpenWrt package repository methodology.
The specific binary to be loaded, is CPU architecture dependent.
The WD My Net N600 has the Qualcomm [Atheros architecture][11].
(Specifically, its the Atheros AR71xx, as you can tell from `cat /etc/opkg.conf`)

## qMp Feed
To integrate qMp with OpenWRT we could use [OpenWrt's feeds system][37].
In OpenWrt, a "feed" is a collection of packages which share a common location.
Feeds typically reside on a remote server
or in any other location addressable by a single name (path/URL)
over a protocol with a supported feed method.

OpenWrt can load binary from the feeds via the [opkg package manager][40].
The feeds that will be used by `opkg` is in the `/etc/opkg.conf` file.
This file contains a list of feeds.
Each feed line consists of 3 whitespace-separated components:
_feed-method feed-name feed-source_.
You must put the qMp feed in this file and this could be done via the editor `vim`,
or via LuCI, use the path `System > Software > Configuration`.

The [quick mesh project][42] website and its [development site][41] instructs you
to place the following line in `/etc/opkg.conf`:

```
src/gz qmp http://repo.qmp.cat/ar71xx/packages/
```

## Loading qMp Firmware
Judging from the qMp feed site `http://repo.qmp.cat/ar71xx/packages/`
and the [Quick deployment network using MANET][38] document, 
there are three types of qMp binaries:

* `qmp-tiny-node` - _can't find any documentation_
* `qmp-small-node` - designed to be used in low performance devices with at least 4MB of internal memory
* `qmp-big-node` - designed for high performance devices with at least 8MB of internal memory.
It includes qmp-small-node and a set of packages not mandatory for qMp but useful (e.g. tcpdump, openvpn, nmap).

I choose to install `qmp-big-node` on the WD My Net N600.

Now you want to update list of available packages
and install your tagget qMp file.
This can get done the following on the OpenWrt commandline:

```bash
# update list of available packages
opkg update

# install qMp package
opkg nstall qmp-big-node
```

Check ouit the document /home/jeff/Dropbox/Quick Mesh Project (qMp)/qmp-workshop-manual.pdf
Better yet: quick Mesh project (qMp.cat) workshop - https://github.com/pedro-nonfree/qmp-workshop-manual/blob/master/qmp-workshop-manual.org

By default,
network interface for the WD My Net N600 router will be in the following modes:

* **eth0** - LAN, IP address 172.30.22.1, DHCP server enabled
* **eth1** - WAN, IP address obtained via DHCP client (to connect it to an Internet uplink)
* **wlan0** - MESH (Ad-Hoc) in 5 GHz // MESH (Ad-Hoc) + LAN (AP) in 2.4 GHz. Routing daemons using IPv6
* **wlan1** - LAN (AP), IP address 172.30.22.1, DHCP server enabled

If any of the interfaces do not exist, it is simply ignored.

You qMp admin portal via eth0 or wlan1 and using a web browser
enter the the URL `http://172.30.22.1` or `http://admin.qmp` using
user login `root` and password `13f`.

## qMp Upgrade System
http://dev.qmp.cat/projects/qmp/wiki/Upgrade_system

## Wireless autoconf
http://dev.qmp.cat/projects/qmp/wiki/Wireless_autoconf

## Guifi Oneclick Configuration System
http://dev.qmp.cat/projects/qmp/wiki/Guifi_oneclick

# OpenWrt Console Access
For the WD My Net N600,
the OpenWrt Wiki also provides [guidance and pictures][11] for gaining physical access
to the consoles UART via a [TTL to USB][19] or other such serial converter.
I choose not to do this right now,
but could be useful if you don't have WiFi or Ethernet connectivity.

* [Mesh Networking With OLSR](http://www.dd-wrt.com/wiki/index.php/Mesh_Networking_with_OLSR)


[01]:http://support.linksys.com/en-us/support/routers/WRT54G
[02]:http://wiki.openwrt.org/toh/buyerguide
[03]:http://rooftopbazaar.com/routerfirmware/
[04]:http://blog.vx.sk/archives/43-Choosing-a-router-for-OpenWRT-1407-Barrier-Breaker.html
[05]:http://zo0ok.com/techfindings/archives/1663
[06]:http://blog.michael.kuron-germany.de/2013/04/tp-link-tl-wdr3600/comment-page-1/
[07]:http://goughlui.com/2013/09/20/tp-link-tl-wr740n-cheapest-dd-wrtopenwrt-router-ever/
[08]:http://www.pebra.net/blog/2014/02/07/installing-openwrt-on-wd-mynet-n600/
[09]:http://qmp.cat/Home
[10]:http://whatismyipaddress.com/dhcp
[11]:http://wiki.openwrt.org/toh/wd/n600
[12]:http://wiki.openwrt.org/toh/tp-link/tl-wdr3500
[13]:http://wiki.openwrt.org/toh/tp-link/tl-wdr3600
[14]:http://wiki.openwrt.org/toh/tp-link/tl-wdr4900
[15]:http://wiki.openwrt.org/
[16]:http://en.wikipedia.org/wiki/OpenWrt
[17]:http://www.smallnetbuilder.com/wireless/wireless-features/31794-inside-story-apple-airport-express-2012-and-wd-my-net-n900?start=1
[18]:http://qmp.cat/Supported_devices
[19]:http://www.adafruit.com/product/954
[20]:http://www.openhab.org/
[21]:http://www.raspberrypi.org/
[22]:https://openwrt.org/
[23]:http://en.wikipedia.org/wiki/Mesh_networking
[24]:http://en.wikipedia.org/wiki/Mobile_ad_hoc_network
[25]:http://wrtnode.com/
[26]:http://www.wdc.com/wdproducts/library/UM/ENG/4779-705072.pdf
[27]:http://downloads.openwrt.org/barrier_breaker/14.07/ar71xx/generic/openwrt-ar71xx-generic-mynet-n600-squashfs-factory.bin
[28]:http://kb.linksys.com/Linksys/ukp.aspx?pid=80&vw=1&articleid=3733
[29]:http://wiki.openwrt.org/doc/howto/secure.access
[30]:http://wiki.openwrt.org/doc/howto/basic.config
[31]:http://wiki.openwrt.org/doc/howto/wireless.overview
[32]:http://dev.qmp.cat/projects/qmp
[33]:http://wiki.openwrt.org/doc/howto/firstlogin
[34]:http://qmp.cat/Get_the_software#Repository
[35]:http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man1/slogin.1?query=ssh&sec=1
[36]:http://bmx6.net/projects/bmx6
[37]:http://wiki.openwrt.org/doc/devel/feeds
[38]:http://dev.qmp.cat/attachments/download/77/ProjectQMP.pdf
[39]:http://wiki.openwrt.org/doc/techref/luci
[40]:http://wiki.openwrt.org/doc/techref/opkg
[41]:http://dev.qmp.cat/projects/qmp/wiki/Packages
[42]:http://qmp.cat/Get_the_software
[43]:http://en.wikipedia.org/wiki/IPv4_subnetting_reference
[44]:
[45]:
[46]:
[47]:
[48]:
[49]:
[50]:
