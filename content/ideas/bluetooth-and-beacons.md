
* [Why airports are slow to install beacons](https://www.tnooz.com/article/airport-beacons/)
* [Beacon tracking with Node.js and Raspberry Pi](https://medium.com/truth-labs/beacon-tracking-with-node-js-and-raspberry-pi-794afa880318#.ol4qucksj)
* [Immersive Theatre via iBeacons with Dustin Freeman](http://hackaday.com/2015/12/18/immersive-theatre-via-ibeacons-with-dustin-freeman/)
* [Sensorberg – Open Source Beacon Management](http://sensorberg-dev.github.io/)
* [Will BLE be the death of traditional RTLS? - the follow up](https://www.linkedin.com/pulse/ble-death-traditional-rtls-follow-up-mark-brown?trk=eml-b2_content_ecosystem_digest-network_publishes-49-null&midToken=AQFNblHgIt9-6A&fromEmail=fromEmail&ut=2dOzXtHst4JD81)
* [BLE advertising beacons using an nRF24L01+ module ](http://hackaday.com/2016/06/21/hackaday-prize-entry-ble-beacon-library/)
* [Bluetooth Devices Can Now Be Controlled From The Web Through Node.js](https://arc.applause.com/2016/02/12/bluetooth-gateway-navible-node-js/)
* [Introducing the Adafruit Bluefruit LE Friend](https://learn.adafruit.com/introducing-adafruit-ble-bluetooth-low-energy-friend)

# Bluetooth Standards
Bluetooth is one of the mainstays of the gadget world,
allowing devices to communicate easily over short distances.
It does this without the complexity and power requirements of WIFi.
In 1998 the [Bluetooth Special Interest Group (SIG)][20] was formed with five companies.
and the Bluetooth 1.0 Specification was released in 1999.

Bluetooth classifies devices by their purpose,
creating a number of [profiles][28] for things like headsets,
headphones and human interface devices such as mice and keyboards.
A2DP, GATT, HID and BIP are all important Bluetooth profiles.
[A2DP (Advanced Audio Distribution Profile)][27]
makes streaming stereo music possible.
[GATT (Generic Attribute Profile)][26]
allows developers to build unique profiles specific for their applications.
[HID (Human Interface Device Profile)][27]
makes your Bluetooth enabled mice and keyboards work effortlessly.
[BIP (Basic Imaging Profile)][27]
allows you to send images between devices (other phones, printers, even picture frames).

## Classic Bluetooth
There are essentially two strains of Bluetooth,
the older legacy or classic strain that encompasses versions 1.0 through 3.0 (including EDR).
The other strain is the low-energy Bluetooth that includes versions 4.0, 4.1, and 4.2.
(See this [video][32] for a pratical discript of the deferances between these secifications.)
The low-energy version uses a different radio technology than the classic strain.
It employs frequency-hopping spread spectrum (FHSS) over the 2.4- to 2.483-GHz spectrum,
but uses 40 2-MHz-wide channels rather than the 79 1-MHz channels of classic Bluetooth.
Max data rate is 1 Mb/s.
Most of the newer Bluetooth chips actually contain both types of radios.

## Bluetooth 4.2
Bluetooth 4, also known as Bluetooth Low Energy / Bluetooth LE / BLE / Bluetooth Smart,
is the fourth version of the Bluetooth standard.
Finalized in 2010, Bluetooth 4.0 has been updated several times since,
and the current version is 4.2, released in July of 2015.
The purpose of Bluetooth LE is to open the standard up to a new class of devices:
those that send small amounts of data infrequently, and run off of small batteries.

The 4.2 version creates three different classes of device:
Standard Bluetooth (or just Bluetooth), Bluetooth Smart Ready, and Bluetooth Smart.

* **Standard Bluetooth** device have the classic power consumption,
such as a cell phone or USB dongle, can also send and receive Bluetooth LE signals.
* **Bluetooth Smart** indicates a low power device, such as a pedometer or heart monitor,
that can only send and receive Bluetooth LE signals
* **Bluetooth Smart Ready** device can handle LE and standard Bluetooth signals.

There are multiple companies that make Bluetooth chips, such as
[Nordic Semiconductor](http://www.nordicsemi.com/eng/Products/Bluetooth-low-energy),
[Texas Instruments](http://www.ti.com/lsds/ti/wireless-connectivity/bluetooth-low-energy/overview.page?DCMP=BluetoothLowEnergy&HQS=Bluetoothlowenergy),
and [CSR](http://www.csr.com/products/bluetooth-smart-starter-development-kit).

Bluetooth classifies devices by their purpose,
creating a number of profiles for things.
Bluetooth LE adds a new set of these profiles,
called [Generic Attribute (GATT) profiles][17].
These include profiles for devices such as blood pressure monitors,
and more generic profiles for devices like key fobs (the proximity profile).
Most Bluetooth LE devices support a number of these profiles,
with the specific profiles that are enabled being controlled by the firmware on the device.

Be aware that Mike Ryan has demonstrated [numerous security problems with the standard][16],
breaking the encryption that the protocol uses and demonstrating
how it is possible to remotely crash an Android phone using a Bluetooth radio.
See [Mike Ryan's talk][18] on the subject (also [slides][19]).

## Difference Between Bluetooth Low Energy and Classic Bluetooth
Classic Bluetooth & Bluetooth low energy - [what's the difference][31]?
Also see this [video][30].
The Bluetooth low energy device consumes less energy that the classic by
being in sleep mode most of the time.
ts maximum/peak power consumption is only 15 mA
and the average power consumption is of only about 1 uA.
In Bluetooth low energy technology,
the actual connection times are of only a few mS
and thereby the connection is quickly initiated as the device wakes up.

Data transfer rates with Classic Bluetooth technology
using Enhanced Data Rate (Bluetooth v2.1 + EDR)
can exceed 2 Mbps (actual payload),
but practical transfer rates for Bluetooth low energy technology
are below 100 kbps (actual payload of roughly 1/20).

Just as with Classic Bluetooth technology,
Bluetooth low energy technology is based on a master connected to a number of slaves.
However, in Bluetooth low energy technology the number of slaves can be very large;
how large depends on the implementation and available memory.

## Bluetooth 5
[Bluetooth SIG released the Bluetooth 5 specification in December 2016][29]
and said ito would change the way that people interact with the Internet of Things.
(See this [video][33] for a good discription and advantages of Bluetooth 5)
Bluetooth 5 claims a 4x range, 2x speed and 8x broadcasting message capacity of it predacessor.
These features, along with improved interoperability and coexistence with other wireless technologies.
Bluetooth 5 is an enhancement to the low-energy version.
Version 5 bumps the data rate up to 2 Mb/s.
It still uses the same GFSK modulation, though.
The higher data rate decreases the transmission time of the messages
sent to better conserve power.
The basic power output level is 0 dBm or 1 mW,
but higher-power classes of Bluetooth can also be used.
The options are 4, 10, or 20 dBm for extended range.

Low-energy Bluetooth has a nominal range of 10 to 30 meters.
Bluetooth 5 extends this to the 30- or 50-meter range.
With a line-of-sight path, the range can be many hundreds of meters.
The longer range in Bluetooth 5 is achieved by using a strong
forward-error-correction (FEC) scheme to correct errors.
It trades off speed for range, which is a positive feature for some applications.

Bluetooth 5 ups the payload capacity of it packets.
Data packets can now be in the 31- to 255-octet range,
and that means fewer transmissions and less broadcast time.
Bluetooth 5 also incorporates features to better minimize interference.
Bluetooth shares the 2.4-GHz ISM band with Wi-Fi, ZigBee,
and a bunch of other wireless devices,
so there’s a greater likelihood for interference.
The new features detect and prevent interference at the band edges.
Version 5 should also expand the reach beacons for proximity sensing and location messaging.
And all the while, Bluetooth 5 is backwards-compatible with the 4.x versions.

* [Add Bluetooth 5 to Raspberry Pi 3 or create gadgets with this new chip](http://www.itworld.com/article/3172470/internet-of-things/add-bluetooth-5-to-raspberry-pi-3-or-create-gadgets-with-this-new-chip.html)

# Bluetooth Beacons
* [Guide to iBeacon Hardware](http://beekn.net/guide-to-ibeacons/)
* [The Beacon Experiments: Low-Energy Bluetooth Devices in Action](http://blog.shinetech.com/2014/02/17/the-beacon-experiments-low-energy-bluetooth-devices-in-action/)
* [The Hitchhikers Guide to iBeacon Hardware: A Comprehensive Report by Aislelabs (2015)](http://www.aislelabs.com/reports/beacon-guide/)

# Bluetooth Mesh
Even though the support for mesh networking wasn't
included in the core specification of Bluetooth 4,
several companies noticed that building a mesh network based
on this particular communication standard might not be such a bad idea.
In 2014, [Silvair (operating as Seed Labs back then)][35]
started building a mesh architecture based on Bluetooth Smart.
Silvair and others have formed a [Bluetooth Smart Mesh Working Group][36]
At this time, it appears thar Bluetooth Mesh will be coming out on Bluetooth 5,
but [no specific timeline for specfications to be delivered][37].

# Apple iBeacon
* [linux-ibeacon - Python script that creates an Apple iBeacon®-compatible Bluetooth LE beacon using a computer running Linux and a Bluetooth LE adapter](https://github.com/dburr/linux-ibeacon/)
* [iBeacon vs Eddystone – which is the better one for your business?](https://www.whatech.com/mobile-apps/blog/271289-ibeacon-vs-eddystone-which-is-the-better-one-for-your-business)

# Google Eddystone
Eddystone is an open-source library built by Google as part of their
Physical Web project for developers to leverage beacons in ways that
make experiences more meaningful and substantial than a one-off application use.
In contrast to Apple’s closed and proprietary iBeacon protocol,
which transmits IDs to users that must be consumed by specially-built mobile apps,
the Eddystone beacon protocol emits a URL that developers can
configure in a beacon either manually or by using a backend service.
Eddystone expands beacon functionality with links,
rather than with app notifications (although it also supports app notifications),
and since the URLs it emits are consumable by the Chrome browser already installed on many devices,
especially Android phones,
the protocol is not dependent on a one-off mobile app download to drive the experience.

This firmware application is fully configurable via [Eddystone Configuration GATT Service][07].
There are several ways to configure the Eddystone beacon.
For example:

* [Web Bluetooth Configuration Tool][08] (Android | iOS | Desktop)
* [nRF Beacon for Eddystone][09] (Android)
* Updating the firmware can be done using nRF Connect ([Android][11] | [iOS][12]).

You can build simple interactions between [nearby][10] devices and people:

* Nearby Messages exposes simple publish and subscribe methods that rely on proximity.
* Nearby Connections enables your app to easily discover other devices on a local network, connect, and exchange messages in real-time. Use Nearby Connections to create multiplayer and multi-screen experiences.
* Nearby Notifications is a new feature allowing developers to tie an app or website to a BLE beacon and create contextual notifications, even with no app installed.

Eddystone has the advantage of transmitting rich and strong data to your devices.
While iBeacon uses only one packet of identification,
Eddystone uses three different kinds – UID, URL and TIM.

* UID -
* URL - With this Eddystone URL, you can reach out to the Google Chrome
and Google Now users through the Physical Web functionality.
* TLM - With Eddystone TLM, you can get data on your Beacon, its battery level, packets sent, etc.

* [Chrome for Android Gets Support for Google's Eddystone Beacon Platform](http://gadgets.ndtv.com/apps/news/chrome-for-android-gets-support-for-googles-eddystone-beacon-platform-801234)
* [Google’s ‘open’ eddystone vs apple’s ibeacon – which one works better for you](https://www.whatech.com/development/press-release/254801-google-s-open-eddystone-vs-apple-s-ibeacon-which-one-works-better-for-you)

# UriBeacon
UriBeacon (pronounced YUR-ee-BEE-kun) is evolving to become part of the
[Eddystone open beacon format](https://github.com/google/eddystone)!

* [DIY Google's "Physical Web" UriBeacons with the Bluefruit LE Friend](https://learn.adafruit.com/google-physical-web-uribeacon-with-the-bluefruit-le-friend/getting-started)

# Physical Web Beacons
[!physical-web-logo](http://bkon.com/wp-content/uploads/2015/12/Physical-Web-Logo-Large-122915.png)
[Google has launched][06] the concept of the [Physical Web][04] in [Chrome][04],
on [Andriod phones][05],
and in their latest version of [Chrome for iOS][03]
The [Physical Web][01] offers a universal way to interact with any smart device,
a vending machine, a poster, a menu, a parking meter, a retail display
without first having to download an app, where everything is just a tap away.
For example, a user would approach a beacon installed in a museum,
and if the visitor’s mobile device is Physical-Web-enabled—if the service has been enabled
in the phone’s Chrome browser—a notification will appear in the phone’s notification tray
with a URL on which to click to learn more about the location.

The Physical Web is not shipping yet nor is it an official Google product.
This is an early-stage experimental project we're developing out in the open as we do all things related to the web.

[Physical Web Browsers][02], sometimes called Beacon Scanners,
these are the tools you use to access Eddystone-URL beacon content on the Physical Web.

Eddystone, iBeacon and Bluetooth certified

* [Meet Google’s “Eddystone”—a flexible, open source iBeacon fighter](http://arstechnica.com/gadgets/2015/07/meet-googles-eddystone-a-flexible-open-source-ibeacon-fighter/)
* [The Physical Web](https://google.github.io/physical-web/)

# Web Bluetooth
Web Bluetooth or [Web Bluetooth API][38]
is a developing JavaScript API to allow websites to communicate with Bluetooth devices.
Sites ask the browser to show a list of nearby Bluetooth devices matching certain criteria,
and the user either picks which to grant access to or cancels the dialog.
This group is developing a [specification for Bluetooth APIs][13] to allow websites
to communicate with devices in a secure and privacy-preserving way.

This new and experimental API, newly introduced into Chrome browsers,
pushes boundaries of beacon capabilities even further.
It allows a web page to interact directly with a Bluetooth device.
Pairing beacons with a beautiful website lets users experience the world around them as never before,
bridging the web, mobile and physical realms together via these low-energy Bluetooth-powered devices.

[The Web Bluetooth Security Model][14]
[Some believe Web Bluetooth represents a security risk][15].


# Raspberry Pi 3 as an Eddystone URL Beacon
* [Turn Your RPi 3 Into a BLE Beacon](http://hackaday.com/2016/03/27/turn-your-rpi-3-into-a-ble-beacon/)

# Raspberry Pi 3 as a Beacon Scanner
* [iBeacon Raspberry Pi Scanner in Python](http://www.switchdoc.com/2014/08/ibeacon-raspberry-pi-scanner-python/)
* [Beacon tracking with Node.js and Raspberry Pi](https://blog.truthlabs.com/beacon-tracking-with-node-js-and-raspberry-pi-794afa880318#.dpvrsy7gb)

# BlueZ - Linux Bluetooth Protocol Stack
[BlueZ][34] is a Bluetooth stack for Linux kernel-based family of operating systems.
Its goal is to program an implementation of the Bluetooth wireless standards specifications for Linux.
It was initially developed by Qualcomm,
and is available for Linux kernel versions 2.4.6 and up.
In addition to the basic stack, the bluez-utils and bluez-firmware packages
contain low level utilities such as dfutool which can interrogate the Bluetooth adapter chipset
to determine whether its firmware can be upgraded.

# Bluetooth Primer
* [Primer on Bluetooth Low Energy](http://hackaday.com/2013/08/29/primer-on-bluetooth-low-energy/)
* [How do iBeacons work?](http://www.warski.org/blog/2014/01/how-ibeacons-work/)
* [What is the iBeacon Bluetooth Profile](http://stackoverflow.com/questions/18906988/what-is-the-ibeacon-bluetooth-profile)
* [Hackaday Dictionary: Bluetooth Low Energy](http://hackaday.com/2015/12/02/hackaday-dictionary-bluetooth-low-energy/)
* [How to Build Low-Power Wireless Links for the Internet of Things Using Bluetooth 4.1](http://www.digikey.com/en/articles/techzone/2014/jun/how-to-build-low-power-wireless-links-for-the-internet-of-things-using-bluetooth-41)
* [The Physical Web vs. iBeacons vs. Eddystone vs. IoT](http://www.nanalyze.com/2016/03/the-physical-web-vs-ibeacons-vs-eddystone-vs-iot/)

# Bluetooth Alternatives
* [Bluetooth vs. Ant+ Revisited, Which Standard Wins?](http://www.sparxeng.com/blog/hardware/bluetooth-vs-ant-revisited-whic-standard-wins)
* [What’s The Difference Between Bluetooth Low Energy And ANT?](http://electronicdesign.com/mobile/what-s-difference-between-bluetooth-low-energy-and-ant)
* [Bluetooth Fights Back Against Thread](http://www.eetimes.com/document.asp?doc_id=1323126)

# Red Bear Lab BLE
* [RedBearLab Discussion forum](http://discuss.redbear.cc/)

There are [three options][25] to program your [BLE Nano with MK20 USB board][24]:

1. [Arduino Library for nRF51822](https://github.com/RedBear/nRF51822-Arduino)
    * Video Tutorial: [RedBear BLE Nano Quick Start with Arduino IDE](https://www.youtube.com/watch?v=d75strWav5k&feature=youtu.be)
1. [Nordic nRF51822 BLE SDK](https://developer.nordicsemi.com)
1. [mbed's Bluetooth Low Energy API](http://developer.mbed.org/teams/RedBearLab/)

While it is possible to upload firmware to a BLE Nano without using a MK20 USB board,
(via special debugger hardware [JLink][23]),
most instructions for the BLE Nano assumes you have a MK20 USB board by RedBearLab.

Nordic [nRF51822 SoC][21] supports Bluetooth low energy protocol stacks
and is built around a 32-bit ARM Cortex M0 CPU with 256kB/128kB flash + 32kB/16kB RAM
The embedded 2.4GHz transceiver supports both Bluetooth low energy
and the [Nordic Gazell 2.4 GHz protocol stack][22] which is on air compatible
with the nRF24L series products from Nordic Semiconductor.

[RedBear IoT pHAT provides both BLE and WiFi](https://redbear.cc/product/rpi/iot-phat.html),
designed for the Raspberry Pi Zero (other RPi boards with 40-pin header will also work).

[Bluefruit LE Friend - Bluetooth Low Energy (BLE 4.0) - nRF51822 - v2.0](https://www.adafruit.com/product/2267?gclid=CjwKEAiA1vjCBRDd-9q3w4OF6WUSJACWv_sVbsEecu1xm43PB7VQqLwQfFM2rZchpBigtlcFETwQkBoCASLw_wcB)




[01]:https://google.github.io/physical-web/
[02]:https://phy.net/physical-web-browsers/
[03]:https://www.youtube.com/watch?v=gxPcPXSE_O0
[04]:http://blog.chromium.org/2015/07/exploring-physical-web-with-chrome-for.html
[05]:https://play.google.com/store/apps/details?id=physical_web.org.physicalweb&hl=en
[06]:https://developers.google.com/beacons/?hl=en
[07]:https://github.com/google/eddystone/tree/master/configuration-service
[08]:http://cf.physical-web.org/
[09]:https://play.google.com/store/apps/details?id=no.nordicsemi.android.nrfbeacon.nearby
[10]:https://developers.google.com/nearby/
[11]:https://play.google.com/store/apps/details?id=no.nordicsemi.android.mcp
[12]:https://itunes.apple.com/us/app/nrf-connect/id1054362403
[13]:https://webbluetoothcg.github.io/web-bluetooth/
[14]:https://medium.com/@jyasskin/the-web-bluetooth-security-model-666b4e7eed2#.dwe6oco1t
[15]:http://hackaday.com/2016/09/23/web-bluetooth-the-new-hotness-and-its-dangers/
[16]:https://lacklustre.net/bluetooth/
[17]:https://www.bluetooth.com/specifications/generic-attributes-overview
[18]:https://www.youtube.com/watch?v=dYj6bpDzID0
[19]:https://lacklustre.net/bluetooth/outsmarting_bluetooth_smart-mikeryan-cansecwest_2014.pdf
[20]:https://www.bluetooth.com/
[21]:https://www.nordicsemi.com/eng/Products/Bluetooth-low-energy/nRF51822
[22]:https://devzone.nordicsemi.com/documentation/nrf51/4.1.0/html/index.html
[23]:https://www.adafruit.com/product/1369
[24]:https://redbear.cc/product/ble/ble-nano-kit.html
[25]:http://redbearlab.com/blenano/
[26]:https://www.bluetooth.com/specifications/generic-attributes-overview
[27]:https://www.bluetooth.com/specifications/adopted-specifications
[28]:https://www.bluetooth.com/specifications/profiles-overview
[29]:https://www.bluetooth.com/news/pressreleases/2016/12/07/bluetooth-5-now-available
[30]:https://www.youtube.com/watch?v=SynyKRkbLh8
[31]:http://www.connectblue.com/about-us/technologies/classic-bluetooth-technology/
[32]:https://www.youtube.com/watch?v=z6vQ43V4WxA
[33]:https://www.youtube.com/watch?v=gljeNbjym0o
[34]:http://www.bluez.org/
[35]:https://techcrunch.com/2014/11/20/seed-lab-creates-a-seamless-connection-between-you-and-your-kettle/
[36]:http://www.ledsmagazine.com/articles/print/volume-13/issue-3/features/smart-lighting/bluetooth-mesh-what-s-that-noise-about.html
[37]:http://rethinkresearch.biz/articles/bluetooth-5-0-debut-imminent-mesh-still-just-round-corner/
[38]:https://github.com/WebBluetoothCG/web-bluetooth
[39]:
[40]:
[41]:
[42]:
[43]:
[44]:
[45]:
[46]:
[47]:
[48]:
[49]:
[50]:
