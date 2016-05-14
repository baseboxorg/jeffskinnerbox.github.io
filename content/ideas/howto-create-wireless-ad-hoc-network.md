
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
It quick shows you what files need to be modified but with minimal explaination.

* [Raspberry Pi Tutorial – Connect to WiFi or Create An Encrypted DHCP Enabled Ad-hoc Network as Fallback](http://lcdev.dk/2012/11/18/raspberry-pi-tutorial-connect-to-wifi-or-create-an-encrypted-dhcp-enabled-ad-hoc-network-as-fallback/)

# Methods for Starting Ad-Hoc Network
On startup using the `/etc/network/interfaces` file or
using `ifconfig` and `iwconfig` while running.

# Are You Using NetworkManager
The default networking setup on Ubuntu, or sometimes Raspberry Pi,
assumes that you are using the machine as a desktop or a laptop.
To aid in the user experiance, the [NetworkManager][14] software utility has been provided.
Its aim is to simplify the use of computer networks on Linux-based
and other Unix-like operating systems.
It works in the background, out of the users control,
to make the networking experiance as simple as possible.

The trouble with this, it will fight you for control if you attempt anything but the basic network.
Because of this, we'll need to disable NetworkManager.
If NetworkManager is installed and set to run with upstart (the default),
it will try to manage your network interfaces.
Before you start configuring the ad-hoc network,
you need to stop the NetworkManager.
To see if NetworkManager is being used,
check with `sudo service network-manager status`.

To stop NetworkManager, you can do one of these two things:

1. Remove it: `sudo apt-get purge network-manager network-manager-gnome`
1. Disable it: Edit `/etc/init/network-manager.conf` and add the line `manual` near the beginning of the file.

# WiFi on the Command Line
* [Wi-Fi on the Command Line](http://www.linuxjournal.com/content/wi-fi-command-line)
* [Connect to WiFi network from command line in Linux](http://www.blackmoreops.com/2014/09/18/connect-to-wifi-network-from-command-line-in-linux/)
* [How do I connect to a WPA wifi network using the command line?](http://askubuntu.com/questions/138472/how-do-i-connect-to-a-wpa-wifi-network-using-the-command-line)
* [How to connect to a WPA/WPA2 WiFi network using Linux command line](http://linuxcommando.blogspot.com/2013/10/how-to-connect-to-wpawpa2-wifi-network.html)
* [How to configure a wifi card using a command line or terminal](https://www.thinkpenguin.com/gnu-linux/how-configure-wifi-card-using-command-line-or-terminal)

# WiFi Interface Adapter
Keep in mind that [not all Raspberry Pi WiFi adapters will support ad-hoc mode][04].
The popular and in expensive adaptors [Edimax EW-7811Un][06] and [OURLINK WU110EC][05].

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

# Setting Up /etc/network/interfaces File
The file `/etc/network/interfaces` contains network interface configuration
information for the [`ifup` and `ifdown` commands][10].
This is where you configure how your system is connected to the network.
For documentation on how to make use of this file,
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

# loopback interface will be configure at boot time, ????
auto lo
iface lo inet loopback

# ???
iface eth0 inet manual

# wifi interface will be configure at boot time, using dhcp
auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

To setting up the Raspberry Pi in Ad-Hoc WiFi mode,
you want to change this file to:

```bash
auto lo
iface lo inet loopback

iface eth0 inet dhcp

auto wlan0
iface wlan0 inet static
    address 192.168.1.1
    netmask 255.255.255.0
    wireless-mode ad-hoc
    wireless-keymode open
    wireless-channel 4
    wireless-essid mywifi
    wireless-key s:password

#auto wlan0
```
To restart the network:

```bash
sudo /etc/init.d/networking restart

# this command may work if the 'restart' command fails
 sudo /etc/init.d/networking reload
```

Running `/etc/init.d/networking restart` is deprecated
because it may not re-enable some interfaces.
The solution, if you experience this, is to use `sudo reboot`, or do it the hard way.

# Setting Up /etc/wpa_supplicant/wpa_supplicant.conf File
There is a companion file `/etc/wpa_supplicant/wpa_supplicant.conf`
which lists all accepted networks and security policies, including pre-shared keys.
Documentation on this configuration file can found in the [wpa_supplicant man page][12],
the [`wpa_supplicant` command man page][13],

Changes to the `/etc/wpa_supplicant/wpa_supplicant.conf`
configuration file can be reloaded be sending `SIGHUP` signal to `wpa_supplicant`
(i.e. `killall -HUP wpa_supplicant`).
Similarly, reloading can be triggered with the `wpa_cli reconfigure` command.

The typical `/etc/wpa_supplicant/wpa_supplicant.conf`
configuration file for the Raspberry Pi is:

```bash
country=GB
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

# home wifi network settings
network={
    id_str="home"
    ssid="my_wifi"
    scan_ssid=1
    psk="1234567890"
    proto=RSN
    key_mgmt=WPA-PSK
    pairwise=CCMP
    auth_alg=OPEN
}
```

For the Raspberry Pi in Ad-Hoc WiFi mode, you want to change this file to:

```bash
```

# Running DHCP Server on Ad-Hoc Network
* [Creating an Ad-hoc Wireless Network](https://wiki.gumstix.com/index.php/Creating_an_Ad-hoc_Wireless_Network)
* [Setting up ad-hoc in Debian with DHCP?](http://unix.stackexchange.com/questions/44851/setting-up-ad-hoc-in-debian-with-dhcp)
* [Raspberry Pi Tutorial – Connect to WiFi or Create An Encrypted DHCP Enabled Ad-hoc Network as Fallback](http://lcdev.dk/2012/11/18/raspberry-pi-tutorial-connect-to-wifi-or-create-an-encrypted-dhcp-enabled-ad-hoc-network-as-fallback/)

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

# Step XXX: WiFi Tools
[Wireless Tools for Linux and Linux Wireless Extension][03]
are a collection of user-space utilities
written for Linux to support and facilitate
the configuration of device drivers of wireless network interface controllers.

https://en.wikipedia.org/wiki/Wireless_tools_for_Linux
[Linux Commands: To Find Out Wireless Network Speed, Signal Strength And Other Information](http://www.cyberciti.biz/tips/linux-find-out-wireless-network-speed-signal-strength.html)
[Wi-Fi on the Command Line](http://www.linuxjournal.com/content/wi-fi-command-line)

* ifrename - renames network interfaces based on various static criteria.
* iwconfig - configures a wireless network interface.
* iwevent - displays wireless events generated by drivers and setting changes.
* iwgetid - reports ESSID, NWID or AP/Cell Address of wireless networks.
* iwlist - gets detailed wireless information from a wireless interface.
* iwpriv - configures optional (private) parameters of a wireless network interface.
* iwspy - gets wireless statistics from specific node.

Wifi Radar

```bash
# install wifi radar
sudo apt-get install wifi-radar

# run wifi radar
sudo wifi-radar
```

Wavemon

```bash
# install wavemon
sudo apt-get install wavemon

# run wavemon
wavemon
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

joint the chantilly library network - sudo iwconfig wlan0 essid ffxlib



[01]:https://en.wikipedia.org/wiki/Wireless_access_point
[02]:https://en.wikipedia.org/wiki/Wireless_ad_hoc_network
[03]:http://wireless.ictp.it/school_2002/software/802.11_and_linux/Software_Tools_for_WLAN.html
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
[14]:https://en.wikipedia.org/wiki/NetworkManager
[15]:http://slicepi.com/creating-an-ad-hoc-network-for-your-raspberry-pi/
[16]:
[17]:
[18]:
[19]:
[20]:
