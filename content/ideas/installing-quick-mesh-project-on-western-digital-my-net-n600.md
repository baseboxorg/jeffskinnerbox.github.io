![qMp logo](/images/qmp_logo.png = 500x500 "Quick Mesh Project is a system for easily deploying Mesh/MANET networks using WiFi technology.")

* I plan to dive into [openHAB][20],
loading it on a [Raspberry Pi][21],
and create a sensor network for some home automation/monitoring devices.
* I plan to use [OpenWrt][22] and [qMp][09] as the network (I choose [mesh networking][23],
really its a [MANET][24], not because it will be easy but because it will be fun)
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

## Installing OpenWRT
I first attempted to followed the [procedures outlined by the OpenWrt Wiki][11].
I downloaded `[openwrt-ar71xx-generic-mynet-n600-squashfs-factory.bin][27]` firmware.
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
I simply sent my browser to `http://192.168.1.1`
and navigated to the screens for uploading firmware.

## Connect Router to Router
I my qMp network to use my home router as its path to the Internet,
therefore, I need to connect my two routers together.
In this LAN-to-LAN router bridge scenario ([see this site][28]),
the main router is my my Internet provider's router,
which is connected to the service directly (cable in my case).
The secondary router is the WD My Net N600.
I'm connecting one of the Ethernet ports main router
to one of the Ethernet ports the secondary router.
This type of cascading requires the main and the secondary routers
to be on the same LAN IP segment to allow the computers
and other devices to connect to both routers.
To do this, you need to statically define the secondary routers IP address,
and disable the secondary router's DHCP server.

In OpenWrt, you do this via the menu / tabs / button sequence
`Network > Interfaces > LAN > Edit` 
(The [OpenWrt documentation states][33] that the
Eathernet `lan` and the wireless interface/interfaces `wlan0` / `wlan1`
are bridged together to make `br-lan`)
On this screen, change the IPV4 address to `192.168.1.200`
and disable the DHCP.
(**NOTE:** Prior to the update, do a `sudo nmap -sP 192.168.1.0/24`
to make sure the address isn't already assigned.)
Once completed, plug a computer into the secondary router
and see if you can reach the Internet.
If so, everything is good to go.

Going forward, to access the secondary routers administrative screen,
you need to sent your browser to `http://192.168.1.200`.
Your main router's administrative screen is still at `http://192.168.1.1`.

## Configure OpenWrt
In OpenWrt, you should [configure several settings][30].
You do this via the menu / tabs / button sequence listed here:

* [Secure Access][29] - `System > Administration`
(**Important** since OpenWrt will [revert to default configuration settings][33] until the password is set.) 
* [Enable Wireless][31] - `Network > WiFi`
* Set Hostname - `System > Administration` 
* Set Time - `System > General Settings > Provide NTP server`
* Archive Configuration Settings - `Systems > Backup / Flash Firmware > Actions`

## OpenWrt Console and Telnet Access
For the WD My Net N600,
the OpenWrt Wiki also provides [guidance and pictures][11] for gaining physical access
to the consoles UART via a [TTL to USB][19] or other such serial converter.
I choose not to do this right now,
but could be useful if you don't have WiFi or Ethernet connectivity.
The same Wiki page also shows you how to gain Telnet access to OpenWrt.

## qMp Installation
The source for my insights on the installation of qMp are its
[homepage][09] and [development site][32]. 
I also discovered that some of the configurations above
for OpenWrt will be undone by the qMp install.

The [qMp software repository][34] list multiple methods for the installation of the qMp binary.
I choose to use the OpenWrt package repository methodology.
The specific binary to be loaded, is CPU architecture dependent.
The WD My Net N600 has the [Atheros architecture][11].



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
[35]:
[36]:
[37]:
[38]:
[39]:
[40]:
