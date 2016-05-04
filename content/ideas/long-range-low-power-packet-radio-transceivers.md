The technology allows things to talk to the Internet without 3G or WiFi.
It features low battery usage, long range and low bandwidth. Perfect for the Internet of Things.

Long-Range Low-Power - http://www.microchip.com/design-centers/wireless-connectivity/embedded-wireless/lora-technology

[LoRaWAN][01] (Long Range Wide Area Network) is a Low Power Wide Area Network (LPWAN)
specification intended for wireless battery operated Things in regional, national or global network.
It is a media access control (MAC) protocol for long range network
based on [LoRa][01] (Long Range) radio modulation technique.
In the OSI Reference Model, LoRa represent layer 1 (PHY), and LoRaWAN roughly maps to layers 2 and 3.
LoRaWAN networks use a star-of-stars topology in which gateways forward messages between nodes and applications in the backend. Nodes use a single-hop wireless connection to one or more gateways.
http://staging.thethingsnetwork.org/wiki/LoRaWAN/Overview

# Adiafruit Products
* [Adafruit RFM69HCW and RFM9X LoRa Packet Radio Breakouts](https://learn.adafruit.com/adafruit-rfm69hcw-and-rfm96-rfm95-rfm98-lora-packet-padio-breakouts/overview)
* [Adafruit Feather](https://www.adafruit.com/feather)

# SparkFun Products
* [ RFM69 Breakout](https://www.sparkfun.com/products/12775?utm_source=SparkFun+Customer+Newsletter&utm_campaign=4b8fa30c6c-April_29thNewsletter&utm_medium=email&utm_term=0_fa5287abaf-4b8fa30c6c-7212537)
    * [RFM69HCW Hookup Guide](https://learn.sparkfun.com/tutorials/rfm69hcw-hookup-guide?_ga=1.180264161.499251857.1461895311)
    * [LowPowerLab Hook Library](https://github.com/LowPowerLab/RFM69)
    * [Radiohead Library](http://www.airspayce.com/mikem/arduino/RadioHead/)

# Open Source Projects
* [The Things Network](http://thethingsnetwork.org/)
    * [Washington DC Region Things Network community](http://thethingsnetwork.org/c/washington/)

# XBee / ZigBee Projects
* [KappaIO - Open Source ZigBee Gateway Framework](https://kappa.io/)
    * [Quick Start Guide](https://kappa.io/quickstart)
    * [CC2531 USB Evaluation Module Kit](http://www.ti.com/tool/cc2531emk)

########################################

# low-power, long-range networks
Rules and spectrum allocations vary across the world,
but these lower frequencies gets inside buildings better and the use of ultra-narrowband
helps manage signal-to-noise problems at long range, allowing very low-power devices.
The downside is ultra-low data rates, and even further restricted downlink performance.
SigFox, for example, is intended as a wide-area public network,
with the other technologies available as either public or private networks.
Bandwidth restrictions cause some tough challenges for software updates and security,
but nonetheless, the technology is an interesting alternative for long-range, low-power deployments.

SIGFOX, LoRa, OnRamp, Link Labs, Weightless, SemtechNWave,  M2Communication, Coroni

# Weightless
Weightless has decided to pursue ultra-narrow-band (UNB) communication in the free-to-use ISM bands,
rather than ‘white space’ radio for its physical layer.
Around the world, agreements, legislation and infrastructure required to use white space radio
(communications in spare TV channels)
are not coming along quickly enough, and Weightless changes its strategy.

# Ultra-Narrow Band Radio

* [Understanding Ultra Narrowband Modulation][12]
* [Ultra Narrow Band Modulation Textbook][13]

# Sigfox
SIGFOX is a cellular style network operator that provides a tailor-made solution
for low-throughput Internet of Things and M2M applications to connect
using ultra-narrow band, UNB technology in the unlicensed ISM radio bands.
UNB technology enables very low transmitter power levels to be used
while still being able to maintain a robust data connection.

* Up to 140 messages per object per day
* Payload size for each message is 12 bytes
* Wireless throughput up to 100 bits per second
* SIGFOX radio link uses unlicensed ISM radio bands. Frequencies can vary according to national regulations, but in Europe the 868MHz band is widely used and in the US it is 915MHz.
* The density of the cells in the SIGFOX network is based on an average range of about 30-50km in rural areas and in urban areas where there are usually more obstructions and noise is greater the range may be reduced to between 3 and 10km. Distances can be much higher for outdoor nodes where SIGFOX states line of sight messages could travel over 1000km.

# LoRa
One of the major issues for machine to machine (M2M) communications
used for applications like the Internet of Things (IoT)
is to enable communications over long ranges using very low power levels.
One scheme for addressing this is known as [LoRa (Low Power Radio)][07].
A LoRa network can be arranged to provide coverage similar to that of a cellular network.
Many LoRa operators are cellular network operators who will be able to use existing masts to mount LoRa antennas.
In some instances the LoRa antennas may be combined with cellular antennas as the frequencies
may be close and combining antennas will provide significant cost advantages.

he LoRa modulation scheme at the heart of a LoRaWAN
was developed to solve challenges facing IoT applications that
needed wide area coverage as well as years-long battery life

A LoRaWAN network uses a star-of-stars topology with gateways serving as a
transparent bridge relaying messages between end-devices and a central network server.
Gateways connect to the network server via standard IP connections,
while end-devices use single-hop wireless communication to one or many gateways.
The structure is similar to a cellular telephony network,
and gateway devices will typically be installed on existing cellular towers,
but instead of providing a single, interconnected network,
the scheme allows multiple independent LoRaWANs to operate in a given geographic area.

[LoRa Alliance][06] is an open,
non-profit association of members whos mission to standardize Low Power Wide Area Networks (LPWAN)
being deployed around the world to enable Internet of Things (IoT), machine-to-machine (M2M),
and smart city, and industrial applications.
The Alliance members will collaborate to drive the global success of the LoRa protocol (LoRaWAN),
by sharing knowledge and experience to guarantee interoperability between operators in one open global standard.

* Long range: 15 - 20 km and the support of millions of nodes
* Long battery life: in excess of ten years
* LoRaWAN specification intended for wireless battery operated Things in regional, national or global network.
* LoRaWAN target key requirements of internet of things such as secure bi-directional communication, mobility, and localization services.
* This standard will provide seamless interoperability among smart Things without the need of complex local installations and gives back the freedom to the user, developer, businesses enabling the role out of Internet of Things.
* LoRaWAN network architecture is typically laid out in a star-of-stars topology in which gateways is a transparent bridge relaying messages between end-devices and a central network server in the backend.
* Gateways are connected to the network server via standard IP connections while end-devices use single-hop wireless communication to one or many gateways.
* All end-point communication is generally bi-directional, but also supports operation such as multicast enabling software upgrade over the air or other mass distribution messages to reduce the on air communication time.
* LoRaWAN data rates range from 0.3 kbps to 50 kbps. To maximize both battery life of the end-devices and overall network capacity, the LoRaWAN network server is managing the data rate and RF output for each end-device individually by means of an adaptive data rate (ADR) scheme.

![img](http://lora-alliance.org/portals/0/images/whatis/networkBW.png)



[01]:https://www.lora-alliance.org/What-Is-LoRa/Technology
[02]:
[03]:
[04]:
[05]:
[06]:http://lora-alliance.org/
[07]:http://www.radio-electronics.com/info/wireless/lora/basics-tutorial.php
[08]:
[09]:
[10]:
[11]:
[12]:http://mwrf.com/markets/understanding-ultra-narrowband-modulation
[13]:http://www.vmsk.org/Textbook.pdf

