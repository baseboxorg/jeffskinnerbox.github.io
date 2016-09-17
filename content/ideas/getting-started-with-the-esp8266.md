
Read this first:
* [ESP8266 Node MCU Setup](http://www.averagemanvsraspberrypi.com/2015/11/esp8266-node-mcu-setup.html)
* [Review: HUZZAH is the ESP8266 WiFi Setup You Need](http://hackaday.com/2015/05/01/review-huzzah-is-the-esp8266-wifi-setup-you-need/)
* [ESP8266 Adapter and Breakout Board Kit](http://store.hackaday.com/products/esp8266-adapter-and-breakout-board-kit-includes-esp8266-01)
* [Update: ESP8266 Breadboard Adapter Board](http://lookmanowire.blogspot.com/2016/04/update-esp8266-breadboard-adapter-board.html)
* [WIFI module ESP8266 for IoT](http://www.epanorama.net/newepa/2014/11/09/wifi-module-esp8266-for-iot/)
* [RS-232 vs. TTL Serial Communication](https://www.sparkfun.com/tutorials/215?_ga=1.132009867.562203984.1457131060)
* [Get Started With ESP8266 Using "AT Commands" Via Arduino](http://www.instructables.com/id/Get-Started-With-ESP8266-Using-AT-Commands-Via-Ard/?ALLSTEPS)
* [The Fundamentals of Wi-Fi Antennas](http://www.allaboutcircuits.com/technical-articles/wi-fi-antennas-part-1-fundamentals/)

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
    * [ESP8266 Reference](http://www.pighixxx.com/test/2015/06/esp8266-rev-1/)
    * [ESP8266 Quick Start](http://benlo.com/esp8266/esp8266QuickStart.html)
    * [Espressif Systems is the manufacter of the ESP8266](http://espressif.com/en/products/esp8266/)
    * [ESP8266 Documentation and Datasheet](https://nurdspace.nl/ESP8266)
    * [ESP8266 specifications](https://nurdspace.nl/images/e/e0/ESP8266_Specifications_English.pdf)
    * [Datasheet](https://nurdspace.nl/File:ESP8266_Specifications_English.pdf)
    * [ElectroDragon Wiki](http://www.electrodragon.com/w/Wi07c)
    * [ESP8266 Serial WIFI Module](http://wiki.iteadstudio.com/ESP8266_Serial_WIFI_Module)
    * [ESP8266 Community Forum](http://www.esp8266.com/)
    * [Hackaday Dictionary: The ESP8266](http://hackaday.com/2015/09/24/hackaday-dictionary-the-esp8266/)
    * [Ethernet Controller Discovered in the ESP8266](http://hackaday.com/2016/04/01/ethernet-controller-discovered-in-the-esp8266/)
    * []()
    * []()

* Toolchain and Development Boards
    * [Continuous Delivery for Your ESP8266](http://hackaday.com/2016/06/08/continuous-delivery-for-your-esp8266/)
    * [How to Directly Program an Inexpensive ESP8266 WiFi Module](http://hackaday.com/2015/03/18/how-to-directly-program-an-inexpensive-esp8266-wifi-module/)
    * [Building the toolchain](https://github.com/EspressifSystems/low_power_voltage_measurement)
    * [Update the Firmware in Your ESP8266 Wi-Fi Module](http://www.allaboutcircuits.com/projects/update-the-firmware-in-your-esp8266-wi-fi-module/)
    * [Upgrading the firmware in the flash of an ESP8266 module](http://www.xess.com/blog/esp8266-reflash/)
    * [Flashing New Firmware via UART](http://www.esp8266.com/viewtopic.php?f=6&t=33)
    * [The esptool.py site that contains information about uploading programs to the ESP8266 and alternative wiring schemes that can help with flashing](https://github.com/themadinventor/esptool/)
    * [Shows how to update the ESP8266 firmware](http://blog.electrodragon.com/cloud-updating-your-wi07c-esp8266-now/)
    * [change the module firmware via Raspberry Pi](http://www.extragsm.com/blog/2014/12/16/use-esp8266-module-as-a-wireless-switcher/)
    * [ESP8266 Basic](http://www.esp8266basic.com/)
    * [Arduino IDE Support for the ESP8266](http://hackaday.com/2015/03/28/arduino-ide-support-for-the-esp8266/)
    * [Seeed Studio's ESP8266 IoT SDK](http://www.seeedstudio.com/document/pdf/esp_iot_sdk_v0.6.zip)
    * [Building and Running MicroPython on the ESP8266](https://learn.adafruit.com/building-and-running-micropython-on-the-esp8266)
    * [Micro Python Now Runs on the ESP8266](http://hackaday.com/2014/11/29/micro-python-now-runs-on-the-esp8266-contributors-wanted-to-get-wifi-working/)
    * [MicroPython on the ESP8266: Kicking the Tires](http://hackaday.com/2016/07/21/micropython-on-the-esp8266-kicking-the-tires/)
    * [MicroPython tutorial for ESP8266](https://docs.micropython.org/en/latest/esp8266/esp8266/tutorial/index.html)
    * [Compiling Your Own Programs for the ESP8266/](http://hackaday.com/2014/12/08/compiling-your-own-programs-for-the-esp8266/)
    * [A Development Board for the ESP8266-03](http://www.limpkin.fr/index.php?post/2014/11/27/A-Development-Board-for-the-ESP8266-03)
    * [Hack allows ESP-01 to go to Deep Sleep](http://hackaday.com/2015/02/08/hack-allows-esp-01-to-go-to-deep-sleep/)
    * [Review: HUZZAH is the ESP8266 WiFi Setup You Need](http://hackaday.com/2015/05/01/review-huzzah-is-the-esp8266-wifi-setup-you-need/)
    * Using the Lua Programming Language
        * [Lua Programming Language](http://www.lua.org/)
        * [The.Lua.Tutorial](http://luatut.com/)
        * [eLua Project](http://www.eluaproject.net/)
        * [NodeMcu](http://nodemcu.com/index_en.html)
        * [NodeMcu - A Lua based firmware for wifi-soc esp8266](https://github.com/nodemcu/nodemcu-firmware)
        * [Burning LuaFirmware](http://importhack.wordpress.com/2014/11/22/how-to-use-ep8266-esp-01-as-a-sensor-web-client/)
        * [Flash tool for NodeMCU](https://github.com/nodemcu/nodemcu-firmware)
        * [IoT With Lua and NodeMCU](https://dzone.com/articles/iot-with-lua)
        * [A Small Collection of NodeMCU Lua Scripts](http://www.limpkin.fr/index.php?post/2016/04/17/A-Small-Collection-of-NodeMCU-Lua-Scripts-for-Data-Collection)
        * [GitHub - nodemcu/nodemcu-flasher](https://github.com/nodemcu/nodemcu-flasher)
        * [Command line interface for the ESP8266 module](https://www.npmjs.com/package/esp8266)
        * ESP8266 based web configurable wifi general purpose control [Part 1](http://www.instructables.com/id/ESP8266-based-web-configurable-wifi-general-purpos/?ALLSTEPS) and [Part 2](http://www.instructables.com/id/ESP8266-based-web-configurable-wifi-general-purpos-1/?ALLSTEPS)
    * [DIY ESP8266 Development Board](http://www.electro-labs.com/diy-esp8266-development-board/)

# Tools and Libraries
* [MQTT client library for ESP8266](https://github.com/tuanpmt/esp_mqtt)
* [Squash Your ESP-8266 Bugs with ESP-gdbstub](http://hackaday.com/2015/12/12/squash-your-esp-8266-bugs-with-esp-gdbstub/)
* [FreeRTOS-based framework for ESP8266 WiFi-enabled microcontrollers](https://github.com/SuperHouse/esp-open-rtos)
* [Websocket Client and Server for ESP-8266](https://github.com/morrissinger/ESP8266-Websocket)
    * [ESP8266+Websocket server RGB LED controller](http://www.instructables.com/id/Esp8266Websockets-RGB-LED-controller/?ALLSTEPS)
* []()

# Hacking the ESP8266
* [Your ESP8266 Needs More Memory](http://hackaday.com/2016/07/16/your-esp8266-needs-more-memory/)
* [Hacking a NRF24L01 Radio for Longer Range](http://hackaday.com/2015/08/15/hacking-a-nrf24l01-radio-for-longer-range/)

* Quick Start
    * [ESP8266 WiFi Module Quick Start Guide](http://rancidbacon.com/files/kiwicon8/ESP8266_WiFi_Module_Quick_Start_Guide_v_1.0.4.pdf)
    * [ESP8266 Quick Start](http://benlo.com/esp8266/esp8266QuickStart.html)

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
    * [Introduction to the MQTT Protocol on NodeMCU](http://www.allaboutcircuits.com/projects/introduction-to-the-mqtt-protocol-on-nodemcu/)
    * [Minimal MQTT: Networked Nodes](http://hackaday.com/2016/05/17/minimal-mqtt-networked-nodes/)
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
    * [ESP8266 - Easiest way to program so far (Using Arduino IDE)](http://www.whatimade.today/esp8266-easiest-way-to-program-so-far/)
    * [Quick Start to Nodemcu (ESP8266) on Arduino IDE](http://www.instructables.com/id/Quick-Start-to-Nodemcu-ESP8266-on-Arduino-IDE/?ALLSTEPS#intro)
    * [ESP8266 Now Working/Updated](http://scargill.wordpress.com/2014/10/05/esp8266-working/)
    * [Connect ESP8266 to Raspberry Pi](http://www.extragsm.com/blog/2014/12/03/connect-esp8266-to-raspberry-pi/)
    * [Connect the ESP8266 WiFi Chip to your Raspberry Pi](https://www.openhomeautomation.net/connect-esp8266-raspberry-pi/)
    * [REDUCING ESP8266 POWER CONSUMPTION USING DEEP SLEEP](http://tinker.yeoman.com.au/2015/03/08/reducing-esp8266-power-consumption-using-deep-sleep/)
    * [How to Make Two ESP8266 Talk](http://randomnerdtutorials.com/how-to-make-two-esp8266-talk/)
    * [ESP8266 Web Server Tutorial](http://randomnerdtutorials.com/esp8266-web-server/)

* Projects Making Use of the ESP8266
    * [ESP8266 weather station](http://dangerousprototypes.com/2015/11/30/esp8266-weather-station/)
    * [WiFi / Internet Controlled Relays using ESP8266 - Quick, 30 minutes IoT project](http://www.instructables.com/id/WiFi-Internet-Controlled-Relays-using-ESP8266-Quic/)
    * [ESP8266 IFTTT Easy Button](https://www.hackster.io/noelportugal/esp8266-ifttt-easy-button)
    * [Transparent ESP8266 WiFi-to-Serial Bridge](http://hackaday.com/2015/09/18/transparent-esp8266-wifi-to-serial-bridge/)
    * [Building a ESP8266 Client/Server Application](https://arduino-board.com/tutorials/esp8266)
    * [ESP8266 WiFi Access Point](https://arduino-board.com/tutorials/esp8266-ap)
    * [ESP8266 as an Access Point](http://scargill.wordpress.com/2014/10/08/esp8266-as-an-access-point/)
    * [ESP8266 for low power sensor applications](https://github.com/EspressifSystems/low_power_voltage_measurement)
    * [Accessing a web site with an ESP8266 serial WiFi module and an Arduino Mega 2560](http://hackaday.io/project/3072/instructions)
    * [Tutorial for ESP8266 Serial WiFi Module](https://www.zybuluo.com/kfihihc/note/31135)
    * [802.11 WIFI enabled RGB LED Strips, using the ESP8266](http://hackaday.io/project/3250-cypress-psoc-4-esp8266-ws2812-rgb-xmas-lights)
    * [Running a Web Server on the ESP8266](http://hackaday.com/2014/11/15/running-a-web-server-on-the-esp8266/)
    * [ESP8266 Web Server Farm](http://hackaday.com/2015/09/05/esp8266-web-server-farm/)
    * [Programming an Arduino remotely with the ESP8266 module](https://translate.google.com/translate?hl=en&sl=es&tl=en&u=http://www.sistemasorp.es/2014/11/11/programando-un-arduino-remotamente-con-el-modulo-esp8266/)
    * [Temp sensor connected to ESP8266 and upload data using MQTT](https://www.hackster.io/mtashiro/temp-sensor-connected-to-esp8266-and-upload-data-using-mqtt-5e05c9?utm_source=Hackster.io+newsletter&utm_campaign=20569a30e7-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-20569a30e7-140225889)
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
    * [Home Automation With the ESP8266: Build Home Automation Systems Using the Powerful and Cheap ESP8266 WiFi Chip Kindle Edition](http://www.amazon.com/Home-Automation-ESP8266-Systems-Powerful-ebook/dp/B00W9B3OOC/ref=sr_1_1?s=digital-text&ie=UTF8&qid=1442795120&sr=1-1&keywords=home+automation+using+esp8266&tag=rnwap-20)
    * [Primary IoT Make with NodeMcu ->ESP8266<-](http://www.seeedstudio.com/recipe/232-primary-iot-make-with-nodemcu-gt-esp8266-lt.html)
    * [A WiFI-enabled cord switch with the ESP8266 in 10 minutes](https://www.hackster.io/alinan/a-wifi-enabled-cord-switch-with-the-esp8266-in-10-minutes-6fa700?ref=newsletter&utm_source=Hackster.io+newsletter&utm_campaign=7fdf5fdbea-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-7fdf5fdbea-140225889)
    * [Kame, ESP8266 based quadruped](https://hackaday.io/project/9334-kame-esp8266-based-quadruped)
    * [Truly Versatile ESP8266 WiFi Webcam Platform](http://hackaday.com/2016/01/24/truly-versatile-esp8266-wifi-webcam-platform/)
    * [Webserver with NodeMCU/ESP8266 and DHT11](https://www.hackster.io/trimbitei/webserver-with-nodemcu-esp8266-and-dht11-5d4acf?utm_source=hackster&utm_medium=email&utm_campaign=new_projects)
    * [How to Make an Interactive TCP Server with NodeMCU on the ESP8266](http://www.allaboutcircuits.com/projects/how-to-make-an-interactive-tcp-server-nodemcu-on-the-esp8266/)
    * [ESP8266 IoT Energy Monitor](https://www.hackster.io/whatnick/esp8266-iot-energy-monitor-b199ed?utm_source=Hackster.io+newsletter&utm_campaign=bb289b34ff-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-bb289b34ff-140225889&mc_cid=bb289b34ff&mc_eid=9036129d51)
    * [ArduCAM for ESP8266 websocket camera demonstration](http://www.arducam.com/arducam-supports-esp8266-arduino-board-wifi-websocket-camera-demo/)
    * []()

* Power Management
    * [ESP8266: Turn Off WiFi - Reduce Current Big Time](https://www.hackster.io/rayburne/esp8266-turn-off-wifi-reduce-current-big-time-1df8ae?utm_source=Hackster.io+newsletter&utm_campaign=2f2ffd9fef-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-2f2ffd9fef-140225889&mc_cid=2f2ffd9fef&mc_eid=9036129d51)

## Alternatives
* [ESP8266 or MKR1000?](http://hackaday.com/2016/04/29/esp8266-or-mkr1000/)

## MicroPython
* [Video overview of MicroPython on ESP8266](https://www.youtube.com/watch?v=D-CaWFMFCV0)

## More
* [The Pain of Connecting to WPA Wi-Fi on the Linux Command Line](http://www.sevenforge.com/2009/07/28/connecting-to-wpa-wifi-on-the-command-line/)
* [NetworkConfigurationCommandLine/Automatic](https://help.ubuntu.com/community/NetworkConfigurationCommandLine/Automatic)
* [Wired Networking For The ESP8266](http://hackaday.com/2016/07/01/wired-networking-for-the-esp8266/)

## Next Generation / Next Version
* [Tiny $7 IoT module packs WiFi, BLE, and sensors, runs FreeRTOS](http://hackerboards.com/tiny-7-iot-module-packs-wifi-ble-and-sensors-runs-freertos/)
* [The ESP32 Has Been Released](http://hackaday.com/2016/09/05/new-part-day-the-esp32-has-been-released/)
* [Introduce ESP3212 WiFI Bluetooth Combo Module](http://www.seeedstudio.com/ESP3212-Wifi-Bluetooth-Combo-Module-p-2706.html?utm_source=mailchimp&utm_medium=edm&utm_campaign=new_0906)
* [Meet ESP32, New Big Brother to IoT Board ESP8266](http://makezine.com/2015/12/09/meet-esp32-new-big-brother-to-iot-board-esp8266/?utm_source=MakerPro+20151217&utm_medium=email&utm_term=&utm_content=image&utm_campaign=newsletter)
* [The ESP32 Beta Units Arrive](http://hackaday.com/2015/12/23/the-esp32-beta-units-arrive/)
* [Investigating the ESP8266–Serial Killing](http://scargill.wordpress.com/2014/09/27/investigating-the-esp8266-serial-killing/)
* [Espressif Releases ESP8266-Killer!](http://hackaday.com/2016/06/21/espressif-releases-esp8266-killer/)



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
