
Read this first:
* [NodeMcu](http://nodemcu.com/index_en.html)
* [ESP8266 Node MCU Setup](http://www.averagemanvsraspberrypi.com/2015/11/esp8266-node-mcu-setup.html)
* [Getting started with the esp8266 (ESP-12e)](http://www.kloppenborg.net/blog/microcontrollers/2016/08/02/getting-started-with-the-esp8266)
* [Programming ESP8266 ESP-12E NodeMCU Using Arduino IDE - a Tutorial](http://www.instructables.com/id/Programming-ESP8266-ESP-12E-NodeMCU-Using-Arduino-/)
* [Getting Started with NodeMCU Board Powered by ESP8266 WiSoC](http://www.cnx-software.com/2015/10/29/getting-started-with-nodemcu-board-powered-by-esp8266-wisoc/)
* [ESP-LINK: Wifi-Serial Bridge w/REST&MQTT](https://github.com/jeelabs/esp-link)
* [Review: HUZZAH is the ESP8266 WiFi Setup You Need](http://hackaday.com/2015/05/01/review-huzzah-is-the-esp8266-wifi-setup-you-need/)
* [ESP8266 Adapter and Breakout Board Kit](http://store.hackaday.com/products/esp8266-adapter-and-breakout-board-kit-includes-esp8266-01)
* [Update: ESP8266 Breadboard Adapter Board](http://lookmanowire.blogspot.com/2016/04/update-esp8266-breadboard-adapter-board.html)
* [WIFI module ESP8266 for IoT](http://www.epanorama.net/newepa/2014/11/09/wifi-module-esp8266-for-iot/)
* [RS-232 vs. TTL Serial Communication](https://www.sparkfun.com/tutorials/215?_ga=1.132009867.562203984.1457131060)
* [Get Started With ESP8266 Using "AT Commands" Via Arduino](http://www.instructables.com/id/Get-Started-With-ESP8266-Using-AT-Commands-Via-Ard/?ALLSTEPS)
* [The Fundamentals of Wi-Fi Antennas](http://www.allaboutcircuits.com/technical-articles/wi-fi-antennas-part-1-fundamentals/)

* [ESP8266 PINOUT](http://www.pighixxx.com/test/portfolio-items/esp8266/)



![ESP8266](http://www.seeedstudio.com/depot/bmz_cache/9/9f6470017d1ee80290eeddbe72d59d69.image.530x397.jpg "The ESP8266 offers a complete and self-contained WiFi networking solution, allowing it to either host the application or to offload all WiFi networking functions from another application processor.")
![ESP8266](/images/ESP8266.jpg "The ESP8266 offers a complete and self-contained WiFi networking solution, allowing it to either host the application or to offload all WiFi networking functions from another application processor.")

In early September 2014, I [became aware][04] of a new
(and ultimately [game changing][01])
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

The ESP8266 has been a game changer since
WiFi has always been expensive for small projects (e.g. Arduino Ethernet or WiFi board will cost you $35).
Basicallyu, the ESP8266 is a serial to WiFi SoC built around a [Tensilica Xtensa LX3 processor][32].
The ESP8266 has the following specifications:

| Property        | Description |
|:---------------:|:------------:|
| Voltage         | 3.3 V (3.0 - 3.6 V tolerated) |
| Current         | 10 uA - 500 mA (64 mA average) |
| Processor       | Tensilica L106 32 bit |
| Processor Clock | 80-160MHz |
| RAM             | 32K + 80K (explained below) |
| Storage         | Flash memory, 16MB max (512 K - 4 MB often provided) |
| GPIOs           | 17 (multiplexed with other functions) |
| ADC             | 1 (10 bit) |
| WiFi            | 802.11 support b/g/n/d/e/i/k/r |
| TCP Connections | Max: 5 concurrent |

Depending on the particular board on which your ESP8266 microcontroller is mounted,
not all of these features may be exposed.

The [Espressif Systems ESP8266][08] has processing and storage capabilities that allow it to be
integrated with the sensors and other application specific devices.
It's a WiFi PCB with FLASH memory and a microcontroller (the ESP8266)
that takes care of all the WiFi, TCP/IP stack,
and the overhead found in an 802.11 network.
It’s addressable over SPI and UART,
so you can simply connect any microcontroller to this module and start pushing data.
A post by Richard Sloan declared that he and Ivan Grokhotkov had successfully
hacked ESP8266 support into the Arduino IDE.
Prior to Sloan and Grokhotkov’s software,
users had already noted that it could be programmed using basic modem instructions known as AT-commands.
Microcontrollers easily parse AT commands,
but they are not fun for humans to work with.
Developing an interface with more user-friendly programming language,
such as the C/C++ familiar to Arduino sketch programmers, is what made the ESP8266 vastly more popular.
The Espressif Systems ESP8266-01 lacks an FTDI chip,
which typically allows a board to have an external communication port like USB,
so you have to use a separate hardware interface such as the FTDI Friend to program it.

Thanks to these software improvements,
it’s easier than ever for people to create projects with the ESP8266 at the center of their design.
Small Arduino sketches run directly on the ESP8266
and shuttle data between the input pins and the WiFi connection.
Espressif Systems, the company that manufactures the ESP8266,
has been so receptive to feedback about their product
and is integrating much of the user community’s suggestions into the design.
The ESP32 is now entering a beta phase,
the new board is planned to have faster WiFi, onboard Bluetooth,
and two processors to handle the WiFi and code execution separately.

While the ESP8266 can’t do everything you could do with an Arduino.
For instance it only has one PWM pin,
but for $5 it’s a bargain.
The ESP8266 was already well on its way to becoming a popular DIY tool.
It’s super cheap, and easy to work with, and easy to get your hands on.

# Different Types of ESP8266 PCB
There are [several types of ESP8266 modules][29] floating around out there,
so to properly wire things up, you have to determine which your working with.
I have yet to find a good reference source to understand all the types but
a [Google search][09] will produce many examples.
You'll see model numbers with ESP-01, ESP-02, ESP-03, ....  ESP-11, ....
They have different antenna types, GPIO pin exposures, programmability, etc.
Several websites are attempting to capture information concerning the different
ESP8266 moduals ([here][15], [here][16], [here][17], [here][18]).

To date, the most important variants are the ESP-1 (the original release)
and the ESP-12E (the latest version as of this writing).
The main differentiation between these versions was not the microprocessor
(this has remained essentially unchanged),
but instead the number of ports exposed to the user.
For example, the ESP-1 has a total of eight pins connected to user-reachable headers,
two of which were used for power.
Whereas the ESP-12E has 22 pins.
All esp8266 boards appear to use the ESP8266EX module,
whose English datasheet can be found [here][30].
The ESP-12E WiFi Module data sheet is [here][31].

There are also ESP8266 PCBs that provide additional functionality and ease your development.
These include:

* [NodeMCU DevKit][34] for $9 with a [cheap CH340G][39] serial-to-USB interface
* [Adafruit HUZZAH][33] for $10 is similar to the NodeMCU DevKit but no USB to serial chip
* [Adafruit Feather HUZZAH][38] for $17 same as above with micro USB port for power, programming, and built in Lithium Polymer battery support/charging
* [ESPDuino][35] for $11 (an ESP8266 plus Arduino co-mounted to a PCB)
* [ESPressoLite][36] for $18
* [SparkFun ESP8266 Thing][37] for $16

The ESP8266 is designed for 3.3V,
but will tolerate input voltages from 3.0 to 3.6 V.
The ESP8266 consumes around 40 uA (micro-amps) when in sleep mode,
but can surge to nearly 500 mA when transmitting over WiFi.
Thus it is imperative that you connect a well-regulated power supply capable of meeting these demands.
(Some have suggested adding a 10 uF capacitor between the +3.3
and ground lines in order to smooth over sudden jumps in power consumption.)

Below is what I have begain to use.

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

* [Get Started With ESP8266 Using AT Commands, NodeMCU, or Arduino (ESP-12E)](http://www.instructables.com/id/Get-Started-with-ESP8266-Using-AT-Commands-NodeMCU/)

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

## ESP-12 / ESP-12E
The most important variants of the ESP8266 are the
ESP-1 (the original release) and the ESP-12E,
which is the latest version as of this writing.
The main differentiation between these versions was not the microprocessor
(this has remained essentially unchanged),
but instead the number of ports exposed to the user.
For example, the ESP-1 has a total of eight pins connected to user-reachable headers
(two of which were used for power), whereas the ESP-12E has 22 pins.

http://www.instructables.com/id/Getting-Started-with-the-ESP8266-ESP-12/
http://www.kloppenborg.net/blog/microcontrollers/2016/08/02/getting-started-with-the-esp8266

# Methods of Programming ESP8266
There are a variety of methods to program the ESP8266 including:

* AT Command (terminal)
* Official ESP8266 SDK and Toolchain
* NodeMCU with eLua
* Arduino IDE with C++
* FreeRTOS
* Mongoose OS
* PlatformIO

In all cases, you will be connecting to your board over a serial connection to start.
Most often, you will use some form of USB to serial adapter (that supports 3.3V TTL levels!).

FTDI Friend - https://learn.adafruit.com/ftdi-friend
USB-Serial Cable
Console Cable

## AT Commands
This method uses the ESP8266’s dedicated UART (serial communication) pins to
communicate with and program the microcontrollers.
Compared to the other programming methods, this technique is arcane,
but worth mentioning if you need to do some (very) low-level debugging.

The ESP8266 has three pins for (3.3 volt) serial communications.
There are two TX pins and one RX pin.
In order to interface your computer with these pins,
you will need to purchase a 3.3 volt USB-Serial Cable.
When the ESP8266 first boots,
the serial ports are configured at 74880 baud.
Some boards with built-in USB converters may use 9600 or 115200 baud instead.
Thus it is important to consult your board’s documentation.

* [List of ESP8266 AT Commands](http://www.electrodragon.com/w/Wi07c#Commands)
* [More AT Command Information Found](https://hackaday.io/project/2879/log/9300-more-at-command-information-found)
* [Get Started With ESP8266 Using "AT Commands" Via Arduino](http://www.instructables.com/id/Get-Started-With-ESP8266-Using-AT-Commands-Via-Ard/?ALLSTEPS)
* [Get Started With ESP8266 Using AT Commands, NodeMCU, or Arduino (ESP-12E)](http://www.instructables.com/id/Get-Started-with-ESP8266-Using-AT-Commands-NodeMCU/)

## ESP8266 SDK and Toolchain
The [ESP8266 SDK][43], sometimes call the "IoT SDK"
is an IoT application development platform developed by Expressif
(the manufacturers of the ESP8266 chip)
that includes basic platform and high-level application development examples.
The SDK comes in two variants called the “Non-OS SDK” and “RTOS SDK”.
Both of these are low-level, C SDKs with specialized timers
and other functionality that let you save power and maximize the performance of the device.

* **Non-OS SDK** requires you to use timers and callbacks to write software.
Although this programming setup is very power efficient,
it does introduces abstraction that make the program difficult to follow.
* **RTOS SDK** is based on [FreeRTOS][45].
You get a full multi-tasking operating system which uses “typical” methods of programming to implement desired functionality.

Expressif’s ["Getting Started Guide"][46]
explains how to use both of these methods in further detail.
Also check out these sources:

* [How to Directly Program an Inexpensive ESP8266 WiFi Module](http://hackaday.com/2015/03/18/how-to-directly-program-an-inexpensive-esp8266-wifi-module/)
* [Setting up the ESP8266 Open SDK](https://www.penninkhof.com/2015/03/esp8266-open-sdk/)
* [Install ESP8266 SDK toolchain on Linux](https://www.htlinux.com/install-esp8266-sdk-toolchain-on-linux-ubuntu-14-10-desktop/)
* [ESP8266 Firmware ToolChain](http://www.electrodragon.com/w/Category:ESP8266_Firmware_ToolChain)
* https://github.com/esp8266/esp8266-wiki/wiki/Toolchain

## Arduino IDE
* [ESP8266 - Easiest way to program so far (Using Arduino IDE)](http://www.whatimade.today/esp8266-easiest-way-to-program-so-far/)
* https://learn.adafruit.com/adafruit-huzzah-esp8266-breakout/using-arduino-ide
* [Programming the ESP8266 With the Arduino IDE in 3 Simple Steps](https://dzone.com/articles/programming-the-esp8266-with-the-arduino-ide-in-3)
* [Quick Start to Nodemcu (ESP8266) on Arduino IDE](http://www.instructables.com/id/Quick-Start-to-Nodemcu-ESP8266-on-Arduino-IDE/?ALLSTEPS)
* Arduino IDE + esp8266 board - https://retro.moe/2016/03/27/c64-remote-controller-nodemcu-vs-adafruit-huzzah-vs-sparkfun-thing-vs/
* http://www.electrodragon.com/w/ESP8266_Arduino
Quick Start to Nodemcu (ESP8266) on Arduino IDE - http://www.instructables.com/id/Quick-Start-to-Nodemcu-ESP8266-on-Arduino-IDE/

## eLua and NodeMCU
[!lua-logo](http://www.lua.org/images/lua.gif)
Lua is an interpreted programming languages (aka scripting language).
and is popular in game development and
designed to be simple, portable, to have a small footprint.
It can run on lots of embedded platforms, that do not have even operating systems,
and runs Lua on the “bare metal”.
If the processors has a C cross-compiler and about 64Kb of free RAM, it can run Lua.

You you can find some help learning the Lua language here:

* [Programming in Lua, Fourth Edition](https://www.amazon.com/exec/obidos/ASIN/8590379868/lua-start-20)
* [course notes based on the above book](http://www.dcc.ufrj.br/~fabiom/lua/)
* [Learn Lua in 15 minutes](https://coronalabs.com/learn-lua/)
* [Embeddable scripting with Lua](https://www.ibm.com/developerworks/library/l-lua/)
* [Lua Unofficial FAQ (uFAQ)](http://www.luafaq.org/)
* [The Lua language (v5.1) Cheat Sheet](http://thomaslauer.com/download/luarefv51.pdf)

Programming the ESP8266 with eLua and NodeMCU appears to be one of the easier methods.
One key benefit is that this technique gives you an interactive shell on the ESP8266
in which you can program and experiment with little chance of bricking the unit permanently.

In order to get started programming using this technique,
the first thing you need to do is flash the ESP8266 with the correct firmware.
The [documentation on flashing][47] indicates you can use either a Python utility called [esptool][40]
or you can use [NodeMCU Flasher][48] to program the chip.

* NodeMCU flasher is a firmware programmer for NodeMCU DEVKIT V0.9 - https://github.com/nodemcu/nodemcu-flasher
* https://learn.adafruit.com/adafruit-huzzah-esp8266-breakout/using-nodemcu-lua


* http://nodemcu.readthedocs.io/en/master/en/upload/

    ## Mongoose OS
An open source Operating System for microcontrollers: ESP32, ESP8266, STM32, TI CC3200.
It also claims to natively support Amazon AWS IoT integation,
over-the-air (OTA) updates, and remote device management.

https://mongoose-os.com/
[How to build an IoT project with Mongoose OS](https://opensource.com/article/17/3/mongoose-os-iot-development?sc_cid=70160000001290lAAA)

## PlatformIO
[!platfromio-logo](http://cdn.platformio.org/images/platformio-logo.17fdc3bc.png)
PlatformIO is an open source Integrated Development Environment (IDE) for IoT development

* [PlatformIO: An Alternative Arduino IDE](https://dzone.com/articles/platformio-iot-integrated-platform)
* [Arudino Development using PlatformIO IDE](http://davenewson.com/posts/2016/arudino-development-using-platformio-ide.html)
* [PlatformIO: Arduino on the SparkFun WRL-13678 (ESP8266)](http://blog.coria.com/platformio-arduino-on-the-sparkfun)
* [OTA: PlatformIO and ESP8266](http://tiestvangool.ghost.io/2017/01/12/ota-platformio-and-esp8266/)
* [Over-the-Air ESP8266 programming using PlatformIO](https://www.penninkhof.com/2015/12/1610-over-the-air-esp8266-programming-using-platformio/)
* [GETTING STARTED WITH PLATFORMIO AND ESP8266 NODEMCU](https://www.losant.com/blog/getting-started-with-platformio-esp8266-nodemcu)
* [PlatfromIO Documentation](http://docs.platformio.org/en/latest/)

* [GETTING STARTED WITH PLATFORMIO AND ESP8266 NODEMCU](https://www.losant.com/blog/getting-started-with-platformio-esp8266-nodemcu)
* PlatformIO open-source embedded development ecosystem
    * [1/3: PlatfomIO overview & compiling + uploading locally and on a Raspberry Pi](https://blog.openenergymonitor.org/2016/06/platformio/)
    * [2/3: Continuous testing and auto release binary generation using PlatformIO & TravisCI](https://blog.openenergymonitor.org/2016/06/auto-build-continuous-test-firmware/)
    * [3/3: Continuous Deployment (OTA to ESP8266)](https://blog.openenergymonitor.org/2016/06/esp8266-ota-update/)

## Travis CI
Travis CI is a hosted, distributed continuous integration service used to build
and test software projects hosted at GitHub.
Open source projects may be tested at no charge via travis-ci.org

* [Travis CI Embedded Builds with PlatformIO](https://docs.travis-ci.com/user/integration/platformio/)
* [Travis CI Documentation](https://docs.travis-ci.com/user/getting-started/)

* [Automate Arduino ESP8266 Testing with TravisCI](https://tzapu.com/automate-arduino-ide-esp8266-build-testing-travisci/)

# ESP-01
assuming at power up the Blue led flashed twice quickly and then flashes every second, this means it attempting to connect to your WiFi network. It should do this for about 30 seconds then if it can’t connect the flashing will stop and it will become it’s own access point on 192.168.4.1.

* https://www.itead.cc/wiki/ESP8266_Serial_WIFI_Module

* [Update the Firmware in Your ESP8266 Wi-Fi Module](https://www.allaboutcircuits.com/projects/update-the-firmware-in-your-esp8266-wi-fi-module/)
* [How to Flash ESP-01 Firmware to the Improved SDK v2.0.0](https://www.allaboutcircuits.com/projects/flashing-the-ESP-01-firmware-to-SDK-v2.0.0-is-easier-now/?utm_source=All+About+Circuits+Members&utm_campaign=498644bd29-EMAIL_CAMPAIGN_2017_03_23&utm_medium=email&utm_term=0_2565529c4b-498644bd29-270523833)
* [ESP8266 WiFi Module Quick Start Guide](http://rancidbacon.com/files/kiwicon8/ESP8266_WiFi_Module_Quick_Start_Guide_v_1.0.4.pdf)

# NodeMCU
[!nodemcu-logo](https://avatars1.githubusercontent.com/u/9865736?v=3&s=400)
While the ESP8266 chip has been very popular, its also been very difficult to use.
Most of the low cost modules are a challege to program,
don't have an onboard 500mA 3.3V regulator or level shifting.
The NodeMCU firmware and supporting hardware development kit.
The development kit is based on ESP8266,
and provides 10 GPIO each PWM, I2C, 1-Wire controled,
USB-TTL serial access, and FCC certifice WiFi.
It it uses a Nodejs style event-driven API for the WiFi network applicaitons.

[NodeMCU][22] is breadboard friendly, open source platform for the ESP8266 WiFi SoC with an interactive Lua instance
based on the ESP-12 module, programmable and powered via a micro USB port.
The term "NodeMCU" really refers to the firmware rather than the the hardware developement kits
(aka NodeMCU DevKit).
The firmware uses the Lua scripting language, based on [embedded Lua][24], [eLua Project][23].
It also uses other open source projects,
such as [lua-cjson][25] and [SPIFFS (SPI Flash File System)][26].

Give this is open source,
you'll find [muliple providers of NodeMCUs][41].
A comparison can be confusing since there are many different boards
but this artcle ["Comparison of ESP8266 NodeMCU development boards"][42]
does a reasonable job.

Source materials for NodeMCU
* [NodeMCU Home Page](http://www.nodemcu.com/index_en.html)
* [NodeMCU Firmware](https://github.com/nodemcu/nodemcu-firmware)
* [NodeMCU Flasher](https://github.com/nodemcu/nodemcu-flasher)
* [NodeMCU DevKit V1.0](https://github.com/nodemcu/nodemcu-devkit-v1.0)
* [NodeMCU Documentation](https://nodemcu.readthedocs.io/en/master/)

## NodeMCU v0.9, v1.0 and v2.0
If you purchase a NodeMCU board it’s important to know there
are [two official versions and a third less than offical][42]:

* NodeMCU v0.9 / v1 with ESP-12 module, USB to UART chip is ch340G,
and [nodemcu-devkit-v1](https://github.com/nodemcu/nodemcu-devkit) software
* NodeMCU v1.0 / v2 with ESP-12E module, USB to UART chip is CP2102,
and [nodemcu-devkit-v1](https://github.com/nodemcu/nodemcu-devkit-v1.0) software
* NodeMCU v3 with ESP-12E module, “version” invented by producer LoLin to signify minor improvements to the V2 boards (**not recommended**)

[!nodemcu-photo](http://www.cnx-software.com/wp-content/uploads/2015/10/NodeMCU_0.9_vs_NodeMCU_1.0_Large.jpg)

A complain about the NodeMCU v0.9 is that it takes the full width of a breadboard,
while NodeMCU v1.0 leaves room for jumper wires.
In the photo above. the NodeMCU v0.9 is left and v1.0 is on the right.

A popular version of the NodeMCU is manufactured by [HiLetgo][27]
easily obtainable via [Amazon][28], eBay, or other sources for around $8.79.
You'll find the boards pin out below:

ESP-12E Pin Out - http://www.kloppenborg.net/images/blog/esp8266/esp8266-esp12e-pinout.png
NodeMCU - http://www.kloppenborg.net/images/blog/esp8266/esp8266-node-mcu-pinout.png
(Images taken from [ESP8266 NodeMCU Arduino Killer](https://www.slideshare.net/roadster43/esp8266-nodemcu))

## Adafruit HUZZAH ESP8266 Breakout
The advantage of the [$9.95 Adafruit HUZZAH ESP8266 Breakout](https://www.adafruit.com/product/2471)
is that it comes with firmeware pre-installed,
but unlike the the standard  NodeMCU hardware, it doesn't have a USB interface.
The module comes pre-loaded with NodeMCU's Lua interpreter
([NodeMCU 0.9.5 build 20150318 / Lua 5.1.4][55]),
and since it doesn't have a USB connection,
you'll need to use a
[USB console cable](https://www.adafruit.com/product/954),
[FTDI Friend](https://www.adafruit.com/products/284),
or a [FTDI cable](https://www.adafruit.com/products/70)
to power and upload software to the HUZZAH ESP8266.
The [tutorial on the Adafruit HUZZAH ESP8266 breakout][55]
shows you how to use these cables.

http://hackaday.com/2015/05/01/review-huzzah-is-the-esp8266-wifi-setup-you-need/
https://learn.adafruit.com/adafruit-huzzah-esp8266-breakout/using-nodemcu-lua

### Accessing the Console on Adafruit's HUZZAH ESP8266 Breakout
Using one of the cables referanced above,
plug in the cable to the HUZZAH ESP8266 and your computer.
You will see a blue LED (near the WiFi antenna),
and a red LED,
quickly flash twice indicating the ESP8266 is up and running.
They will not stay lit.

Next, use a serial console program, such as `screen` on Linux,
access the HUZZAH ESP8266 console.

```bash
# access the console on the huzzah esp8266
sudo screen /dev/ttyUSB0 9600

# press the reset button on the huzzah esp8266
<press reset>
NodeMCU 0.9.5 build 20150318  powered by Lua 5.1.4
lua: cannot open init.lua
>
```

Notice the version number of the NodeMCU and Lua software.
The latest version of Lua can be found at the [Lua website][56]
but you need to load via the NodeMCU site.
We'll upgrade this later.

Now lets do a test command to see if Lua is working.

```
> print("Hello World")
Hello World
```

Now set the ESP8266 into WiFi client mode (aka station or STA)
run the scanner, and have it print out the available access points.
Type in the following script to do this is:

```lua
-- set to client mode
wifi.setmode(wifi.STATION)

-- print list of access point
function listap(t) -- (SSID : Authmode, RSSI, BSSID, Channel)
    print("\n"..string.format("%20s","SSID").."\tBSSID\t\t\t  RSSI\t\tAUTHMODE\tCHANNEL")
    for ssid,v in pairs(t) do
        local authmode, rssi, bssid, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
        print(string.format("%20s",ssid).."\t"..bssid.."\t  "..rssi.."\t\t"..authmode.."\t\t"..channel)
    end
end

-- do the access point scan
wifi.sta.getap(listap)
```

And you get the following output:

```
                SSID    BSSID                     RSSI          AUTHMODE        CHANNEL
               74LL5    48:5d:36:2e:ee:08         -34           3               1
          FiOS-DCJ9G    c8:a7:0a:95:7b:c4         -92           3               11
               W7JKF    f8:e4:fb:7c:7a:b1         -89           3               1
               SQLKL    18:1b:eb:b2:79:08         -85           4               1
    Download Virus 3    2c:30:33:50:b3:29         -82           3               6
```

You can connecting the HUZZAH ESP8266 to your WiFi access point.
We can connect to the access point with `wifi.sta.config` and `wifi.sta.connect`.
It will take a second or two to complete the connection,
and then you can query the module to ask the status with `wifi.sta.status()`.
When you get a 5 it means the connection is completed and DHCP successful.

```
> wifi.sta.config("74LL5","password")
> wifi.sta.connect()
> print(wifi.sta.status())
5
> print(wifi.sta.getip())
192.168.1.38    255.255.255.0   192.168.1.1
>
```

### Uploading Lua Scripts
The draw back of the examples above is that they all required you
the get into the Lua interpreter environment and hand type in each line.
Any large or complex script will require a better approach.
The Python script [`luatool`][52] doe this by give you easy uploading of any Lua-based script
into the NodeMCU flash memory.
(`luatool` is one of [several NodeMCU Lua script upload tools][61].)

First, clone the `luatool` on your devlopment envirnment:

```bash
# clone the luatool
cd ~/src
git clone https://github.com/4refr0nt/luatool.git

# put the tool in your PATH
cp ~/src/luatool/luatool/luatool.py ~/bin
```

With the `luatool` you can upload files via:
`luatool.py --port COM4 --src file.lua --dest main.lua --baud 9600 --restart --verbose`

* `--port` - `COM1`-`COM128`, default `/dev/ttyUSB0`
* `--baud` - baud rate, default 9600
* `--src` - source disk file, default `main.lua`
* `--dest` - destination flash file, default `main.lua`
* `--restart` - auto restart NodeMCU by sending `node.restart()` after file load
* `--verbose` - show debugging messages

If you want to upload and autoexecute file, add the option `--dofile`.
For example:

```lua
# upload lua script to main.lua and then then execute it
luatool.py --port /dev/ttyUSB0 --src file.lua --dest main.lua --baud 9600 --dofile
```

You can also upload scripts via TCP/IP if your NodeMCU is already accessible via TCP/IP
and the telnet server  `telnet_srv.lua` is running.
See typical telnet server  `telnet_srv.lua` [here][60].

If you use `--dest` option with parameter `init.lua`,
the NodeMCU will autostart `init.lua` after boot.
To prevent being stuck in boot loop,
full test using `--dest main.lua`, upload, and then execute via `dofile("main.lua")` first.

1. Disconnect any terminal program connected to you NodeMCU, and at command prompt type your `luatool.py` command.
1. Connect you terminal program and send command `node.restart()` (or you can use `--restart` option, when loading file init.lua)
1. after reboot you get
1. send command `dofile("main.lua")` (or you can use `--dofile` option, when loading file main.lua)

# Access NodeMCU File System and othe Commands
NodeMCU has a set rudimentary Lua file system tools you can use.
For example (see [here][62] for more information:

```lua
-- determines whether the specified file exists
if file.exists("device.config") then
    print("Config file exists")
end

-- rename a file
file.rename("oldname.lua", "newname.lua")

-- erease a file
file.remove("foo.lua")

-- format the file system and erase all files
file.format()
```

Also, you may need to restart your NodeMCU and other things:

```lua
-- restart the nodemcu but doesn't drop wifi
node.restart()

-- disconnect wifi and turn off to save power
wifi.sta.disconnect()
wifi.setmode(wifi.NULLMODE)
```

To list the contents of a file system:

```lua
-- list all the files in the file system
l = file.list();
print("File Name\t\tBytes")
for k,v in pairs(l) do
    print(k, "\t", v)
end

-- get file system info
remaining, used, total=file.fsinfo()
print("\nFile system info:\n\tTotal : "..total.." (k)Bytes\n\tUsed : "..used.." (k)Bytes\n\tRemain: "..remaining.." (k)Bytes\n")
```

### init.lua
With `luatool` you can upload to any script on the NodeMCU,
but generally, you will be uploading a file called [`init.lua`][58].
If NodeMCU finds an `init.lua` in the root of the file system,
it will execute it as part of the boot sequence (standard Lua feature).
Hence, your application is initialized and triggered from  `init.lua`.

A good programming style is to use the file `init.lua` as an
init script where you register the different applications modules (i.e. files).
So edit your `init.lua` to look something like this:

```lua
dofile("main.lua")
dofile("wifi.lua")
dofile("httpserver.lua")
```

But there is a danger in uploading your `init.lua` like this.
If there's a bug in your `init.lua` you may be stuck in an infinite reboot loop.
Therefore, it could be wise to build a small delay into your startup sequence
that would allow you to interrupt the sequence by deleting or renaming `init.lua`.
Here is a good starting point for creating your own `init.lua`
(see [here][58] and [here][59]):

**UPDATE WITH init-test.lua**
```lua
-- load credentials, 'SSID' and 'PASSWORD' declared and initialize in there
dofile("credentials.lua")

function startup()
    if file.open("init.lua") == nil then
        print("init.lua deleted or renamed")
    else
        print("Running")
        file.close("init.lua")
        -- the actual application is stored in 'application.lua'
        -- dofile("application.lua")
    end
end

print("Connecting to WiFi access point...")
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID, PASSWORD)
-- wifi.sta.connect() not necessary because config() uses auto-connect=true by default
tmr.create():alarm(1000, tmr.ALARM_AUTO, function(cb_timer)
    if wifi.sta.getip() == nil then
        print("Waiting for IP address...")
    else
        cb_timer:unregister()
        print("WiFi connection established, IP address: " .. wifi.sta.getip())
        print("You have 3 seconds to abort")
        print("Waiting...")
        tmr.create():alarm(3000, tmr.ALARM_SINGLE, startup)
    end
end)
```

Check [NodeMCU Documentation][57] for the details on what functions are available to you,
as well as [Lua Org site][56] to learn more about the Lua scripting language

# FreeRTOS
The developer of the ESP8266, Espressif, has also created a ESP8266 SDK based on [FreeRTOS][63]
called [ESP8266_RTOS_SDK][64].
There is also a community developed fork (sponsored by [SuperHouse Automation][66])
called [esp-open-rtos][65] but claims to be
substantially different from the Espressif version.
Off hand, this community version appears better documented and supported.

* [FreeRtos on Esp8266](http://correderajorge.github.io/Esp8266-FreeRtos/)
* [ESP8266 FreeRTOS Introduction](http://www.nefastor.com/esp8266-freertos-introduction/)
* [ESP8266 FreeRTOS SDK – blinking LED example](http://www.pratikpanda.com/esp8266-blinking-led-example/)
* [ESP8266 FreeRTOS Test](https://blog.the-jedi.co.uk/2015/02/14/esp8266-freertos-test/)
* [Setting Up FreeRTOS on Arduino](https://exploreembedded.com/wiki/Setting_Up_FreeRTOS_on_Arduino)
* [Using FreeRTOS multi-tasking in Arduino](https://www.hackster.io/feilipu/using-freertos-multi-tasking-in-arduino-ebc3cc)
* [Tiny $7 IoT module packs WiFi, BLE, and sensors, runs FreeRTOS](http://linuxgizmos.com/tiny-7-iot-module-packs-wifi-ble-and-sensors-runs-freertos/)

# ESP8266 Surveillance Camera
I have been exploring and experiment ways to make a simple spy camera
that could be be battery powered and dropped almost anywhere.

* ESP8266 Camera
    * [JPEG camera + ESP8266](http://www.roboremo.com/jpeg-camera--esp8266.html)
    * [Truly Versatile ESP8266 WiFi Webcam Platform](http://hackaday.com/2016/01/24/truly-versatile-esp8266-wifi-webcam-platform/)
    * [ArduCAM now Supports ESP8266 Arduino Board with WIFI Websocket Camera Demo](http://www.arducam.com/arducam-supports-esp8266-arduino-board-wifi-websocket-camera-demo/)
    * [The GotchaCAM Portable DIY Wifi Camera Based Travel and Home Security and Surveillance System](http://www.arducam.com/)
    * [GitHub for ArduCAM](https://github.com/ArduCAM)


### NodeMCU Applications
There are several repositories that contains coding examples and application programs
that run on the NodeMCU firmware.
These are a great source for ideas and solutions to your application needs.
Here are some of them:

* [NodeMCU - Applications](https://github.com/ckuehnel/NodeMCU-applications)
* [NodeMCU Wikipedia Page](https://en.wikipedia.org/wiki/NodeMCU)
* [NodeMCU Website](http://nodemcu.com/index_en.html)
* [Nefastor Online](http://www.nefastor.com/)
* [Domoticz ESP8266 WiFi Module Wiki](https://www.domoticz.com/wiki/ESP8266_WiFi_module)
* [Programming the ESP8266 With Lua](https://learn.adafruit.com/diy-esp8266-home-security-with-lua-and-mqtt/programming-the-esp8266-with-lua)

## Adafruit Feather HUZZAH with ESP8266 WiFi
You'll find Adafruit's Feather HUZZAH ESP8266 Breakout
on the high end of the price list
([$16.96 directly from Adafruit](https://www.adafruit.com/product/2821)),
you get an 80 MHz microcontroller with 3.3V logic,
a full WiFi stack and a battery connector for added portability.
Of all the ESP8266-based boards available,
this is one of the best in terms of intuitive setup and thorough [instructions and documentation][54].


##########################################################
If you want to build custom NodeMCU firmware for the ESP8266 (Wikipedia) I suggest you don't build it yourself but have it built by this configurable service.
https://nodemcu-build.com/index.php
##########################################################


## NodeMCU DevKit
* [NodeMCU DevKit][34] for $9 with a [cheap CH340G][39] serial-to-USB interface
The documentation on [NodeMCU.com](http://nodemcu.com/index_en.html)
is not really that useful to get started.
I found [NodeMCU Firmware Wiki](https://github.com/nodemcu/nodemcu-firmware/wiki)
more useful and provides more details.

http://www.cnx-software.com/2015/10/29/getting-started-with-nodemcu-board-powered-by-esp8266-wisoc/#installing-firmware-and-accessing-the-console-on-nodemcu

https://github.com/nodemcu/nodemcu-firmware
https://github.com/nodemcu/nodemcu-firmware/releases

Flashing the NodeMCU firmware on the ESP8266 (Linux) - Guide - http://www.whatimade.today/flashing-the-nodemcu-firmware-on-the-esp8266-linux-guide/

NodeMCU Documentation - https://github.com/nodemcu/nodemcu-firmware/wiki
nodemcu-devkit-v1.0 - https://github.com/nodemcu/nodemcu-devkit-v1.0
nodemcu-firmware - https://github.com/nodemcu/nodemcu-firmware

There are a variety of methods available to program (aka flash) the ESP8266.
A list of the options are:

* [**esptool.py**][40] - a Python utility to communicate with the ROM bootloader. It is simple and platform agnostic. This is my personal preference as it is open source and well documented.
* [**esptool-ck**][49] - a C program to create firmware files for and flash the ESP8266 chips using a serial port. It is also platform agnostic and open source. It supports a variety of boards and has decent documentation.
* [**nodemcu-flasher**][48] - a GUI application which is designed specifically for the NodeMCU board. It is very easy to use, open source, and reasonably well documented.
* **Over the Air** - there are various methods to download a new firmware image from Internet and flash the chip live. One example can be found in the [ESP8266 Arduino Core project][50] and there are [methods for NodeMCU][51] as well.

The [`esptool`][40] is a Python-based, open source, platform independent,
utility to communicate with the ROM bootloader in Espressif ESP8266.
I think it is not needed if you use the Arduino IDE, but it is a handy tool.
To install it do:

```bash
cd ~/src
git clone https://github.com/espressif/esptool
cd esptool
python setup.py install
```

Download the latest firmware @ https://github.com/nodemcu/nodemcu-firmware/releases.
There are both float and integer versions, but since I just wanted to toggle GPIOs,
I downloaded the integer version:

```bash
wget https://github.com/nodemcu/nodemcu-firmware/releases/download/0.9.6-dev_20150704/nodemcu_integer_0.9.6-dev_20150704.bin
```

Flash the firmware

```bash
sudo python ./esptool.py --port /dev/ttyUSB0 write_flash 0x00000 ../nodemcu_integer_0.9.6-dev_20150704.bin
[sudo] password for jaufranc:
Connecting...
Erasing flash...
Writing at 0x00048000... (65 %)
```

and once it is successful:

```
Wrote 450560 bytes at 0x00000000 in 44.3 seconds (81.3 kbit/s)...

Leaving...
```

To fully erase your firmware, you may use the command below where "serial-port-of-ESP8266" may vary:

```bash
esptool.py --port <serial-port-of-ESP8266> erase_flash
```

The firmware flash will take a little bit of time,
but once its done you can connect to the ESP8266 by starting up a serial console like this:

```bash
screen /dev/ttyUSB0 9600
```

Now reboot the board using the rest switch.
If all goes well, you should be greeted by a Lua prompt like the following:

```
NodeMCU 0.9.6 build 20150704 powered by Lua 5.1.4 lua: cannot open init.lua
>
```

If you get some jibberish text,
try changing the baud setting in the call to screen (I used 9600 baud above).

After this, you can proceed to write code following
the instructions found in the [NodeMCU Documentation][53].

>Keep in mind that the ESP8266 needs to be [put into flash mode][44] before you can flash a new firmware!

* [Flashing the NodeMCU firmware on the ESP8266 (Linux) - Guide](http://www.whatimade.today/flashing-the-nodemcu-firmware-on-the-esp8266-linux-guide/)
* [The esptool.py site that contains information about uploading programs to the ESP8266 and alternative wiring schemes that can help with flashing](https://github.com/themadinventor/esptool/)
* Flashing the Firmware - https://nodemcu.readthedocs.io/en/master/en/flash/






# WiFi Management Without Hard Coding
* [Configure ESP8266 Wifi with WiFiManager](http://hackaday.com/2017/03/18/configure-esp8266-wifi-with-wifimanager/)
* [Avoid Hard-Coding WiFi Credentials on Your ESP8266 Using the WiFiManager Library](http://www.instructables.com/id/Avoid-Hard-Coding-WiFi-Credentials-on-Your-ESP8266/)
* [ESP8266 WiFi Configuration Library](https://tzapu.com/esp8266-wifi-connection-manager-library-arduino-ide/)

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
    * [How to Make Two ESP8266 Talk](http://randomnerdtutorials.com/how-to-make-two-esp8266-talk/)
    * [ESP8266 Web Server Tutorial](http://randomnerdtutorials.com/esp8266-web-server/)


* Projects Making Use of the ESP8266
    * [WarWalking With The ESP8266](http://hackaday.com/2016/10/23/warwalking-with-the-esp8266/)
    * [ESP8266 Mini Sniff - ESP8266 running in promiscuous mode which will display Device and Access Point MAC, RSSI, SSID, and channel](https://www.hackster.io/rayburne/esp8266-mini-sniff-f6b93a?utm_source=Hackster.io+newsletter&utm_campaign=6bc13bcfac-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-6bc13bcfac-140225889&mc_cid=6bc13bcfac&mc_eid=9036129d51)
    * [Easy Alexa (or Echo) Control of your ESP8266 Huzzah](https://learn.adafruit.com/easy-alexa-or-echo-control-of-your-esp8266-huzzah)
    * [Alexa, Make My ESP8266 Do Something](http://hackaday.com/2016/11/23/alexa-make-my-esp8266-do-something/)
    * [ESP8266 weather station](http://dangerousprototypes.com/2015/11/30/esp8266-weather-station/)
    * [NodeMCU Weather Widget](https://www.youtube.com/watch?v=NnS7sFmU-c4)
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

* ESP8266 Camera
    * [ArduCAM now Supports ESP8266 Arduino Board with WIFI Websocket Camera Demo](http://www.arducam.com/arducam-supports-esp8266-arduino-board-wifi-websocket-camera-demo/)
    * [Truly Versatile ESP8266 WiFi Webcam Platform](http://hackaday.com/2016/01/24/truly-versatile-esp8266-wifi-webcam-platform/)
    * [The GotchaCAM Portable DIY Wifi Camera Based Travel and Home Security and Surveillance System](http://www.arducam.com/)

* ESP8266 Controlled Plug / Receptacle
    * [First IoT device - Plug](https://myesp8266.blogspot.com/2015/04/first-iot-device.html?spref=pi)
    * [WiFi Power Bar!](http://hackaday.com/2017/03/04/wifi-power-bar/)
    * [Switch Mains Power with an ESP8266](http://hackaday.com/2015/04/19/switch-mains-power-with-an-esp8266/)

* Power Management
    * [ESP8266: Turn Off WiFi - Reduce Current Big Time](https://www.hackster.io/rayburne/esp8266-turn-off-wifi-reduce-current-big-time-1df8ae?utm_source=Hackster.io+newsletter&utm_campaign=2f2ffd9fef-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-2f2ffd9fef-140225889&mc_cid=2f2ffd9fef&mc_eid=9036129d51)
    * [REDUCING ESP8266 POWER CONSUMPTION USING DEEP SLEEP](http://tinker.yeoman.com.au/2015/03/08/reducing-esp8266-power-consumption-using-deep-sleep/)
    * [Hack allows ESP-01 to go to Deep Sleep](http://hackaday.com/2015/02/08/hack-allows-esp-01-to-go-to-deep-sleep/)
    * [Low Power ESP8266 – Sleeping at 78 micro Amps](http://tim.jagenberg.info/2015/01/18/low-power-esp8266/)
    * [ESP8266 Lullaby](http://hackaday.com/2016/11/11/esp8266-lullaby/)
    * [ESP8266_PIRv2 - ESP8266 Huzzah Deep Sleep Mode PIR Motion Alarm using IFTTT](https://github.com/rgrokett/ESP8266_PIRv2)
        * [Passive infrared (PIR) sensor tutorial](https://hackaday.com/2009/08/21/passive-infrared-pir-sensor-tutorial/)

## Alternatives
* [ESP8266 or MKR1000?](http://hackaday.com/2016/04/29/esp8266-or-mkr1000/)

## MicroPython
* [Video overview of MicroPython on ESP8266](https://www.youtube.com/watch?v=D-CaWFMFCV0)

## More
* [The Pain of Connecting to WPA Wi-Fi on the Linux Command Line](http://www.sevenforge.com/2009/07/28/connecting-to-wpa-wifi-on-the-command-line/)
* [NetworkConfigurationCommandLine/Automatic](https://help.ubuntu.com/community/NetworkConfigurationCommandLine/Automatic)
* [Wired Networking For The ESP8266](http://hackaday.com/2016/07/01/wired-networking-for-the-esp8266/)
* [Overhauling The ESP8266’s Flash Memory Handling](http://hackaday.com/2016/09/09/overhauling-the-esp8266s-flash-memory-handling/)

## Next Generation / Next Version
* [The ESP32 Has Been Released](http://hackaday.com/2016/09/05/new-part-day-the-esp32-has-been-released/)
* [ESP32 Tutorials](http://hackaday.com/2017/03/01/esp32-tutorials/)
* [Tiny $7 IoT module packs WiFi, BLE, and sensors, runs FreeRTOS](http://hackerboards.com/tiny-7-iot-module-packs-wifi-ble-and-sensors-runs-freertos/)
* [Introduce ESP3212 WiFI Bluetooth Combo Module](http://www.seeedstudio.com/ESP3212-Wifi-Bluetooth-Combo-Module-p-2706.html?utm_source=mailchimp&utm_medium=edm&utm_campaign=new_0906)
* [Meet ESP32, New Big Brother to IoT Board ESP8266](http://makezine.com/2015/12/09/meet-esp32-new-big-brother-to-iot-board-esp8266/?utm_source=MakerPro+20151217&utm_medium=email&utm_term=&utm_content=image&utm_campaign=newsletter)
* [The ESP32 Beta Units Arrive](http://hackaday.com/2015/12/23/the-esp32-beta-units-arrive/)
* [Investigating the ESP8266–Serial Killing](http://scargill.wordpress.com/2014/09/27/investigating-the-esp8266-serial-killing/)
* [Espressif Releases ESP8266-Killer!](http://hackaday.com/2016/06/21/espressif-releases-esp8266-killer/)
* [ESP32 Hands-On: Awesome Promise](http://hackaday.com/2016/09/15/esp32-hands-on-awesome-promise/)
* [What’s New, ESP-32? Testing the Arduino Library](http://hackaday.com/2016/10/31/whats-new-esp-32-testing-the-arduino-esp32-library/)
* [Enginursday: Creating a Smart Water Sensor with the ESP32 Thing](https://www.sparkfun.com/news/2297?hsCtaTracking=c1619558-8d91-43e0-8b4c-3a9d22b42e0f|07a7f713-13a2-4501-9a18-5bb50c76d43c&utm_campaign=February+10,+2017&utm_medium=email&_hsenc=p2ANqtz-87cMS3CKRMD8SzEWleLTBH5bJOX61fDO5cLB9DGcjLKMbIn7t5Fg60eL_Lcb2xM5qXOWkJmN8IU1LQGErjVXK39wjpUw&_hsmi=42356669&utm_content=42357056&utm_source=hs_email)



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
[22]:http://nodemcu.com/index_en.html
[23]:http://www.eluaproject.net/
[24]:http://www.eluaproject.net/overview
[25]:https://www.kyne.com.au/~mark/software/lua-cjson-manual.html
[26]:https://github.com/pellepl/spiffs
[27]:https://iprice.ph/hiletgo/
[28]:https://www.amazon.com/gp/product/B010O1G1ES/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1
[29]:http://www.esp8266.com/wiki/doku.php?id=esp8266-module-family#modules
[30]:https://cdn-shop.adafruit.com/product-files/2471/0A-ESP8266__Datasheet__EN_v4.3.pdf
[31]:http://www.kloppenborg.net/images/blog/esp8266/esp8266-esp12e-specs.pdf
[32]:http://www.embeddedinsights.com/epd/tensilica/tensilica-xtensalx3.php
[33]:https://www.adafruit.com/product/2471
[34]:https://www.amazon.com/HiLetgo-Version-NodeMCU-Internet-Development/dp/B010O1G1ES
[35]:https://www.tindie.com/products/doit/espduinowifi-arduino-uno-r3/
[36]:http://www.espressolite.com/
[37]:https://www.sparkfun.com/products/13711
[38]:https://www.adafruit.com/product/2821
[39]:http://hackaday.com/2014/12/02/finding-a-cheaper-usb-to-serial-chips/
[40]:https://github.com/espressif/esptool
[41]:http://www.banggood.com/buy/esp8266-nodemcu-development-board.html?p=PT19151269030201502M
[42]:https://frightanic.com/iot/comparison-of-esp8266-nodemcu-development-boards/
[43]:http://esp8266-re.foogod.com/wiki/IoT_SDK
[44]:https://nodemcu.readthedocs.io/en/master/en/flash/#putting-device-into-flash-mode
[45]:http://www.freertos.org/
[46]:http://www.espressif.com/en/support/explore/get-started/esp8266/getting-started-guide
[47]:http://nodemcu.readthedocs.io/en/dev/en/flash/
[48]:https://github.com/nodemcu/nodemcu-flasher
[49]:https://github.com/igrr/esptool-ck
[50]:http://esp8266.github.io/Arduino/versions/2.0.0/doc/ota_updates/ota_updates.html
[51]:https://www.youtube.com/watch?v=2rnfhwipFRI
[52]:https://github.com/4refr0nt/luatool
[53]:http://nodemcu.readthedocs.io/en/dev/
[54]:https://cdn-learn.adafruit.com/downloads/pdf/adafruit-feather-huzzah-esp8266.pdf
[55]:https://learn.adafruit.com/adafruit-huzzah-esp8266-breakout/using-nodemcu-lua
[56]:http://www.lua.org/home.html
[57]:https://nodemcu.readthedocs.io/en/master/
[58]:http://nodemcu.readthedocs.io/en/master/en/upload/#initlua
[59]:http://nodemcu.readthedocs.io/en/master/en/lua-developer-faq/#how-do-i-avoid-a-panic-loop-in-initlua
[60]:https://github.com/nodemcu/nodemcu-firmware/blob/dev/lua_examples/telnet.lua
[61]:https://nodemcu.readthedocs.io/en/master/en/upload/
[62]:http://nodemcu.readthedocs.io/en/master/en/modules/file/
[63]:http://www.freertos.org/
[64]:https://github.com/espressif/ESP8266_RTOS_SDK
[65]:https://github.com/SuperHouse/esp-open-rtos
[66]:http://www.superhouse.tv/
[67]:
[68]:
[69]:
[70]:
