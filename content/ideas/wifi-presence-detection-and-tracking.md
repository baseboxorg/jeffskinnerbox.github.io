* [Quickie WiFi Scanner](http://hackaday.com/2016/02/24/quickie-wifi-scanner/)
* [Opportunistically track and transmit the location of a ESP8266](https://github.com/dancudds/esp8266locationtracker)
* [WiFi Scanner -Know the WiFi Signal around you](http://www.seeedstudio.com/recipe/219-wifi-scanner-know-the-wifi-signal-around-you.html)
* [An introduction to the Kismet packet sniffer](https://www.linux.com/news/introduction-kismet-packet-sniffer)
* [Passive WiFi Tracking](http://edwardkeeble.com/2014/02/passive-wifi-tracking/)
* [Passive wifi presence detection on Raspberry Pi](http://umm.io/blog/passive-wifi-tracking.html)
* [Tracking people via WiFi (even when not connected)](https://www.crc.id.au/tracking-people-via-wifi-even-when-not-connected/)
* [Show me your SSID’s, I’ll Tell Who You Are!](https://blog.rootshell.be/2012/01/12/show-me-your-ssids-ill-tell-who-you-are/)
* [Using Raspberry Pi Access Point to Track Devices](https://www.yetanotherblog.com/2014/03/25/using-raspberry-pi-access-point-to-track-devices/)
* [Tracking Devices via Raspberry Pi (Part Two)](https://www.yetanotherblog.com/2014/03/25/tracking-devices-via-raspberry-pi-part-two/)
* [Tracking of devices through passive listening of WiFi](http://developers-club.com/posts/252831/)
* [Introduction to Wi-Fi (802.11 or WiFi)](http://ccm.net/contents/802-introduction-to-wi-fi-802-11-or-wifi)

# Skyhook Precision Location
Use Skyhook Precision Location on a Raspberry Pi device running Raspbian Linux.
The device will continuously record its location, even when disconnected from the internet or not.

* [Skyhook Wireless Developer Site](http://www.skyhookwireless.com/developers)

# WiFi Modes
A WiFi network device always operates in one (or for some special hardware,
multiple modes as in AP+STA or WDS with AP Mode) of the six modes that 802.11 wireless cards can operate in:

1. Master / Access Point - acting as an access point (AP)
1. Managed / Station / STA / Access Point Client / Wireless Client / Client - act as a client to an access point
1. Ad-Hoc / Point-to-Point / Wireless Bridge - directly connecting two or more computers without an access point
1. Mesh / Point-to-Multipoint / Multi-point Bridge - decentralized interconnection with other wireless access points
1. Repeater / WDS - wireless interconnection to other access points to form a single managed network
1. Monitor - passively read packets, no packets are transmitted

Strictly speaking, Infrastructure Mode is not a device mode but a concept.

# Monitor Mode
Monitor mode is a passive-only mode, no packets are transmitted. All incoming packets are handed over to the host computer completely unfiltered. This mode is useful to see what's going on on the network.

With some hardware, it is possible to have a network device in monitor mode while in one of the other modes. This is useful to observe the network whilst using it. However, not all hardware fully supports this. It may also be possible to transmit packets in monitor mode, which is known as packet injection (aka RadioTap).

Unlike Promiscuous Mode, which is also used for packet sniffing, monitor mode allows packets to be captured without having to associate with an access point or ad hoc network first. Monitor mode only applies to wireless networks, while promiscuous mode can be used on both wired and wireless networks.

# Kali
[Wifi Autoscaning w/ Raspberry Pi and Kali Linux](http://cdf123x.blogspot.com/2013/04/wifi-autoscaning-w-raspberry-pi-and.html)

# Kismet
Kismet is an 802.11 wireless network detector, sniffer, and intrusion detection system.
Kismet will work with any wireless card which supports raw monitoring mode,
and can sniff 802.11b, 802.11a, 802.11g, and 802.11n traffic.

# WiFi Channels
Selecting the proper WiFi channel can significantly improve your WiFi coverage and performance.
In the 2.4 GHz band, [1, 6 and 11 are the only non-overlapping channels][01],
and many wireless routers automatically select the channel for you upon initial setup.
where depending on your wireless environment,
it could lead to slow WiFi speeds and interference.



[01]:http://www.extremetech.com/computing/179344-how-to-boost-your-wifi-speed-by-choosing-the-right-channel
[02]:
[03]:
[04]:
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:
