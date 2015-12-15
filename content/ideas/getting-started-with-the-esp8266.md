
Read this first:
[Review: HUZZAH is the ESP8266 WiFi Setup You Need](http://hackaday.com/2015/05/01/review-huzzah-is-the-esp8266-wifi-setup-you-need/)
[ESP8266 Adapter and Breakout Board Kit](http://store.hackaday.com/products/esp8266-adapter-and-breakout-board-kit-includes-esp8266-01)
[WIFI module ESP8266 for IoT](http://www.epanorama.net/newepa/2014/11/09/wifi-module-esp8266-for-iot/)

![ESP8266](http://www.seeedstudio.com/depot/bmz_cache/9/9f6470017d1ee80290eeddbe72d59d69.image.530x397.jpg "The ESP8266 offers a complete and self-contained WiFi networking solution, allowing it to either host the application or to offload all WiFi networking functions from another application processor.")
![ESP8266](/images/ESP8266.jpg "The ESP8266 offers a complete and self-contained WiFi networking solution, allowing it to either host the application or to offload all WiFi networking functions from another application processor.")

In early September 2014, I [became aware][04] of a new
(and potentially [game changing][01])
[WiFi transceiver breakout board with a ESP8266 SoC chip][21]
has appeared in the market from China for $7.
(**Note:** In [some places][06], you see this device refered to as the Wi07c.)
Initially, [not much is know about this chip][02]
but it does appear to have [TI CC3000][03] [like-functionality][05].

The ESP8266 has builtin TCP/IP using [LwIP][11],
supports the [802.11b/g/n standard][10],
[WiFi Direct (P2P)][12],
[SoftAP (aka virtual router)][13],
and it can operate in three modes: [AP, STA and AP+STA][14].

The ESP8266 has the potential to be a game changer
WiFi has always been expensive for small projects (e.g. Arduino Ethernet or WiFi board will cost you $35).

The [Espressif Systems ESP8266][08] has processing and storage capabilities that allow it to be
integrated with the sensors and other application specific devices.
It's a WiFi PCB with FLASH memory and a microcontroller (the ESP8266)
that takes care of all the WiFi, TCP/IP stack,
and the overhead found in an 802.11 network.
It’s addressable over SPI and UART,
so you can simply connect any microcontroller to this module and start pushing data.

There is a catch of course.
All the initial documentation, what little existed, was in Chinese,
but that has been rapidly changing.
Documentation and tools are appearing that will help one get started with this device.
Here is a reasonably robust list at the time of this posting:

# Different Types of ESP8266 PCB
* [ESP8266 modules hardware guide – gotta catch ’em all!](http://l0l.org.uk/2014/12/esp8266-modules-hardware-guide-gotta-catch-em-all/)

There are several types of ESP8266 modules floating around out there,
so to properly wire things up, you have to determine which your working with.
I have yet to find a good reference source to understand all the types but
a [Google search][09] will produce many examples.
You'll see model numbers with ESP-01, ESP-02, ESP-03, ....  ESP-11, ....
They have different antenna types, GPIO pin exposures, programmability, etc.
Several websites are attempting to capture information concerning the different
ESP8266 moduals ([here][15], [here][16], [here][17], [here][18]).
Below is what I have come to understand.

## ESP-01
<div style="float: left">
    <a href="http://www.xess.com/blog/esp8266-is-alive/">
        <img class="img-rounded" style="margin: 0px 8px" title="This shows you the differance between the older and newer ESP-01 moduals" alt="ESP-01" src="http://www.xess.com/static/media/uploads/blog/devbisme/2014-10-09/V080_V090.png" width="200" height="200">
    </a>
</div>
<div style="float: left">
    <a href="http://hackerspace.pbworks.com/w/page/88183850/ESP8266">
        <img class="img-rounded" style="margin: 0px 8px" title="This shows you the ESP-01 ESP8266 WiFi Module Pinout" alt="ESP-01" src="http://hackerspace.pbworks.com/f/1414572698/esp-01.png" width="200" height="200">
    </a>
</div>
This appears to be the most common ESP8266 modual compatable with breadboarding:

* 2x4 2.54 mm pitch header
* built-in PCB-printed antenna
* 2 GPIOs: GPOI0/2
* UART URXD/UTXD
* RESET and CH_PD (powerdown)
* VCC/GND
* 14.2 mm W x 14.2 mm L

The [Electrodragon ESP8266 page][07] shows the component layout and pin assignments
for the (older) V080 and (newer) V090 modules.
The presence of the small LEDs on the module indicates it's a V090.

## ESP-02
<div style="float: left">
    <a href="http://hackerspace.pbworks.com/w/page/88183850/ESP8266">
        <img class="img-rounded" style="margin: 0px 8px" title="This shows you the ESP-02 ESP8266 WiFi Module Pinout" alt="ESP-01" src="http://hackerspace.pbworks.com/f/1414572703/esp-02.jpg" width="200" height="200">
    </a>
</div>
A less common module with antenna connector, that may be compatible with breadboards:

* Dual 1x4 2.54 mm pitch header in DIP form factor
* built-in U-FL connector for external antenna
* 2 GPIOs: GPOI0/2
* UART URXD/UTXD
* RESET and CH_PD (powerdown)
* VCC/GND
* 14.7 mm W x 14.2 mm L

## ESP-03
<div style="float: left">
    <a href="http://hackerspace.pbworks.com/w/page/88183850/ESP8266">
        <img class="img-rounded" style="margin: 0px 8px" title="This shows you the ESP-03 ESP8266 WiFi Module Pinout" alt="ESP-01" src="https://raw.githubusercontent.com/esp8266/esp8266-wiki/master/images/esp-03.jpg" width="200" height="200">
    </a>
</div>
A SMT (Sufrace Mount Technology) module with all pins broken out to
castellated pads with built-in ceramic antenna:

* Dual 1x7 2 mm pitch castellated pads
* built-in ceramic antenna
* 7 GPIOs: GPOI0/2/12/13/14/15/18
* UART URXD/UTXD
* RESET and CH_PD (powerdown)
* VCC/GND
* 12.2 mm W x 17.4 mm L

# Building the ESP8266 Tool Chain
https://github.com/esp8266/esp8266-wiki/wiki/Toolchain

```bash
# install needed packages (as root)
```

A cross compiler is required to generates binaries for the ESP8266 on Ubuntu.
Crosstool-NG provides a system to build a complete toolchain for the cross compiler.

```bash
# install the Xtensa crosstool-NG (as local user)
```

```bash
# setting up the Espressif SDK
```

# List of ESP8266 AT Commands
[List of ESP8266 AT Commands](http://www.electrodragon.com/w/Wi07c#Commands)

# Wiring
>**Note** The ESP operates on 3.3 Volts, so connecting this module to the 5V pin, and you can kiss it good-by!

<div style="float: left">
    <a href="https://www.adafruit.com/datasheets/FT232_Model.pdf">
        <img class="img-rounded" style="margin: 0px 8px" title="FTDI Serial TTL-232 USB Cable Pin Out" alt="FTDI Serial Cable" src="/imgages/FTDI_Serial_TTL-232_USB_Cable_Pin_Out.jpg" width="200" height="200">
    </a>
</div>
[FTDI Serial TTL-232 USB Cable][19]
This is a USB to TTL serial cable, with a [FTDI FT232RL usb/serial chip][20] embedded in the head.
It has a 6-pin socket at the end with 5V power and ground, as well as RX, TX, RTS and CTS at 3V logic levels.

<div style="float: left">
    <a href="xxx">
        <img class="img-rounded" style="margin: 0px 8px" title="xxx" src="http://www.extragsm.com/blog/wp-content/uploads/2014/12/esp8266_pinout_h-569x236.png" width="200" height="200">
    </a>
</div>

<div style="float: left">
    <a href="xxx">
        <img class="img-rounded" style="margin: 0px 8px" title="xxx" src="http://www.extragsm.com/blog/wp-content/uploads/2014/12/WiFi-Serial-Transceiver-Module.jpg" width="200" height="200">
    </a>
</div>

* [Connect ESP8266 to Raspberry Pi](http://www.extragsm.com/blog/2014/12/03/connect-esp8266-to-raspberry-pi/)

# Sources
* News Articles
    * [New Chip Alert: The ESP8266 WiFi Module (It’s $5)](http://hackaday.com/2014/08/26/new-chip-alert-the-esp8266-wifi-module-its-5/)
    * [The Current State of ESP8266 Development](http://hackaday.com/2014/09/06/the-current-state-of-esp8266-development/)
    * [ESP8266 Distance Testing/](http://hackaday.com/2014/09/26/esp8266-distance-testing/)
    * [ESP Gets FCC and CE](http://hackaday.com/2014/12/17/esp-gets-fcc-and-ce/)

* Documentation
    * [ESP8266 Quick Start](http://benlo.com/esp8266/esp8266QuickStart.html)
    * [Espressif Systems is the manufacter of the ESP8266](http://espressif.com/en/products/esp8266/)
    * [ESP8266 Documentation and Datasheet](https://nurdspace.nl/ESP8266)
    * [ESP8266 specifications](https://nurdspace.nl/images/e/e0/ESP8266_Specifications_English.pdf)
    * [Datasheet](https://nurdspace.nl/File:ESP8266_Specifications_English.pdf)
    * [ElectroDragon Wiki](http://www.electrodragon.com/w/Wi07c)
    * [ESP8266 Serial WIFI Module](http://wiki.iteadstudio.com/ESP8266_Serial_WIFI_Module)
    * [ESP8266 Community Forum](http://www.esp8266.com/)

* Toolchain and Development Boards
    * [Building the toolchain](https://github.com/EspressifSystems/low_power_voltage_measurement)
    * [Upgrading the firmware in the flash of an ESP8266 module](http://www.xess.com/blog/esp8266-reflash/)
    * [Flashing New Firmware via UART](http://www.esp8266.com/viewtopic.php?f=6&t=33)
    * [The esptool.py site that contains information about uploading programs to the ESP8266 and alternative wiring schemes that can help with flashing](https://github.com/themadinventor/esptool/)
    * [Shows how to update the ESP8266 firmware](http://blog.electrodragon.com/cloud-updating-your-wi07c-esp8266-now/)
    * [change the module firmware via Raspberry Pi](http://www.extragsm.com/blog/2014/12/16/use-esp8266-module-as-a-wireless-switcher/)
    * [ESP8266 Basic](http://www.esp8266basic.com/)
    * [Arduino IDE Support for the ESP8266](http://hackaday.com/2015/03/28/arduino-ide-support-for-the-esp8266/)
    * [Seeed Studio's ESP8266 IoT SDK](http://www.seeedstudio.com/document/pdf/esp_iot_sdk_v0.6.zip)
    * [Micro Python Now Runs on the ESP8266](http://hackaday.com/2014/11/29/micro-python-now-runs-on-the-esp8266-contributors-wanted-to-get-wifi-working/)
    * [Compiling Your Own Programs for the ESP8266/](http://hackaday.com/2014/12/08/compiling-your-own-programs-for-the-esp8266/)
    * [A Development Board for the ESP8266-03](http://www.limpkin.fr/index.php?post/2014/11/27/A-Development-Board-for-the-ESP8266-03)
    * [Hack allows ESP-01 to go to Deep Sleep](http://hackaday.com/2015/02/08/hack-allows-esp-01-to-go-to-deep-sleep/)
    * [How to Directly Program an Inexpensive ESP8266 WiFi Module](http://hackaday.com/2015/03/18/how-to-directly-program-an-inexpensive-esp8266-wifi-module/)
    * [Review: HUZZAH is the ESP8266 WiFi Setup You Need](http://hackaday.com/2015/05/01/review-huzzah-is-the-esp8266-wifi-setup-you-need/)
    * Using the Lua Programming Language
        * [Lua Programming Language](http://www.lua.org/)
        * [The.Lua.Tutorial](http://luatut.com/)
        * [eLua Project](http://www.eluaproject.net/)
        * [NodeMcu](http://nodemcu.com/index_en.html)
        * [NodeMcu - A Lua based firmware for wifi-soc esp8266](https://github.com/nodemcu/nodemcu-firmware)
        * [Burning LuaFirmware](http://importhack.wordpress.com/2014/11/22/how-to-use-ep8266-esp-01-as-a-sensor-web-client/)
        * [Flash tool for NodeMCU](https://github.com/nodemcu/nodemcu-firmware)
        * [Command line interface for the ESP8266 module](https://www.npmjs.com/package/esp8266)
        * ESP8266 based web configurable wifi general purpose control [Part 1](http://www.instructables.com/id/ESP8266-based-web-configurable-wifi-general-purpos/?ALLSTEPS) and [Part 2](http://www.instructables.com/id/ESP8266-based-web-configurable-wifi-general-purpos-1/?ALLSTEPS)
    * [DIY ESP8266 Development Board](http://www.electro-labs.com/diy-esp8266-development-board/)

# Tools and Libraries
* [MQTT client library for ESP8266](https://github.com/tuanpmt/esp_mqtt)

* Tutorials
    * Video: [Hari Wiguna's "$3 WiFi Modual" YouTube Series](https://www.youtube.com/playlist?list=PL-xZsBalytNAFgyiDI8_lwXyeVE3R4hpx)
    * Video: Raspberry Pi + ESP8266
    [Demo](https://www.youtube.com/watch?v=ecnxMOie7PM),
    * [Using the ESP8266 as a Web-enabled sensor](http://hackaday.com/2014/11/23/using-the-esp8266-as-a-web-enabled-sensor/)
    [Wiring](https://www.youtube.com/watch?v=TkLOAvP5G1A&feature=em-uploademail),
    [NodeMCU](https://www.youtube.com/watch?v=dBcDw-7uiS0&feature=em-uploademail),
    [NodeJS](https://www.youtube.com/watch?v=pAEfXKABbI0&feature=em-uploademail)
    * Video: [5$ Arduino WiFi Module!? ESP8266 mini Tutorial/Review](https://www.youtube.com/watch?v=9QZkCQSHnko)
    * Video: [Cheap and Easy WiFi (IoT) Tutorial Part 1 - ESP8266](https://www.youtube.com/watch?v=qU76yWHeQuw)
    * Video: [ESP8266 AT Commands Tutorial (Wi-Fi Module)](https://www.youtube.com/watch?v=uznq8W9sOKQ)
    * Video: [Talking to an ESP8266 module using an FTDI USB-to-serial cable](http://www.xess.com/blog/esp8266-is-alive/)
    * [Tutorial for ESP8266 Serial WiFi Module](http://www.seeedstudio.com/wiki/WiFi_Serial_Transceiver_Module)
    * [Using the ESP8266 as a Web-enabled sensor](http://hackaday.com/2014/11/23/using-the-esp8266-as-a-web-enabled-sensor/)
    * [GitHub for ESP8266 Community Forum](https://github.com/esp8266)
    * [ESP8266 WiFi Module Library](https://hackaday.io/project/2879-esp8266-wifi-module-library)
    * [More AT Command Information Found](https://hackaday.io/project/2879/log/9300-more-at-command-information-found)
    * [P8266 GCC SDK](http://www.electrodragon.com/w/ESP8266_GCC_SDK)
    * [Using GCC to program the ESP8266](http://www.esp8266.com/viewtopic.php?f=9&t=19&sid=2bcffde786cfebbd3a1cfa422e7ffdbb)
    * [An SDK for the ESP8266 WiFi Chip/](http://hackaday.com/2014/10/25/an-sdk-for-the-esp8266-wifi-chip/)
    * [ESP8266 IoT SDK](http://www.seeedstudio.com/document/pdf/esp_iot_sdk_v0.6.zip)
    * [GCC Toolchain](https://github.com/esp8266/esp8266-wiki/wiki)
    * [Wi07c Documentation](http://www.electrodragon.com/w/Wi07c)
    * [ESP8266 IoT](http://www.electrodragon.com/w/ESP8266_IoT)
    * [Investigating the ESP8266–Serial Killing](http://scargill.wordpress.com/2014/09/27/investigating-the-esp8266-serial-killing/)
    * [ESP8266 Now Working/Updated](http://scargill.wordpress.com/2014/10/05/esp8266-working/)
    * [Connect ESP8266 to Raspberry Pi](http://www.extragsm.com/blog/2014/12/03/connect-esp8266-to-raspberry-pi/)
    * [REDUCING ESP8266 POWER CONSUMPTION USING DEEP SLEEP](http://tinker.yeoman.com.au/2015/03/08/reducing-esp8266-power-consumption-using-deep-sleep/)

* Projects Making Use of the ESP8266
    * [ESP8266 weather station](http://dangerousprototypes.com/2015/11/30/esp8266-weather-station/)
    * [WiFi / Internet Controlled Relays using ESP8266 - Quick, 30 minutes IoT project](http://www.instructables.com/id/WiFi-Internet-Controlled-Relays-using-ESP8266-Quic/)
    * [ESP8266 IFTTT Easy Button](https://www.hackster.io/noelportugal/esp8266-ifttt-easy-button)
    * [ESP8266 as an Access Point](http://scargill.wordpress.com/2014/10/08/esp8266-as-an-access-point/)
    * [ESP8266 for low power sensor applications](https://github.com/EspressifSystems/low_power_voltage_measurement)
    * [Accessing a web site with an ESP8266 serial WiFi module and an Arduino Mega 2560](http://hackaday.io/project/3072/instructions)
    * [Tutorial for ESP8266 Serial WiFi Module](https://www.zybuluo.com/kfihihc/note/31135)
    * [802.11 WIFI enabled RGB LED Strips, using the ESP8266](http://hackaday.io/project/3250-cypress-psoc-4-esp8266-ws2812-rgb-xmas-lights)
    * [Running a Web Server on the ESP8266](http://hackaday.com/2014/11/15/running-a-web-server-on-the-esp8266/)
    * [ESP8266 Web Server Farm](http://hackaday.com/2015/09/05/esp8266-web-server-farm/)
    * [Programming an Arduino remotely with the ESP8266 module](https://translate.google.com/translate?hl=en&sl=es&tl=en&u=http://www.sistemasorp.es/2014/11/11/programando-un-arduino-remotamente-con-el-modulo-esp8266/)
    * [Using the ESP8266 as a Web-enabled sensor](http://hackaday.com/2014/11/23/using-the-esp8266-as-a-web-enabled-sensor/)
    * [A Breakout Board for the ESP8266-03](http://hackaday.com/2014/11/28/a-breakout-board-for-the-esp8266-03/)
    * [Hacklet 25 – ESP8266 WiFi Module Projects](http://hackaday.com/2014/12/05/hacklet-25-esp8266-wifi-module-projects/)
    * [Test Your Signal with the WiFi Cup/](http://hackaday.com/2014/11/11/test-your-signal-with-the-wifi-cup/)
        * [Mapping WiFi Signals in 3 Dimensions](http://hackaday.com/2015/02/17/mapping-wifi-signals-in-3-dimensions/)
    * [Checking eMail with the ESP8266/](http://hackaday.com/2014/11/03/checking-email-with-the-esp8266/)
    * [An ESP8266 Based Smartmeter/](http://hackaday.com/2014/11/02/an-esp8266-based-smartmeter/)
    * [Keep an Eye on Your Fermenting Beer with Brewmonitor/](http://hackaday.com/2014/10/11/keep-an-eye-on-your-fermenting-beer-with-brewmonitor/)
    * [ESP8266 BASIC WiFi Thermostat is Child’s Play](http://hackaday.com/2015/11/28/basic-on-the-esp8266/)
    * [Making Something Useful With The ESP8266](http://hackaday.com/2015/01/05/making-something-useful-with-the-esp8266/)
    * [ESP8266 AND IOT: STREAMING SERIAL ACCELEROMETER DATA VIA MQTT](http://tinker.yeoman.com.au/2015/03/29/esp8266-and-iot-streaming-serial-accelerometer-data-via-mqtt/)
    * [An Amazon Dash-Like Button For The ESP8266](http://hackaday.com/2015/05/13/an-amazon-dash-like-button-for-the-esp8266/)
    * [ESP8266 Keeps An Eye On Your Batteries](http://hackaday.com/2015/05/24/esp8266-keeps-and-eye-on-your-batteries/)
    * [ESP8266 DIN 8-Channel Wifi Relay Controller](https://hackaday.io/project/6456-esp8266-din-8-channel-wifi-relay-controller)
    * [momentary push button supplies power to a ESP8266](http://hackaday.com/2015/07/24/alarm-notifies-the-office-when-the-coffee-is-ready/)
    * [Switch Mains Power with an ESP8266](http://hackaday.com/2015/04/19/switch-mains-power-with-an-esp8266/)
    * [Attiny85 DHT22 Temp/Humidity logger](http://www.esp8266.com/viewtopic.php?f=8&t=390)
    * [Tiny wi-fi robot](https://hackaday.io/project/6695-tiny-wi-fi-robot)

## More
* [The Pain of Connecting to WPA Wi-Fi on the Linux Command Line](http://www.sevenforge.com/2009/07/28/connecting-to-wpa-wifi-on-the-command-line/)
* [NetworkConfigurationCommandLine/Automatic](https://help.ubuntu.com/community/NetworkConfigurationCommandLine/Automatic)


[01]:http://127.0.0.1:8080/#Cheap%20WiFi%20Chips%20on%20the%20Edge
[02]:http://hackaday.com/2014/09/06/the-current-state-of-esp8266-development/
[03]:http://www.ti.com/lit/ds/symlink/cc3000.pdf
[04]:http://hackaday.com/2014/08/26/new-chip-alert-the-esp8266-wifi-module-its-5/
[05]:http://hackaday.com/2013/01/12/finally-ti-is-producing-simple-cheap-wifi-modules/
[06]:http://www.electrodragon.com/product/esp8266-wi07c-wifi-module/
[07]:http://www.electrodragon.com/w/Wi07c
[08]:http://espressif.com/en/products/esp8266/
[09]:https://www.google.com/search?q=ESP-07&oq=ESP-07&aqs=chrome..69i57j69i60l2.4990185j0j7&sourceid=chrome&es_sm=122&ie=UTF-8#tbm=shop&q=ESP8266+ESP
[10]:http://compnetworking.about.com/cs/wireless80211/a/aa80211standard.htm
[11]:http://lwip.wikia.com/wiki/LwIP_Wiki
[12]:http://www.techradar.com/us/news/phone-and-communications/mobile-phones/wi-fi-direct-what-it-is-and-why-you-should-care-1065449
[13]:http://en.wikipedia.org/wiki/SoftAP
[14]:http://wireless.kernel.org/en/users/Documentation/modes
[15]:http://hackerspace.pbworks.com/w/page/88183850/ESP8266
[16]:http://www.esp8266.com/viewtopic.php?f=5&t=28)
[17]:https://github.com/esp8266/esp8266-wiki/wiki/Hardware_versions
[18]:http://tminusarduino.blogspot.com/2014/09/experimenting-with-esp8266-5-wifi-module.html
[19]:https://www.adafruit.com/datasheets/FT232_Model.pdf
[20]:http://www.adafruit.com/datasheets/DS_FT232R.pdf
[21]:http://www.seeedstudio.com/depot/WiFi-Serial-Transceiver-Module-w-ESP8266-p-1994.html
[22]:
[23]:
[24]:
[25]:
[26]:
[27]:
[28]:
[29]:
[30]:
