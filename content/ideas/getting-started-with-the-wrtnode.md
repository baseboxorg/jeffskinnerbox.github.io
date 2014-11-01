I got from Seeed Studio the WRTNode
Powered the board with the cable provided

First thing is to do is turn on the WiFi[^A]
and perfrom a scan to see if you can detect the WRTNode's broadcasted SSID.

[^A]:
    When I first turned on the WiFI vis `sudo ifconfig wlan0 up`,
    I got the error message: “Operation not possible due to RF-kill”.
    Checkout the post “[SIOCSIFFLAGS: Operation not possible due to RF-kill][01]”
    to see how to clear this problem.

```bash
# turn on your computers WiFi, if it isn't already
sudo ifconfig wlan0 up

# perfrom a scan to get a list of WiFi networks in range
# and then grep for the most relavent information
sudo iwlist wlan0 scanning | egrep 'Cell |Encryption|Quality|Last beacon|ESSID'
```

This should given you the SSID being broadcasted by the WRTNode,
in my case its "WRTnode9976".

```bash
sudo iwconfig wlan0 essid WRTnode9976
```

Connect to WiFi network from command line in Linux - http://www.blackmoreops.com/2014/09/18/connect-to-wifi-network-from-command-line-in-linux/

# WRTNode
* [WRTnode](http://wrtnode.com/w/)
* [Getting Started with WRTnode OpenWRT Development Board](http://www.cnx-software.com/2014/09/18/wrtnode-quick-start-guide/)
* [WRTnode Wiki](http://wiki.wrtnode.com/index.php?title=Main_Page)
    * [WRTnode Getting Started Guide](http://wiki.wrtnode.com/index.php?title=Starting)
    * [Refresh the Firmware](http://wiki.wrtnode.com/index.php?title=Refresh_the_firmware)
* [Quick Mesh Project](http://qmp.cat/Experimenting_with_the_WRTnode)

[Finding a device IP Address](http://www.cnx-software.com/2010/10/25/finding-a-device-ip-address/)


[01]:http://askubuntu.com/questions/62166/siocsifflags-operation-not-possible-due-to-rf-kill
[02]:
[03]:
[04]:
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:
