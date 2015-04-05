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


