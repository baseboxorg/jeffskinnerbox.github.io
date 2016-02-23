![qMp logo](/images/qmp_logo.png = 500x500 "Quick Mesh Project is a system for easily deploying Mesh/MANET networks using WiFi technology.")

For installing OpenWRT, check out
* [BATMAN on OpenWRT](https://wiki.reseaulibre.ca/guides/openwrt+batman/)
* [Mesh network with OpenWRT routers](http://internet-science.eu/sites/eins/files/uploads/MeshnetworkwithOpenWRTrouters.pdf)
* [Lab 8: Wireless Mesh Network Setup with DD‐WRT](http://vip.gatech.edu/wiki/images/5/56/WikiLab_8-_Wireless_Mesh_Network_Setup_with_DD-WRT.pdf)

* I'm thinking about diving into [openHAB][20],
loading it on a [Raspberry Pi][21],
and create a sensor network for some home automation/monitoring devices.
* I plan to use [OpenWrt][22] and [qMp][09] as the network (I choose [mesh networking][23],
really its a [MANET][24] using a [layer 3 mesh routing protocol][36],
not because it will be easy but because it will be fun)
* Nodes in this mesh network will be managed via an inexpensive router
([Western Digital My Net N600][26]) and the nodes will be the [WRTnode][25]
or the [GL-AR150][44].
The nodes will then have sensors attached to them.
* The ideas I have for sensors include ultrasonic water level monitor for my sump pump,
 designed LED lighting for the deck, whole house water leak detection, etc.

An ambitious project I know, but for me, its all about the journey,
not the destination!

I was considering using [Quick Mesh Project (qMp)][09].
qMp is a system for easily deploying Mesh/MANET networks using WiFi technology.
The qMp firmware, based on OpenWrt, works on many embedded WiFi network devices.
The [qMp website states][18] that, in general
every device supported by OpenWrt with 4 MB+ Flash and 32 MB+ RAM can work with qMp.
I have an old [Linksys WRT54G][01] V8 wireless router
and I want to use it as my main node (that is, the node I'll use to mange the network)
for a [Quick Mesh Project (qMp)][09] network.
The main node needs to be beefy enough so support a web server, network management tools, etc.
All the other node, much smaller nodes, will be using WRTnode.

I believe a better altenative to qMp is the [Open-Mesh][45]
routing protocols for ad-hoc networks [BATMAN-Adv][46].
The name stands for “Better Approach To Mobile Ad-hoc Networking“,
this is a routing protocol for multi-hop ad-hoc mesh networks.
BATMAN-Adv is better supported and documented than qMp.
BATMAN-Adv doesn't claim (and most likely doesn't) to have an easy setup like qMp,
but this a small consideration when you see the support behind BATMAN-Adv.
Also, with this project you'll find tools like
`batadv-vis` to visualize your BATMAN-Adv mesh network,
`alfred` for flooding the network with data,
`batctl` is the configuration and debugging tool

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

# High Level Architecture
[![HLA](image-URL "High Level Architecture")](link-URL)
Important Things to Notice:

* Both Home Router and the qMp Router have two IP addresses;
an Internal IP address and an External IP address.
* There are TWO LANs (Local Area Networks).

There are TWO WANs (Wide Area Networks). If there is a LAN then there is an accompanying WAN.

* Internet
* Home Network
* Sensor Network
* qMp Network
* openHAB
* Home Router
* qMp Router
* WRTnode
* Sensor

# IP Addresses
* Home Router
    * WAN (External IP Address)
    * LAN (Internal IP Address)
    * Admin Portal
* qMp Router
    * WAN (External IP Address)
    * LAN (Internal IP Address)
    * Admin Portal

# Four Setup Options for the Router
A router is a separating network element.
It separates two networks and allows certain traffic to cross.
Sometimes this is necessary in a network setup but for most home networks
it only creates a lot of obstacles.

Bridge Operating Mode - Connect the LAN port of the qMp Router to the LAN port of the Home Router
:   In this case you have to turn off the DHCP server on the qMp Router to prevent incorrect IP assignments.
    You may/should also change the LAN IP address of the qMp Router to avoid conflicts.
    Choose an IP address inside the subnet of the home Router but not conflicting with
    any static IP addresses used in your LAN nor overlapping the IP address pool
    which the DHCP server on the first router uses.
    For example, it your Home Router has an IP address 192.168.1.1 with subnet mask 255.255.255.0
    and the DHCP server uses the address pool 192.168.1.100-149,
    you can assign any address 192.168.1.2-99 and 150-254 to the second router, e.g. 192.168.1.2.
Gateway Operating Mode - Connect the WAN port of the qMp Router to the LAN port of the Home Router
:   Configure the qMp Router in gateway/NAT mode and connect its WAN port of the qMp Router
    to a LAN port of the Home Router.
    In this case it is important to use a different subnet on the qMp Router then the Home Router.
    If the Home Router uses addresses for network 192.168.1.0 with subnet mask 255.255.255.0
    the qMp Router must be outside of this subnet, e.g. it could be network 192.168.2.0
    with subnet mask 255.255.255.0.
    Make sure to enable the DHCP server on the qMp Router unless
    you only want to use static IP addresses in your LAN.
    If you need port forwarding from the Internet to the LAN of the qMp Router,
    you have to configure the same forwardings on the Home Router as well.
    You forward first from the Home Router to the qMp Router and then from the qMp Router into its LAN.
Router Operating Mode - Connect the WAN port of the qMp Router to the LAN port of the Home Router
:   Configure the qMp Router in router/non-NAT mode and assign a LAN IP address
    in a separate subnet from the Home Router (i.e. like the Gateway Operating Mode option).
    In router mode you have to configure static routes on the Home Router to make the qMp Router accessible.
    If you use NAT on the Home Router (which you will to get Internet access),
    you must also make sure that the Home Router does support NAT for addresses
    which are not in the Home Router's subnet.
    Some routers (particulalry those provided by ISPs) are limited to do NAT only
    for its own directly connected network (i.e. Home Route's network)
    but not for any subnet (i.e. qMp Router's network).
    If you have such a Home Router, this option will not work since the qMp Router will
    not be able to reach the Internet.
Router Operating in DMZ
:   * [What are the tradeoffs between the various router configurations](http://www.dslreports.com/faq/16077)
    * [3.0 Networking](http://www.dslreports.com/faq/verizonfios/3.0_Networking#12506)
    * [How to Configure Verizon FiOS Router to Give Network Control to Airport Extreme](http://www.podfeet.com/blog/tutorials-5/how-to-configure-verizon-fios-router-to-give-network-control-to-airport-extreme/)
    * [Two routers on your home network?](http://www.suggest-a-fix.com/index.php?/topic/44-two-routers-on-your-home-network/)

* [Linux Firewall Tutorial: IPTables Tables, Chains, Rules Fundamentals](http://www.thegeekstuff.com/2011/01/iptables-fundamentals/)
*
* [How to connect OpenWRT behind another router](https://forum.openwrt.org/viewtopic.php?id=44660)
* [Two router setups](http://routersetup.blogspot.com/2007/08/two-router-setups.html)
* [Connecting two routers wired to create a single LAN](http://routersetup.blogspot.com/2007/08/connecting-two-routers-wired.html)
* [Routed Client](http://wiki.openwrt.org/doc/recipes/routedclient)
* [NAT & IP Masquerade](http://bglug.ca/articles/nat_and_ip_masquerade.pdf)

* [Multiple subnets with DD-WRT](http://www.patrikdufresne.com/en/multiple-subnets-routing-with-dd-wrt/)
* [Linking Subnets With Static Routes](http://www.dd-wrt.com/wiki/index.php/Linking_Subnets_with_Static_Routes)
* [Enabling a Guest WiFi Network with OpenWRT/DD-WRT](http://thejimmahknows.com/home-projects/multiple-access-points-over-802-1q-using-openwrt/)
* [Hosting Two WiFi Networks on One OpenWrt Router](http://www.smallbusinesstech.net/more-complicated-instructions/openwrt/hosting-two-wifi-networks-on-one-openwrt-router)

* [Quick deployment network using MANET](http://upcommons.upc.edu/pfc/bitstream/2099.1/14103/1/77789.pdf)
* [Quick Mesh Project](http://qmp.cat/Experimenting_with_the_WRTnode)
* [Quick deployment network using MANET](http://upcommons.upc.edu/pfc/bitstream/2099.1/14103/1/77789.pdf)
* [quick Mesh project (qMp.cat) workshop](https://github.com/pedro-nonfree/qmp-workshop-manual/blob/master/qmp-workshop-manual.org)
* [qMp wireless mesh network monitoring](https://github.com/pedro-nonfree/qmpsantsupc)
* [Integration of MANET/Mesh networks with qMp in the Guifi·net community - Document](http://upcommons.upc.edu/pfc/bitstream/2099.1/20956/1/88861.pdf)
* [Integration of Mesh networks with qMp in the Guifi·net community - Presentation](http://dev.qmp.cat/attachments/download/144/PFC_qMp-Guifi_presentation.pdf)
* [qMp wireless mesh network monitoring](https://github.com/pedro-nonfree/qmpsantsupc)
* Community Networks
    * [Starting, Contributing and Empowering Community Networks in cities Experiences in Barcelona](http://repositori.upf.edu/bitstream/handle/10230/22884/VilchesBlanco_2014.pdf?sequence=1)
    * [Experimental research on testbeds for community networks (year 3)](https://bscw.pangea.org/pub/bscw.cgi/d332070/D4.3.pdf)


* Need More Addresses? Try Subnetting and NAT (TCP/IP): [Part 1](http://what-when-how.com/tcpip/need-more-addresses-try-subnetting-and-nat-tcpip-part-1/) and [Part 2](http://what-when-how.com/tcpip/need-more-addresses-try-subnetting-and-nat-tcpip-part-2/)

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

[Static route between OpenWRT router and TPLink Archer C9](http://superuser.com/questions/860501/static-route-between-openwrt-router-and-tplink-archer-c9)

* Home Router

    1. The first step is to identify the IP block used in your home network and the IP address of Home Router.
My IP block is `192.168.1.X` and Home Router's IP address is `192.168.1.1`

* qMp Router

    1. Connect a computer to the qMp Router at IP address `192.168.1.1`(desktop or laptop to one of the Ethernet ports of the qMp Router).
    1. Access the setup page of the qMp Router.
    1. Give the WAN IP address a static address on the Home Router network.
    (Network > Interfaces > WAN > Edit; change to "static address")
    In my case, that IP address is `192.168.1.200`.
    1. Set the LAN side IP address. Change the third octet to a different value. In my case, I changed it to `192.168.2.1` Make sure that the Subnet Mask is `255.255.255.0`.  This will set the qMp Router to a different IP segment from the Home Router.
    (Network > Interfaces > LAN > Edit; change to "static address")
    1. Make sure to enable DHCP on the qMp Router.
    DHCP start address should be 2 and the max number 150
    1. Save your settings.
    At this point, you will be kicked off the router and you will need to login via `192.168.2.1`.

    **NOTE:** At this point, computers that are connected to the Home Router
    will not be able to communicate with the qMp Router,
    and vice versa, since there are two different networks with no route defined between them

* Home Router

    1. Connect the qMp Router's WAN port to the Home Router's LAN port via an Ethernet cable.
    1. Connect a computer to the Home Router and log into the router at IP address `192.168.1.1`.
    1. Go to Advanced > IP Address Distribution
    1. Change the DHCP range in "IP Address Distribution" to 2 to 150
    1. Go to Advanced > Routing
    1. Set up a static route from the qMp Router, through the Home Router, to the Internet.
    You do this by entering the following into the Home Router
    (equivalent to
    `route -p add -net 192.168.2.0 -gateway 192.168.1.200 netmask 255.255.255.0`
    `ip route add 192.168.2.0/24 via 192.168.1.200`):

```
Destination       Gateway           NetMask      Interface   Metric
   0.0.0.0      192.168.1.1         0.0.0.0        eth1        0
192.168.2.0     192.168.1.200    255.255.255.0     eth1        1

Default Gateway: 192.168.1.1
```
Default Gateway:	173.71.205.1
DNS Server:         71.252.0.12  /  71.242.0.12
Broadband IP Address:	173.71.205.87


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

Now that the root login has been set, you should be able to login via [`ssh`][35].
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
[44]:http://www.gl-inet.com/ar150/
[45]:https://www.open-mesh.org/projects/open-mesh/wiki
[46]:https://www.open-mesh.org/projects/batman-adv/wiki/Doc-overview
[47]:
[48]:
[49]:
[50]:
[51]:https://wiki.gnome.org/Projects/NetworkManager

