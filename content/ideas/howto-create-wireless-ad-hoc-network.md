
* [CJDNS Adhoc node](http://www.instructables.com/id/CJDNS-Adhoc-Node/?ALLSTEPS)
* [Setting up an ad-hoc wireless network between 2 Ubuntu machines](http://unixlab.blogspot.com/2010/01/setting-up-ad-hoc-wireless-network.htm)
* [Creating wireless ad-hoc network in Linux](http://addisu.taddese.com/blog/creating-wireless-ad-hoc-network-in-linux/)
* [Wireless Communication Between Raspberry Pi and Your Computer](https://spin.atomicobject.com/2013/04/22/raspberry-pi-wireless-communication/)
* [How to Set a Wireless Ad-Hoc in Linux?](http://hxr99.blogspot.com/2011/10/how-to-set-wireless-ad-hoc-in-linux.html)
* [Setting up an Ad-Hoc Network – And securing it using WPA](http://techblog.aasisvinayak.com/setting-up-an-ad-hoc-network-and-securing-it-using-wpa/)
* [Creating an Ad-hoc Wireless Network](https://wiki.gumstix.com/index.php/Creating_an_Ad-hoc_Wireless_Network)
* [Raspberry Pi Tutorial – Connect to WiFi or Create An Encrypted DHCP Enabled Ad-hoc Network as Fallback](http://lcdev.dk/2012/11/18/raspberry-pi-tutorial-connect-to-wifi-or-create-an-encrypted-dhcp-enabled-ad-hoc-network-as-fallback/)
* [Internet Connection Sharing in Linux over Ad-hoc Wireless](http://jwalanta.blogspot.com/2010/02/internet-connection-sharing-ics-in.html)
* [How to get a raspberry Pi to set up a wireless ad-hoc network, but only if it is not already connected](http://www.novitiate.co.uk/?p=183)
* [Hostapd : The Linux Way to create Virtual Wifi Access Point](https://nims11.wordpress.com/2012/04/27/hostapd-the-linux-way-to-create-virtual-wifi-access-point/)
* [Debian / Ubuntu Linux: Setup Wireless Access Point (WAP) with Hostapd](http://www.cyberciti.biz/faq/debian-ubuntu-linux-setting-wireless-access-point/)
* [Limitations of Ad Hoc Mode Wireless Networking](http://compnetworking.about.com/od/wirelessfaqs/f/adhoclimitation.htm)
* [Understanding Ad Hoc Mode](http://www.wi-fiplanet.com/tutorials/article.php/1451421/Understanding-Ad-Hoc-Mode.htm)
* [The Dangers Of Ad-Hoc Wireless Networking](http://www.windowsecurity.com/whitepapers/Wireless_Security/Dangers-Ad-Hoc-Wireless-Networking.html)


A [wireless ad-hoc network (WANET)][02],
also known as Independent Basic Service Set (IBSS),
is a decentralized type of wireless network.
The network is ad-hoc because it does not rely on a pre-existing infrastructure,
such as routers in wired networks or [access points][01] in managed (infrastructure) wireless networks.
Wireless stations communicate directly with one another on a peer-to-peer basis,
without using an access point or any intermediate network router.

The posting "[Creating an Ad-hoc network for your Raspberry Pi][15]"
does an excellent job of giving a simple explanation of
what needs to be done to create an Ad-Hoc WiFi network.
It quick shows you what files need to be modified but with minimal explanation.

* [Raspberry Pi Tutorial – Connect to WiFi or Create An Encrypted DHCP Enabled Ad-hoc Network as Fallback](http://lcdev.dk/2012/11/18/raspberry-pi-tutorial-connect-to-wifi-or-create-an-encrypted-dhcp-enabled-ad-hoc-network-as-fallback/)

To get my Ad-Hoc WiFI network operation, I'm going to follow these basic steps:

1. Getting Wireless Interface Name and Hardware Address
1. Connect to WiFi
1. Install and Configure DHCP Server
1. Update interfaces Config File
1. RPi Network Conf Bootstrapper
1. Prevent DHCP From Starting At Boot
1. Reboot and Test

[Check this out for more instructions - Chapter 5. Network setup](https://www.debian.org/doc/manuals/debian-reference/ch05.en.html#_the_loopback_network_interface)

# WiFi Interface Adapter Must Support A-Hoc Networking
Keep in mind that [not all Raspberry Pi WiFi adapters will support ad-hoc mode][04].
The WiFi adapters I'm using are the popular and inexpensive
[Edimax EW-7811Un][06] and [OURLINK WU110EC][05].

To test if the WiFi adapter can be placed into Ad-Hoc mode,
use the following commands:

```bash
# take the wifi interface down
sudo ifconfig wlan0 down

# set the interface to ad-hoc mode
sudo iwconfig wlan0 mode ad-hoc

# check to see if interface is in ad-hoc mode
sudo iwconfig wlan0 | grep Mode
```

# Turn-Off NetworkManager
The default networking setup on Ubuntu, or sometimes Raspberry Pi,
assumes that you are using the machine as a desktop or a laptop.
To aid in the user experiance, the [NetworkManager][14] software utility
has been provided to some Linux distributions.
NetworkManager attempts to keep an active network connection available at all times.
Its aim is to simplify the use of computer networks on Linux-based
and other Unix-like operating systems.
NetworkManager has a command-line tool for controlling it, called [`nmcli`][16].

The point of NetworkManager is to make networking configuration
and setup as painless and automatic as possible for the novice user.
If using DHCP, NetworkManager is intended to replace default routes,
obtain IP addresses from a DHCP server and change nameservers whenever it sees fit.
In effect, the goal of NetworkManager is to make networking just work.

The trouble with this, it will fight you for control if you attempt anything but the basic network.
Because of this, we'll need to disable NetworkManager.
If NetworkManager is installed and set to run with upstart (the default),
it will try to manage your network interfaces.
Before you start configuring the ad-hoc network,
you need to stop the NetworkManager.
To see if NetworkManager is being used,
check with `sudo service network-manager status`.

To stop NetworkManager, you can do one of these three things:

1. Remove it: `sudo apt-get purge network-manager network-manager-gnome`
1. Permanently Disable it: Edit `/etc/init/network-manager.conf` and add the line `manual` near the beginning of the file.
1. Temporarily Disable it: Using [command-line tool for controlling NetworkManager][16], `nmcli off`.

# Networking Tools
[`iw`][24] is the basic tool for WiFi network-related tasks,
such as finding the WiFi device name, and scanning access points.
[`wpa_supplicant`][13] is the wireless tool for connecting to a WPA/WPA2 network.
[`ip`][21] is used for enabling/disabling devices,
and finding out general network interface information.
Never the less, most network configuration manuals and blogs
still refer to [`ifconfig`][20] and [`route`][41]
as the primary network configuration tools,
but `ifconfig` is known to behave inadequately in modern network environments.

* [`ifconfig`][20] - configure a network interface
* [`route`][41] - command is used to show/manipulate the IP routing table.
* [`ping`][43] - (Packet Internet Gropper) is like a sonar pulse sent to detect connection and latency
* [`dig`][44] - (Domain Information Groper) is for interrogating DNS name servers
* [`traceroute`][42] - displays the route (path) and measuring transit delays of packets

Note that `ifconfig` is being deprecated via the [iproute2 package][19]
and is being replaced by [`ip`][17],
which you can see further explained/motivated [here][18].
(**NOTE:** [`ifconfig` isn't the only utility being deprecated][27].)

* [`ip`][21] - show / manipulate routing, devices, policy routing and tunnels

**CONVERT THIS BLOG TO `ip` AND DROP `ifconfig`!!!!!!!**

[Connect to WiFi network from command line in Linux](https://www.blackmoreops.com/2014/09/18/connect-to-wifi-network-from-command-line-in-linux/)
[How to connect to a WPA/WPA2 WiFi network using Linux command line](http://linuxcommando.blogspot.com/2013/10/how-to-connect-to-wpawpa2-wifi-network.html)
[Raspberry Pi Tutorial – Connect to WiFi or Create An Encrypted DHCP Enabled Ad-hoc Network as Fallback](http://lcdev.dk/2012/11/18/raspberry-pi-tutorial-connect-to-wifi-or-create-an-encrypted-dhcp-enabled-ad-hoc-network-as-fallback/)
More needs to be filled in below.

```bash
# find out the wireless device name
iw dev

# check that the wireless device is up
ip link show wlan0

# execute the following command to bring it up
sudo ip link set wlan0 up

# check the connection status
iw wlan0 link

# scan to find out what WiFi networks are detected
sudo /sbin/iw wlan0 scan

# obtain IP address by DHCP
sudo dhclient wlan0

# use the ip command to verify the IP address assigned by DHCP. The IP address is 192.168.1.113 from below.
ip addr show wlan0
```

# WiFi Tools
Managing your [WiFi via command line][39] can be done via an array of tools.
[Wireless Tools for Linux and Linux Wireless Extension][03]
are a collection of user-space utilities
written for Linux to support and facilitate
the configuration of device drivers of wireless network interface controllers.

* [`iwconfig`][22] - configure a wireless network interface (supports WEP)
* [`ifrename`][32] - renames network interfaces based on various static criteria
* [`iwevent`][33] - displays wireless events generated by drivers and setting changes
* [`iwgetid`][34] - reports ESSID, NWID or AP/Cell Address of wireless networks
* [`iwlist`][35] - gets detailed wireless information from a wireless interface
* [`iwpriv`][36] - configures optional (private) parameters of a wireless network interface
* [`iwspy`][37] - gets wireless statistics from specific node

Tools for user space daemon for access points and WPA/WPA2 authentication.

* [`wpa_cli`][29] - command line client program for interacting with `wpa_supplicant`.
* [`wpa_supplicant`][13] - WiFi Protected Access client and [WPA/WPA2/IEEE 802.1X supplicant][28]
* [`wpa_supplicant.conf`][12] - configuration file for `wpa_supplicant`
* [`hostapd`][38] - user space software turns normal network interface cards into access point

Some additional useful tools.

* [`rfkill`][23] - tool for enabling and disabling wireless devices
* [`wavemon`][40] - signal levels monitoring application for wireless network devices.

Note that `iw` is the anticipated successor to the `iwconfig` family of tools
but [still under development][25].
Not all wireless devices and drivers support the [nl80211 standard][26],
so the older wireless tools above may still be required.

* [`iw`][24] - show / manipulate wireless devices and their configuration (supports WEP)

# Methods for Establishing Wireless Ad-Hoc Network
On boot up, Linux uses the `/etc/network/interfaces` file to determine how its to use
the installed WiFi and Ethernet network interfaces.
Once Linux is up and running,
you can use the `ifconfig` (or `ip`) and `iwconfig` commands to adjust
what `/etc/network/interfaces` may have established.
In some instances,
we will want to permanently establish an ad-hoc network,
so the use the `/etc/network/interfaces` file is way to go.
Other times you'll want to do something temporary via the command line.

I'll be using both method here.
bla bla bla

* [Connect to WiFi network from command line in Linux](http://www.blackmoreops.com/2014/09/18/connect-to-wifi-network-from-command-line-in-linux/)
* [How do I connect to a WPA wifi network using the command line?](http://askubuntu.com/questions/138472/how-do-i-connect-to-a-wpa-wifi-network-using-the-command-line)
* [How to connect to a WPA/WPA2 WiFi network using Linux command line](http://linuxcommando.blogspot.com/2013/10/how-to-connect-to-wpawpa2-wifi-network.html)

# Step XXX: Typical Network Interface and Security Setup
This is where you configure how your system is connected to the network.
The file `/etc/network/interfaces` contains network interface configuration
information for when you boot up or use the [`ifup` and `ifdown` commands][10].
For additional documentation on how to make use of this file,
check out the examples in the file `/usr/share/doc/ifupdown/examples/network-interfaces`,
the [manual page for the file][08],
and the [network configuration documentation][07],
or this [good detailed explanation of `/etc/network/interfaces` syntax][09].

The default `/etc/network/interfaces` configuration file for
the Raspberry Pi will look something like this:

```bash
# interfaces(5) file used by ifup(8) and ifdown(8)

# Please note that this file is written to be used with dhcpcd
# For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

# start loopback interfaces upon boot up and register loopback interface
auto lo
iface lo inet loopback

#  start ethernet interface at boot time and uses dhcp
auto eth0
iface eth0 inet dhcp

# wifi interface will start with hotplug event and uses dhcp and use WPA2
allow-hotplug wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

The typical `/etc/wpa_supplicant/wpa_supplicant.conf`
configuration file for the Raspberry Pi would look something like this:

```bash
# country code environment variable, required for RPi 3
country=US

# path to the ctrl_interface socket and the user group
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev

# allow wpa_supplicant to overwrite configuration file whenever configuration is changed
update_config=1

# 1 = wpa_supplicant initiates scanning and AP selection ; 0 = driver takes care of scanning
ap_scan=1

# home wifi network settings
network={
    id_str="home"              # needs to match keyword you used in the interfaces file
    ssid="74LL5"               # SSID either as an ASCII string with double quotation or as hex string
    mode=0                     # 0 = managed, 1 = ad-hoc, 2 = access point
    scan_ssid=0                # = 1 do not broadcast SSID ; = 0 SSID is visible to scans
    proto=WPA RSN              # list of supported protocals; WPA = WPA ; RSN = WPA2 (also WPA2 is alias for RSN)
	key_mgmt=WPA-PSK WPA-EAP   # list of authenticated key management protocols (WPA-PSK, WPA-EAP, ...)
    psk="secret passphrase"    # pre-shared key used in WPA-PSK mode ; 8 to 63 character ASCII passphrase
    pairwise=CCMP              # accepted pairwise (unicast) ciphers for WPA (CCMP, TKIP, ...)
    auth_alg=OPEN              # authentication algorithms (OPEN, ShARED, LEAP, ...)
    priority=5                 # priority of selecting network (larger numbers are higher priority)
}
```

[WiFi Protected Access (WPA) and WiFi Protected Accesss II (WPA2)][45]
are 802.11 wireless authentication and encryption standards,
the successors to the simpler [Wired Equivalent Privacy (WEP)][46].
Most "locked" 802.11 wireless networks use WPA/WPA2 authentication
(its more secure than WEP)
and networks with hidden SSID (SSID not broadcasted)
can only be supported using `wpa_supplicant.conf`.
On most Linux systems, the [`wpa_supplicant`][12] daemon handles WPA/WPA2.
There is a companion file `/etc/wpa_supplicant/wpa_supplicant.conf`
which lists all accepted networks and security policies, including pre-shared keys.
Documentation on this configuration file can found in the [wpa_supplicant man page][12],
the [`wpa_supplicant` command man page][13],
[networking with multiple WiFi networks][48].
and [highly comment wpa-Supplicant configuration file][47].

Changes to the `/etc/wpa_supplicant/wpa_supplicant.conf`
configuration file can be reloaded be sending `SIGHUP` signal to `wpa_supplicant`
(i.e. `killall -HUP wpa_supplicant`).
Similarly, reloading can be triggered with the `wpa_cli reconfigure` command.

# Step XXX: Install WPA Graphical User Interface
`wpa_gui` is a graphical frontend program for interacting with `wpa_supplicant`.
It is used to query current status, change configuration and request interactive user input.

To install `wpa_gui` just do:

```bash
sudo apt-get install wpagui
```

[Setup wpa_gui and roaming on Debian](https://xrunhprof.wordpress.com/2009/09/19/setup-wpa_gui-and-roaming-on-debian/)

# Step XXX: Ad-Hoc Mode Using Static IP Address and WEP Security
To setting up the Raspberry Pi in Ad-Hoc WiFi mode using WEP and a status IP address,
you want to change the `/etc/network/interfaces` configuration file to:

```bash
# start loopback interfaces upon boot up and register loopback interface
auto lo
iface lo inet loopback

#  start ethernet interface at boot time and uses dhcp
auto eth0
iface eth0 inet dhcp

# wifi interface will start with hotplug event and uses dhcp and use WEP
allow-hotplug wlan0
iface wlan0 inet static
    address 192.168.1.1            # ip address being assigned to the device
    netmask 255.255.255.0
    wireless-mode ad-hoc
    wireless-keymode open
    wireless-channel 4
    wireless-essid my-ad-hoc-wifi
    wireless-key s:<password>
```

Static IP addressing is being used since its assumed that the ad-hoc network
doesn't have DHCP operating.
And the use of WEP is for simplisity since it doesn't require any
`/etc/wpa_supplicant/wpa_supplicant.conf` file.

# Step XXX: Ad-Hoc Mode Using DHCP and WPA Security
A better way to go for the Ad-Hoc WiFi is to use WPA2 (stronger security)
and have the IP address assigned via DHCP (no preplanning of IP adressing required).
You see this in the `/etc/wpa_supplicant/wpa_supplicant.conf` code block below:

```bash
# country code environment variable, required for RPi 3
country=US

# path to the ctrl_interface socket and the user group
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev

# this allows you to configure wpa_supplicant.conf using wpa_gui
update_config=1

# generaly it's 1 for wpa but here we have 2 because we are using wpa2 which is safer
eapol_version=2

# 1 = wpa_supplicant initiates scanning and AP selection ; 0 = driver takes care of scanning
ap_scan=1

# home wifi network settings
network={
    id_str="home"              # needs to match keyword you used in the interfaces file
    ssid="74LL5"               # SSID either as an ASCII string with double quotation or as hex string
    mode=0                     # 0 = managed, 1 = ad-hoc
    scan_ssid=0                # 0 = do not scan with specific Probe Request frames
    proto=WPA RSN              # list of supported protocals; WPA = WPA ; RSN = WPA2 (also WPA2 is alias for RSN)
	key_mgmt=WPA-PSK WPA-EAP   # list of authenticated key management protocols (WPA-PSK, WPA-EAP, ...)
    psk="secret passphrase"    # key used in WPA-PSK mode ; 8 to 63 character ASCII passphrase
    pairwise=CCMP              # accepted pairwise (unicast) ciphers for WPA (CCMP, TKIP, ...)
    auth_alg=OPEN              # authentication algorithms (OPEN, ShARED, LEAP, ...)
    priority=5                 # priority of selecting network (larger numbers are higher priority)
}
`
# ad-hoc wifi network settings
network={
    id_str="ad-hoc"            # needs to match keyword you used in the interfaces file
    ssid="my-ad-hoc-wifi"      # SSID either as an ASCII string with double quotation or as hex string
    mode=1                     # 0 = managed, 1 = ad-hoc
    scan_ssid=0                # 0 = do not scan with specific Probe Request frames
    proto=WPA RSN              # list of supported protocals; WPA = WPA ; RSN = WPA2 (also WPA2 is alias for RSN)
	key_mgmt=WPA-PSK WPA-EAP   # list of authenticated key management protocols (WPA-PSK, WPA-EAP, ...)
    psk="secret passphrase"    # key used in WPA-PSK mode ; 8 to 63 character ASCII passphrase
    pairwise=CCMP              # accepted pairwise (unicast) ciphers for WPA (CCMP, TKIP, ...)
    auth_alg=OPEN              # authentication algorithms (OPEN, ShARED, LEAP, ...)
    priority=1                 # priority of selecting network (larger numbers are higher priority)
}
```

The `/etc/network/interfaces` configuration file is:

```bash
```

You can query the current status of WPA/WPA2 with the shell command:

```bash
# get the status of your WPA network
wpa_cli status
```

To restart the network:

```bash
sudo /etc/init.d/networking restart

# this command may work if the 'restart' command fails
 sudo /etc/init.d/networking reload
```

To start the interface, you can use

```bash
# -B means run wpa_supplicant in the background.
# -D specifies the wireless driver. wext is the generic driver.
# -c specifies the path for the configuration file.
sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf

# verify that you are indeed connected to the SSID
iw wlan0 link
```

**Note:** Running `/etc/init.d/networking restart` is deprecated
because it may not re-enable some interfaces.
The solution, if you experience this, is to use `sudo reboot`, or do it the hard way.

# Step XXX: Install and Configure DHCP Server
* [Creating an Ad-hoc Wireless Network](https://wiki.gumstix.com/index.php/Creating_an_Ad-hoc_Wireless_Network)
* [Setting up ad-hoc in Debian with DHCP?](http://unix.stackexchange.com/questions/44851/setting-up-ad-hoc-in-debian-with-dhcp)
* [Raspberry Pi Tutorial – Connect to WiFi or Create An Encrypted DHCP Enabled Ad-hoc Network as Fallback](http://lcdev.dk/2012/11/18/raspberry-pi-tutorial-connect-to-wifi-or-create-an-encrypted-dhcp-enabled-ad-hoc-network-as-fallback/)

Install the `isc-dhcp-server` package for the DHCP server

```bash
# install dhcp server
sudo apt-get update
sudo apt-get install isc-dhcp-server
```

Not sure if the below is correct..........

Setting up a DHCP server on the ad-hoc network will allow devices to connect
to the network without having to manually establish for them an IP address.
Only one of the ad-hoc networks nodes needs the DHCP server.

To do this, you need to update the DHCP configuration file `/etc/dhcp/udhcpd.conf`.

Put the following in the file `/etc/dhcp/udhcpd.conf`:

```bash
#start address
start  192.168.1.2

#end address
end   192.168.1.254

#interface to listen on
interface   wlan0

#maximum number of leases
max_leases   64
```

Now get DHCP up and running:

```bash
# create the leases file
sudo touch /var/lib/misc/udhcpd.leases

# run the dhcp server
sudo udhcpd /etc/udhcpd.conf
```


# Step XXX: Finding a Quite WiFi Channel
The first step is to see what wireless networks are available in your area.
The utility `iwlist` provides all sorts of information about your wireless environment.
To scan your environment for available networks, do the following:

```bash
# list the available channels and what is being used
$ iwlist wlan0 channel
wlan0     11 channels in total; available frequencies :
          Channel 01 : 2.412 GHz
          Channel 02 : 2.417 GHz
          Channel 03 : 2.422 GHz
          Channel 04 : 2.427 GHz
          Channel 05 : 2.432 GHz
          Channel 06 : 2.437 GHz
          Channel 07 : 2.442 GHz
          Channel 08 : 2.447 GHz
          Channel 09 : 2.452 GHz
          Channel 10 : 2.457 GHz
          Channel 11 : 2.462 GHz
          Current Frequency:2.412 GHz (Channel 1)
```

```bash
# scan for wifi networks
$ sudo iwlist wlan0 scan

wlan0     Scan completed :
          Cell 01 - Address: 48:5D:36:2E:EE:08
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=55/70  Signal level=-55 dBm
                    Encryption key:on
                    ESSID:"74LL5"
                    Bit Rates:1 Mb/s; 2 Mb/s; 5.5 Mb/s; 11 Mb/s; 18 Mb/s
                              24 Mb/s; 36 Mb/s; 54 Mb/s
                    Bit Rates:6 Mb/s; 9 Mb/s; 12 Mb/s; 48 Mb/s
                    Mode:Master
                    Extra:tsf=0000003c453b8b96
                    Extra: Last beacon: 40ms ago
                    IE: Unknown: 000537344C4C35
                    IE: Unknown: 010882848B962430486C
                    IE: Unknown: 030101
                    IE: Unknown: 0706555320010B1E
                    IE: Unknown: 2A0100
                    IE: Unknown: 2F0100
                    IE: IEEE 802.11i/WPA2 Version 1
                        Group Cipher : CCMP
                        Pairwise Ciphers (1) : CCMP
                        Authentication Suites (1) : PSK
                    IE: Unknown: 32040C121860
                    IE: Unknown: 2D1AAD1917FFFFFF0000000000000000000000000000000000000000
                    IE: Unknown: 3D1601080400000000000000000000000000000000000000
                    IE: Unknown: 7F080400000000000040
                    IE: Unknown: DD780050F204104A0001101044000102103B0001031047001050BA0730CF99C24BBECB5E3611CB792410210009477265656E5761766510230003424852102400013410420001311054000800060050F20400011011000E477265656E576176652042485234100800022008103C0001031049000600372A000120
                    IE: Unknown: DD09001018020A005C0000
                    IE: Unknown: DD180050F2020101880003A4000027A4000042435E0062322F00
          Cell 02 - Address: FA:8F:CA:6C:C8:1F
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=55/70  Signal level=-55 dBm
                    Encryption key:off
                    ESSID:""
                    Bit Rates:1 Mb/s; 2 Mb/s; 5.5 Mb/s; 11 Mb/s; 6 Mb/s
                              9 Mb/s; 12
                              .
                              .
                              .
```

To see what channels are being used or list network SSID, try this:

```bash
# list the wifi channels being used
$ sudo iwlist wlan0 scan | grep \(Channel
                    Frequency:2.412 GHz (Channel 1)
                    Frequency:2.412 GHz (Channel 1)
                    Frequency:2.412 GHz (Channel 1)
                    Frequency:2.437 GHz (Channel 6)
                    Frequency:2.437 GHz (Channel 6)

# list the ssid of the networks
$ sudo iwlist wlan0 scan | grep ESSID
                    ESSID:"74LL5"
                    ESSID:"SQLKL"
                    ESSID:""
                    ESSID:"hpsetup"
                    ESSID:"NETGEAR10"
```

To find out which channels are congested, the command below
lists how many networks are on each channel:

```bash
# lists how many networks are on each channel
$ sudo iwlist wlan0 scan | grep Frequency | sort | uniq -c | sort -n
      2                     Frequency:2.437 GHz (Channel 6)
      3                     Frequency:2.412 GHz (Channel 1)
```


# Step XXX: XXX
# Step XXX: Ad-Hoc Secured with WEP
# Step XXX: Ad-Hoc Secured with WAP
[Setting up an Ad-Hoc Network – And securing it using WPA](http://techblog.aasisvinayak.com/setting-up-an-ad-hoc-network-and-securing-it-using-wpa/)

# Optional Boot Time Ad-Hoc Network
What if you want to access your Raspberry Pi (RPi)
but there is no access point it can associate with?
In the past, what I have resorted to is a [console cable][31],
which works nicely but requires access to GPIO pins and of course the properly designed cable.

[WirelessAutoselect](https://wiki.ubuntu.com/WirawanPurwanto/WirelessAutoselect)


The posting "[Raspberry Pi Tutorial – Connect to WiFi or Create An Encrypted DHCP Enabled Ad-hoc Network as Fallback][30]"
provides a great idea on how to access your RPi when in this situation.
WiFi access point available.
You simply configured the RPi to first attempt to connect to your know WiFi access points.
If that fails, create and use an ad-hoc network as fallback.
This way I can always reach the RPi via another WiFi device, like a laptop,
on the same ad-hoc network using SSH.

So the idea is that we use a WPA2 protested WiFi connection for typical usage,
but use an ad-hoc network as fallback if we cannot connect on boot.
To make it easier to connect and secure with the ad-hoc network,
we'll use a DHCP server and use WPS2 for the ad-hoc network.

##############
joint the chantilly library network - sudo iwconfig wlan0 essid ffxlib
##############



[01]:https://en.wikipedia.org/wiki/Wireless_access_point
[02]:https://en.wikipedia.org/wiki/Wireless_ad_hoc_network
[03]:http://www.labs.hpe.com/personal/Jean_Tourrilhes/Linux/Tools.html
[04]:https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=88623
[05]:http://www.amazon.com/MM-OURLINK-WU110EC-Wireless-Repeater/dp/B00OZP5OJS
[06]:http://www.amazon.com/Edimax-EW-7811Un-150Mbps-Raspberry-Supports/dp/B003MTTJOY?ie=UTF8&psc=1&redirect=true&ref_=oh_aui_detailpage_o04_s00
[07]:https://wiki.debian.org/NetworkConfiguration
[08]:https://manpages.debian.org/cgi-bin/man.cgi?query=interfaces&apropos=0&sektion=0&manpath=Debian+7.0+wheezy&format=html&locale=en
[09]:http://unix.stackexchange.com/questions/128439/good-detailed-explanation-of-etc-network-interfaces-syntax
[10]:http://www.linux-tutorial.info/modules.php?name=ManPage&sec=8&manpage=ifup
[11]:https://en.wikipedia.org/wiki/Supplicant_(computer)
[12]:http://linux.die.net/man/5/wpa_supplicant.conf
[13]:http://linux.die.net/man/8/wpa_supplicant
[14]:https://wiki.debian.org/NetworkManager
[15]:http://slicepi.com/creating-an-ad-hoc-network-for-your-raspberry-pi/
[16]:https://manpages.debian.org/cgi-bin/man.cgi?sektion=1&query=nmcli&apropos=0&manpath=sid&locale=en
[17]:https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf
[18]:http://packetpushers.net/linux-ip-command-ostensive-definition/
[19]:http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2
[20]:http://linux.die.net/man/8/ifconfig
[21]:http://linux.die.net/man/8/ip
[22]:http://linux.die.net/man/8/iwconfig
[23]:http://linux.die.net/man/1/rfkill
[24]:http://linux.die.net/man/8/iw
[25]:https://wireless.wiki.kernel.org/en/users/Documentation/iw
[26]:https://wireless.wiki.kernel.org/en/developers/documentation/nl80211
[27]:https://dougvitale.wordpress.com/2011/12/21/deprecated-linux-networking-commands-and-their-replacements/
[28]:https://w1.fi/wpa_supplicant/
[29]:http://linux.die.net/man/8/wpa_cli
[30]:http://lcdev.dk/2012/11/18/raspberry-pi-tutorial-connect-to-wifi-or-create-an-encrypted-dhcp-enabled-ad-hoc-network-as-fallback/
[31]:https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable/overview
[32]:http://linux.die.net/man/8/ifrename
[33]:http://linux.die.net/man/8/iwevent
[34]:http://linux.die.net/man/8/iwgetid
[35]:http://linux.die.net/man/8/iwlist
[36]:http://linux.die.net/man/8/iwpriv
[37]:http://linux.die.net/man/8/iwspy
[38]:https://seravo.fi/2014/create-wireless-access-point-hostapd
[39]:http://www.linuxjournal.com/content/wi-fi-command-line
[40]:http://www.raspberrypi-spy.co.uk/2014/10/how-to-use-wavemon-to-monitor-your-wifi-connection/
[41]:http://linux.about.com/od/commands/l/blcmdl8_route.htm
[42]:http://pcsupport.about.com/od/commandlinereference/p/tracert-command.htm
[43]:http://linux.die.net/man/8/ping
[44]:http://www.thegeekstuff.com/2012/02/dig-command-examples/
[45]:https://en.wikipedia.org/wiki/Wi-Fi_Protected_Access
[46]:https://en.wikipedia.org/wiki/Wired_Equivalent_Privacy
[47]:https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf
[48]:http://jlcreations.com/raspberry-pi-wifi-multiple-networks/
[49]:
[50]:
[51]:
[52]:
[53]:
[54]:
[55]:
[56]:
[57]:
[58]:
[59]:
[60]:

