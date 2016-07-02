
* [MONITORING THE SPECTRUM: BUILDING YOUR OWN DISTRIBUTED RF SCANNER ARRAY](http://www.rtl-sdr.com/talk-monitoring-spectrum-building-distributed-rf-scanner-array/)
* [Embedded rtl-sdr setup: RTL-SDR + OpenWRT = OMG!!](http://rtl-sdr.sceners.org/?p=40)
* [Building an RF Scanner Array](https://events.ccc.de/congress/2013/Fahrplan/system/attachments/2230/original/30c3-RFArray.pdf)

Instead of running coax from the USB DVB-T stick to an antenna,
use a small OpenWRT box with a USB TV stick and plug that in close to our antenna.
Then control and manage it over WiFi
Simply install the [rtlsdr package on OpenWRT](http://www.rtl-sdr.com/creating-a-wireless-sdr-receiver-with-a-mini-wifi-router/)
and you should be good to launch it from the command line.
This gives you a [remote radio head](https://en.wikipedia.org/wiki/Remote_radio_head).
A remote radio head is a remote radio transceiver that connects to an operator
radio control panel via electrical or wireless interface.

If you want to really get the most out of it,
it’s better to try and do some processing on the router itself.
A SDR decoding ADS-B signals with [MalcolmRobb‘s modifications dump1090](https://github.com/mutability/dump1090)
has been shown to work.
Dump1090 is also in the OpenWRT packages list,
and now even has a script to allow you to start it automatically.
