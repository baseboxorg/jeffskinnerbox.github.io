In early November 2014, I got from [Seeed Studio][21] the [WRTNode][22].
WRTnode is based on WiFi WiFi Access Point System on a Chip (SoC),
is an open source development board hardware using the [Mediatek][23] [MT7620n chip][24].
The MT7620 router-on-a-chip includes an 802.11n MAC and baseband, a 2.4 GHz radio,
a 580 MHz CPU core, a 5-port 10/100 switch and two
[Reduced Gigabit Media Independent Interface (RGMII)][25].
The MT7620 includes everything needed to build an AP router from a single chip. 

OpenWrt, which is a distribution of embedded Linux, is the system of WRTnode.

busybox version - http://unix.stackexchange.com/questions/15895/how-do-i-check-busybox-version-from-busybox
WRT version -

## OpenWRT
OpenWrt is described as a Linux distribution for embedded devices,
and primarily used on embedded devices to route network traffic.
The main components are:

* [Linux kernel][15] - manages input/output requests from software,
and translates them into data processing instructions the CPU
* [util-linux][13] - standard package of the Linux operating system
* [uClibc][14] - small C standard library intended for Linux kernel-based operating systems
* [BusyBox][16] - software that provides several stripped-down Unix tools in a single executable file

OpenWrt provides a fully writable filesystem with package management,
allowing you to [customize the device][17] through the use of packages to suit any application.
Also OpenWrt supports a framework to build an application without having to
build a complete firmware around it and is fully customizable.

## BusyBox
[BusyBox][11] combines tiny versions of many common UNIX utilities into a single small executable.
It provides minimalist replacements for most of the utilities you usually find
(including [`vi`][12]).
BusyBox is extremely configurable, allowing you to include only the components you need.
Therefore, not all BusyBox installations have the same commands,
and OpeWRT's impmentation has a limited set of utilities.

[BusyBox is a multi-call binary][12]
(i.e. a single binary acts like a large number of utilities).
BusyBox has built-in utility programs (called applets)
can share code for many common operations.

```bush
busybox <applet> [arguments...]  # or

<applet> [arguments...]          # if symlinked
```

You can get a listing of OpenWRT's supported applets via the `help` command.

![alt text](downloads/openwrt-help-command.jpg "BusyBox commands support on OpenWRT")

A symbolically linked command is the `ls` command.
Using this, you can explort the file system to see some of the contents of OpenWRT.

![alt text](downloads/openwrt-file-system.jpg "Some of OpenWRT's filesystem")


## Helpful Tools
As I begain to play with the WRTNode, I ran into several problems,
most of my own making.
To monitor what is going on, I found the following tools useful

* Tools for Monitoring WiFi
    * [`wavemon`][02] is a ncurses-based monitoring application for wireless network devices.
    It displays continuously updated information about signal levels, as well as,
    wireless-specific and general network information. 
    **Example Usage:** `wavemon wlan0`
    * [`iwevent`][05] is another command line tool that displays wireless events
    received through the [RTNetlink socket][06].
    Each line displays the specific wireless event which describes
    what has happened on the specified wireless interface.
    **Example Usage:** `iwevent`
* Tools for Monitoring NIC
    * [`netstat`][10] (network statistics) is a command-line tool that displays
    network connections for TCP (both incoming and outgoing),
    routing tables, and a number of network interface and network protocol statistics.
    **Example Usage:** `netstat -ie`
    * [`nicstat`][09] prints network traffic, packets or Kb/s read and written.
    Its a utility like `top` for network interface card (NIC).
    It displays information and statistics about all your network card such as packets,
    kilobytes per second, average packet sizes and more.
    **Example Usage:** `nicstat -i wlan0 1`
* OpenWRT Console Connection
    * [`telnet`][] is a protocol which is part of the TCP/IP suite and used on the
    Internet or local area networks to provide a bidirectional interactive
    text-oriented communication facility using a virtual terminal connection.
    **Example Usage:** `telnet 192.168.8.1`

# Getting WiFI Connected with WRTnode

## Getting Connected with WRTnode Via GUI
The easiest way to get connected with OpenWRT on Ubuntu is via
the [network menu in the menu bar][08].
We know from the [WRTnode documentation][04] 
that the SSID being broadcasted by the WRTNode is "WRTnodeXXXX",
where the XXX is the last 4 digits of the OpenWRT's MAC address.
In my case its "WRTnode9976".
The [WRTnode documentation][04] also says that the default WiFi password is "12345678".

## Getting Connected with WRTnode Via Command Line
It is sometimes useful to be able to
[connect to a WiFi access point via the command line][03],
without a heavyweight GUI.
That is especially true when dealing with a simple but quirky device
like the WRTnode where you want optimal control and visibility.
I spent a while gathering the collective wisdom from various blog posts
and assembled it here.

First thing is to do is turn on the WiFi[^A]
and perfrom a scan to see if you can detect the WRTNode's broadcasted SSID.

[^A]:
    When I first turned on the WiFI vis `sudo ifconfig wlan0 up`,
    I got the error message: “Operation not possible due to RF-kill”.
    Checkout the post “[SIOCSIFFLAGS: Operation not possible due to RF-kill][01]”
    to see how to clear this problem with `sudo rfkill unblock wifi; sudo rfkill unblock all`.

```bash
# turn on your computers WiFi, if it isn't already
sudo ifconfig wlan0 up

# check WiFi network connection status, which should be "Not connected." at the point
iw wlan0 link

# perfrom a scan to get a list of WiFi networks in range
# and then grep for the most relavent information
sudo iwlist wlan0 scanning | egrep 'Cell |Encryption|IEEE|Quality|Last beacon|ESSID'
```

The last command should give you the SSID being broadcasted by the WRTNode,
in my case its "WRTnode9976".
Also, this will tell you that the encryption is on (see "Encryption key")
and it uses WPA2 encryption (see "IEEE").

Now we will generate a configuration file for `wpa_supplicant`
that contains the pre-shared key (“passphrase“) for the WiFi network.
We know from the [WRTnode documentation][04] that the default WiFi password is "12345678".

```bash
# generate the WPA2 pre-share key
wpa_passphrase WRTnode9976 12345678 > ~/tmp/wpa.conf
```

Now that we have the configuration file,
we can use it to connect to the WiFi network (Data Link Layer, not Transport Layer).
We will be using `wpa_supplicant to connect`.
Use the following command

```bash
# run in the forground
# -D specifies the wireless driver and "wext" is the generic driver
#sudo wpa_supplicant -D wext -i wlan0 -c ~/tmp/wpa.conf

# run in the background
sudo wpa_supplicant -B -D wext -i wlan0 -c ~/tmp/wpa.conf

# check WiFi network connection status
iw wlan0 link
```

The work so far has connected the WiFi network, now we do the IP networking.
To get a dynamic IP from a DHCP server built into the router,
you'll use [`dhclient`][07]

```bash
# first release whatever IP leases you're still holding onto
sudo dhclient -r wlan0

# ask for a new IP lease 
sudo dhclient wlan0
```

As long as you have `wpa_supplicant` running, you can toggle the WiFi connection 

```bash
# turn off your WiFi connection
sudo ifconfig wlan0 down

# turn it back on
sudo ifconfig wlan0 up
```

# Login to OpenWRT
The first time you connect to the OpenWRT,
you will do so via `telnet` in order to set the root password and start using `ssh`.

```bash
# telnet into OpenWRT without a password
telnet 192.168.8.1
.
.
.
# change the root password.  This will also turn off telnet and you can now use ssh to log in
passwd
```

At this point, you must use `ssh` to login with your new password

```bash
# secure login into OpenWRT
ssh root@192.168.8.1
```

OpenWRT also supports a web user interface, called [LuCI][18],
accessible via a browser via URL `192.168.8.1`.
You'll login as root using the password created for the establishment of `ssh`.

# Other Things
So now that your logged into the WRTnode, now what?
The [WRTnode Wiki][19] does give some good ideas.
For starters, your going to want to connect with the Internet to load OpenWRT packages,
update firmware, etc.

## Scanning for Other Access Points
`aps` is a WRTnode customized command which scans the WiFi SSIDs available.
Scan for Access Points that WRTnode's can reach.

```bash
root@OpenWrt:~# aps
WRTnode AP scaner.
Begin scaning APs, pls wait...
Finished.
APs available are...
ra0       get_site_survey:
Ch  SSID                             BSSID               Security               Siganl(%)W-Mode  ExtCH  NT WPS DPID
1   TRENDnet637                      00:14:d1:c3:c0:6f   WEP                    29       11b/g/n NONE   In YES     
6   Download Virus                   90:72:40:1b:c4:c6   WPA2PSK/AES            29       11b/g/n NONE   In  NO     
6   F9MH4                            00:26:62:73:0e:f8   WEP                    44       11b/g/n NONE   In  NO     
6   Battlestar                       00:26:62:66:92:3f   WPA1PSKWPA2PSK/AES     5        11b/g/n NONE   In  NO     
6   7D6GC                            00:26:b8:65:a6:e5   WEP                    24       11b/g/n NONE   In  NO     
6   74LL5                            00:1f:90:b4:8a:80   WPA1PSKWPA2PSK/AES     100      11b/g   NONE   In  NO     
6   W7JKF                            f8:e4:fb:7c:7a:b1   WPA2PSK/AES            10       11b/g/n NONE   In  NO     
6   Bridge-2.4                       e8:fc:af:93:b8:f9   WPA1PSKWPA2PSK/TKIPAES 86       11b/g/n NONE   In YES     
6   Guest Network                    92:c6:c4:1b:40:70   WPA2PSK/AES            39       11b/g/n NONE   In  NO     
11  CRL-EmployeesOnly                9c:1c:12:3e:c8:e0   WPA2/AES               10       11b/g/n NONE   In  NO     
11  NETGEAR99                        10:0d:7f:8b:ce:3f   WPA2PSK/AES            15       11b/g/n NONE   In YES     
11  RFOS8                            00:18:01:e3:08:ee   WEP                    20       11b/g   NONE   In  NO     
11  Campbell-WLAN                    00:1f:90:fb:27:20   WPAPSK/TKIP            5        11b/g   NONE   In  NO  
```

## Connecting with the Internet
To connect to the Internet,
WRTnode must configuring the up-link part of the router inside of WRTnode.
This is equivalent to the Ethernet WAN interface of your home router,
except your going to connect to your home WiFi router, which is your gateway to the Internet.
The WRTnode wiki article, [No internet no happiness][20], give you the details
need to do this.

Change the settings of `aplci` on WRTnode.
`aplci` is the up-link part of the router inside of WRTnode.
You make the changes via the WRTnode customized command `vw` which changes `/etc/config/wireless`.
It is used the file editor `vi`.

```bash
root@OpenWrt:~# vw

<screen refresh>

config wifi-device 'ra0'
        option type 'ralink'
        option mode '9'
        option channel '6'
        option txpower '100'
        option ht '20+40'
        option country 'US'
        option disabled '0'

config wifi-iface
        option device 'ra0'
        option network 'lan'
        option mode 'ap'
        option encryption 'psk2'
        option key '12345678'
        option ApCliEnable '1'
        option ApCliSsid 'aAP'
        option ApCliAuthMode 'WPA2PSK'
        option ApCliEncrypType 'AES'
        option ApCliPassWord '87654321'
        option ssid 'WRTnode9976'
```

...Use hightlight to ilustrate what values need to be changed...

```
config wifi-device 'ra0'
        option type 'ralink'
        option mode '9'
        option channel '6'
        option txpower '100'
        option ht '20+40'
        option country 'US'
        option disabled '0'

config wifi-iface
        option device 'ra0'
        option network 'lan'
        option mode 'ap'
        option encryption 'psk2'
        option key '12345678'
        option ApCliEnable '1'
        option ApCliSsid 'aAP'
        option ApCliAuthMode 'WPA2PSK'
        option ApCliEncrypType 'AES'
        option ApCliPassWord '87654321'
        option ssid 'WRTnode9976'
```

Next you need to rest the network.
`nr` is a WRTnode customized command which will reset the network side.
After 5 seconds it is possible to connect again to WRTnode's SSID.

```bash
root@OpenWrt:~# nr
```

Now verify if WRTnode got an IP from router from your home WiFi Access point:

```bash
root@OpenWrt:~# ia

...get listing

```

Finally, verify if WRTnode is connected to Internet.

```bash
root@OpenWrt:~# ping www.google.com

...get listing

```

So now the WRTnode board is connected to the Internet through our home router.
You can connect to the Internet start configure our WRTnode board.

## Update OpenWRT Software Repository
http://wiki.wrtnode.com/index.php?title=Starting#WRTnode_software_repository

## Restore Factory Settings
http://wiki.wrtnode.com/index.php?title=Starting#Restore_Factory_Settings

## More
http://wiki.wrtnode.com/index.php?title=Main_Page


####################
`ping` (Packet Internet Gropper)

`telnet` (teletype network) is a network protocol used on IP networks to provide a bidirectional
interactive text-oriented communication facility using a virtual terminal connection.

`route` manipulates the kernel's IP routing tables.

`ifconfig` is  used to configure the kernel-resident network interfaces.
It is used at boot time to set up interfaces as necessary.

`arp` (address resolution protocol) is used to translate protocol addresses to
hardware interface addresses.
The arp command displays a table of translated hardware addresses in the cache.


####################




# WRTNode
* [WRTnode](http://wrtnode.com/w/)
* [wrthelp – a demo app for the WRTnode](http://blog.thestateofme.com/2014/09/21/wrthelp/)
* [Getting Started with WRTnode OpenWRT Development Board](http://www.cnx-software.com/2014/09/18/wrtnode-quick-start-guide/)
* [WRTnode Wiki](http://wiki.wrtnode.com/index.php?title=Main_Page)
    * [WRTnode Getting Started Guide](http://wiki.wrtnode.com/index.php?title=Starting)
    * [Refresh the Firmware](http://wiki.wrtnode.com/index.php?title=Refresh_the_firmware)
* [Quick Mesh Project](http://qmp.cat/Experimenting_with_the_WRTnode)

[Finding a device IP Address](http://www.cnx-software.com/2010/10/25/finding-a-device-ip-address/)


[01]:http://askubuntu.com/questions/62166/siocsifflags-operation-not-possible-due-to-rf-kill
[02]:http://www.raspberrypi-spy.co.uk/2014/10/how-to-use-wavemon-to-monitor-your-wifi-connection/
[03]:http://www.blackmoreops.com/2014/09/18/connect-to-wifi-network-from-command-line-in-linux/
[04]:http://wiki.wrtnode.com/index.php?title=Starting
[05]:http://linux.about.com/library/cmd/blcmdl8_iwevent.htm
[06]:http://www.linuxjournal.com/article/8498
[07]:https://calomel.org/dhclient.html
[08]:https://help.ubuntu.com/14.04/ubuntu-help/net-wireless-connect.html
[09]:http://www.cyberciti.biz/hardware/linux-install-nicstat-command-to-print-network-statistics-for-nics/
[10]:http://www.binarytides.com/linux-netstat-command-examples/
[11]:http://www.busybox.net/
[12]:http://en.wikibooks.org/wiki/Learning_the_vi_Editor/BusyBox_vi
[13]:http://en.wikipedia.org/wiki/Util-linux
[14]:http://en.wikipedia.org/wiki/UClibc
[15]:http://en.wikipedia.org/wiki/Linux_kernel
[16]:http://en.wikipedia.org/wiki/BusyBox
[17]:http://www.makeuseof.com/tag/what-is-openwrt-and-why-should-i-use-it-for-my-router/
[18]:http://wiki.openwrt.org/doc/howto/firstlogin#luci
[19]:http://wiki.wrtnode.com/index.php?title=Starting
[20]:http://wiki.wrtnode.com/index.php?title=Starting#No_internet_no_happiness
[21]:http://www.seeedstudio.com
[22]:http://wrtnode.com/w/
[23]:http://www.mtk.com.tw/en/news-events/mediatek-news/mediatek-first-to-bring-80211ac-1t1r/
[24]:http://www.anz.ru/files/mediatek/MT7620_Datasheet.pdf
[25]:http://en.wikipedia.org/wiki/Media_Independent_Interface#Reduced_Media_Independent_Interface
[26]:
[27]:
[28]:
[29]:
[30]:
