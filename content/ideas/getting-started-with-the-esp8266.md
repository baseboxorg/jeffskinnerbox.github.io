
* 13 part series with interesting examples - [Why is IoT so Expensive? Hint: It Doesn’t Have to Be!](https://blog.falafel.com/why-is-iot-so-expensive-hint-it-doesnt-have-to-be/)
* [Using a NodeMCU and Light Sensor to Build a JavaScript Night Light](https://www.losant.com/blog/building-a-nodemcu-javascript-night-light)

![ESP8266](http://www.seeedstudio.com/depot/bmz_cache/9/9f6470017d1ee80290eeddbe72d59d69.image.530x397.jpg "The ESP8266 offers a complete and self-contained WiFi networking solution, allowing it to either host the application or to offload all WiFi networking functions from another application processor.")
![ESP8266](/images/ESP8266.jpg "The ESP8266 offers a complete and self-contained WiFi networking solution, allowing it to either host the application or to offload all WiFi networking functions from another application processor.")

In early September 2014, I [became aware][04] of a new,
inexpensive (< $5), and ultimately [game changing][01]
[WiFi transceiver breakout board with a ESP8266 SoC chip][21].
(**Note:** In [some places][06], you see this device referred to as the Wi07c.)
Initially, [not much is know about this chip][02]
but it does appear to have [TI CC3000][03] [like-functionality][05].

The ESP8266 has builtin TCP/IP using [LwIP][11],
supports the [802.11b/g/n standard][10],
[WiFi Direct (P2P)][12],
[SoftAP (aka virtual router)][13],
and it can operate in three modes: [AP, STA and AP+STA][14].

The ESP8266 has been a game changer since
WiFi has always been expensive for small projects
(e.g. Arduino Ethernet or WiFi board will cost you $35).
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
not all of these features may be exposed via pins.

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
The Espressif Systems ESP8266-01 lacks an [FTDI chip][67],
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

To date, the most important variants are the ESP-01 (the original release)
and the ESP-12E (the latest version as of this writing).
The main differentiation between these versions was not the microprocessor
(this has remained essentially unchanged),
but instead the number of ports exposed to the user.
For example, the ESP-01 has a total of eight pins connected to user-reachable headers,
two of which were used for power.
Whereas the ESP-12E has 22 pins.
All esp8266 boards appear to use the ESP8266EX module,
whose English datasheet can be found [here][30].
The ESP-12E WiFi Module data sheet is [here][31].

There are also ESP8266 PCBs that provide additional functionality and ease your development.
These include:

* [NodeMCU DevKit][34] for $9 with a [cheap CH340G][39] serial-to-USB interface
* [Adafruit HUZZAH][33] for $10 is similar to the NodeMCU DevKit but no USB to serial chip
* [Adafruit Feather HUZZAH][38] for $17 same as above with micro USB port for power,
programming, and built in Lithium Polymer battery support/charging
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
    <a href="http://www.esp8266.com/wiki/doku.php?id=esp8266-module-family#esp-01">
        <img class="img-rounded" style="margin: 0px 8px" title="This shows you the differance between the older and newer ESP-01 moduals" alt="ESP-01" src="http://www.xess.com/static/media/uploads/blog/devbisme/2014-10-09/V080_V090.png" width="200" height="200">
    </a>
</div>
<div style="float: left">
    <a href="http://www.esp8266.com/wiki/doku.php?id=esp8266-module-family#esp-01">
        <img class="img-rounded" style="margin: 0px 8px" title="This shows you the ESP-01 ESP8266 WiFi Module Pinout" alt="ESP-01" src="http://hackerspace.pbworks.com/f/1414572698/esp-01.png" width="200" height="200">
    </a>
</div>
The [Electrodragon ESP8266 page][07] shows the component layout and pin assignments
for the (older) V080 and (newer) V090 modules.
The presence of the small LEDs on the module indicates it's a V090.

This appears to be the most common ESP8266 modual compatable with breadboarding:

* 2x4 2.54 mm pitch header
* built-in PCB-printed antenna
* 2 GPIOs: GPOI0/2
* UART URXD/UTXD
* RESET and CH_PD (powerdown)
* VCC/GND
* 14.2 mm W x 14.2 mm L

* [Get Started With ESP8266 Using AT Commands, NodeMCU, or Arduino (ESP-12E)](http://www.instructables.com/id/Get-Started-with-ESP8266-Using-AT-Commands-NodeMCU/)

## ESP-02
<div style="float: left">
    <a href="http://www.esp8266.com/wiki/doku.php?id=esp8266-module-family#esp-02">
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
    <a href="http://www.esp8266.com/wiki/doku.php?id=esp8266-module-family#esp-03">
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
<div style="float: left">
    <a href="http://www.esp8266.com/wiki/doku.php?id=esp8266-module-family#esp-12">
        <img class="img-rounded" style="margin: 0px 8px" title="This shows you the ESP-12 ESP8266 WiFi Module Pinout" alt="ESP-01" src="http://simba-os.readthedocs.io/en/latest/_images/esp12e-pinout.png" width="200" height="200">
    </a>
</div>
The most important variants of the ESP8266 are the
ESP-01 (the original release) and the [ESP-12 / ESP-12E][68],
which is the latest version as of this writing.
The main differentiation between these versions was not the microprocessor
(this has remained essentially unchanged),
but instead the number of ports exposed to the user.
For example, the ESP-01 has a total of eight pins connected to user-reachable headers
(two of which were used for power), whereas the ESP-12E has 22 pins.

* Voltage - 3.3 V (3.0 - 3.6 V tolerated)
* Current - 10 uA - 500 mA (64 mA average)
* Processor - Tensilica L106 32 bit
* Processor Clock - 80-160MHz
* RAM - 32K + 80K (explained below)
* Storage - Flash memory, 16MB max (512 K - 4 MB often provided)
* GPIOs - 17 (multiplexed with other functions)
* ADC - 1 (10 bit)
* WiFi - 802.11 support b/g/n/d/e/i/k/r
* TCP Connections - Max: 5 concurrent

## NodeMCU / ESP-12 Development Board
<div style="float: left">
    <a href="http://www.kloppenborg.net/blog/microcontrollers/2016/08/02/getting-started-with-the-esp8266">
        <img class="img-rounded" style="margin: 0px 8px" title="This shows you the ESP-12 ESP8266 WiFi Module Pinout" alt="ESP-01" src="https://raw.githubusercontent.com/nodemcu/nodemcu-devkit-v1.0/master/Documents/NODEMCU_DEVKIT_V1.0_PINMAP.png" width="200" height="200">
    </a>
</div>
To make the development with the ESP8266 easier,
the community has developed an open source development board called the [NodeMCU][22].
It has on it a ESP-12E along with USB, reset & flash switches to make development easier.
This maybe the most important of them all given inexpensive they have become
(I have seen prices of $6) and the quantity of code being developed for it.

# Methods of Programming ESP8266
There are a variety operating envirnments
and development tool to program the ESP8266 including:

* [ESP8266 AT Commands](https://cdn.sparkfun.com/assets/learn_tutorials/4/0/3/4A-ESP8266__AT_Instruction_Set__EN_v0.30.pdf)
* [ESP8266 SDK and Toolchain](https://github.com/pfalcon/esp-open-sdk)
* [NodeMCU with eLua](https://nodemcu.readthedocs.io/en/master/)
* [Arduino IDE with C++](http://www.whatimade.today/esp8266-easiest-way-to-program-so-far/)
* [FreeRTOS](https://github.com/espressif/ESP8266_RTOS_SDK)
* [PlatformIO](http://platformio.org/)
* [Mongoose OS](https://mongoose-os.com/)

In all cases, you will be connecting to your board over a serial connection to start.
Other than development boards like the NodeMCU,
you will use some form of USB to serial adapter (that supports 3.3V TTL levels!),
such as,
[FTDI Friend](https://learn.adafruit.com/ftdi-friend),
[USB-Serial Cable](https://www.adafruit.com/products/70),
or [Console Cable](https://www.adafruit.com/product/954).

The ESP8266 has three pins for (3.3 volt) serial communications.
There are two TX pins and one RX pin.
In order to interface your computer with these pins,
you will need to purchase a 3.3 volt USB-Serial Cable.
When the ESP8266 first boots,
the serial ports are configured at 74880 baud.
Some boards with built-in USB converters may use 9600 or 115,200 baud instead.
Thus it is important to consult your board’s documentation.

## AT Commands
[!at-command-logo](http://electronicsforu.com/wp-contents/uploads/2016/04/At_COMMAND.png)
The ESP8266 modules come with a pre-loaded firmware
that will accept AT Commands through their UART interface
(connect to wifi, open udp socket, send data to this IP...).
This method uses the ESP8266’s dedicated UART
pins to communicate with and program the microcontrollers.
Compared to the other programming methods, this technique is arcane,
but worth mentioning if you need to do some (very) low-level debugging
or all you have is a terminal.
Listed below are some documentation for the ESP8266 AT Commands:

* [How to Flash AT commands firmware in ESP8266 ESP-01 Wi-Fi module](http://esp8266internetofthings.blogspot.in/2015/10/how-to-flash-at-commands-firmware-in.html)
* [WIFI module ESP8266 for IoT](http://www.epanorama.net/newepa/2014/11/09/wifi-module-esp8266-for-iot/)
* [List of ESP8266 AT Commands](http://www.electrodragon.com/w/Wi07c#Commands)
* [More AT Command Information Found](https://hackaday.io/project/2879/log/9300-more-at-command-information-found)
* [Get Started With ESP8266 Using "AT Commands" Via Arduino](http://www.instructables.com/id/Get-Started-With-ESP8266-Using-AT-Commands-Via-Ard/?ALLSTEPS)
* [Get Started With ESP8266 Using AT Commands, NodeMCU, or Arduino (ESP-12E)](http://www.instructables.com/id/Get-Started-with-ESP8266-Using-AT-Commands-NodeMCU/)

## ESP8266 SDK and Toolchain
[!espressif-logo](http://www.signal.com.tr/img/temlogo/espressif-logo.png)
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
* **RTOS SDK** is based on [FreeRTOS][45]
(additional details about FreeRTOS below).
You get a full multi-tasking operating system which uses “typical”
methods of programming to implement desired functionality.

Expressif’s ["Getting Started Guide"][46]
explains how to use both of these methods in further detail.
Also check out these sources:

* [How to Directly Program an Inexpensive ESP8266 WiFi Module](http://hackaday.com/2015/03/18/how-to-directly-program-an-inexpensive-esp8266-wifi-module/)
* [Setting up the ESP8266 Open SDK](https://www.penninkhof.com/2015/03/esp8266-open-sdk/)
* [Install ESP8266 SDK toolchain on Linux](https://www.htlinux.com/install-esp8266-sdk-toolchain-on-linux-ubuntu-14-10-desktop/)
* [ESP8266 Firmware ToolChain](http://www.electrodragon.com/w/Category:ESP8266_Firmware_ToolChain)
* https://github.com/esp8266/esp8266-wiki/wiki/Toolchain

## Arduino IDE
[!arduino-esp8266-logo](https://www.penninkhof.com/wp-content/uploads/2015/08/arduino-esp8266.png)
Some group from the [ESP8266 community forum][70] published their [code on GitHub][69]
as an extension to the Arduino IDE.
This allows you to flash programs to the ESP8266,
making it kind of arduino compatible.
It lets you write sketches using familiar Arduino functions and libraries,
and run them directly on ESP8266, no external microcontroller required.
ESP8266 Arduino core comes with libraries to communicate over WiFi using TCP and UDP,
set up HTTP, mDNS, SSDP, and DNS servers, do OTA updates,
use a file system in flash memory, work with SD cards, servos, SPI and I2C peripherals.
Some sources are below:

* [ESP8266 - Easiest way to program so far (Using Arduino IDE)](http://www.whatimade.today/esp8266-easiest-way-to-program-so-far/)
* [Adafruit HUZZAH ESP8266 breakout - Using Arduino IDE](https://learn.adafruit.com/adafruit-huzzah-esp8266-breakout/using-arduino-ide)
* [Programming the ESP8266 With the Arduino IDE in 3 Simple Steps](https://dzone.com/articles/programming-the-esp8266-with-the-arduino-ide-in-3)
* [Arduino IDE + esp8266 board](https://retro.moe/2016/03/27/c64-remote-controller-nodemcu-vs-adafruit-huzzah-vs-sparkfun-thing-vs/)

## NodeMCU With eLua
[!lua-logo](http://www.lua.org/images/lua.gif)
Lua is an interpreted programming languages (aka scripting language).
and is popular in game development and
designed to be simple, portable, to have a small footprint.
It can run on lots of embedded platforms, that do not have even operating systems,
and runs Lua on the “bare metal”.
If the processors has a C cross-compiler and about 64Kb of free RAM, it can run Lua.

In order to get started programming using this technique,
the first thing you need to do is flash the ESP8266 with the correct firmware.
The [documentation on flashing][47] indicates you can use either a Python utility called [esptool][40]
or you can use [NodeMCU Flasher][48] to program the chip.
(One provider of a NodeMCU compatable development platform, Adafruit,
provide the [HUZZAH ESP8266 Breakout][71] pre-flashed with the Lua code.)

* [Getting Started with NodeMCU Board Powered by ESP8266 WiSoC](http://www.cnx-software.com/2015/10/29/getting-started-with-nodemcu-board-powered-by-esp8266-wisoc/)
* [ESP8266 Node MCU Setup](http://www.averagemanvsraspberrypi.com/2015/11/esp8266-node-mcu-setup.html)
* [Using NodeMCU Lua](https://learn.adafruit.com/adafruit-huzzah-esp8266-breakout/using-nodemcu-lua)
* [NodeMCU Documentation](http://nodemcu.readthedocs.io/en/master/en/)
* [NodeMCU DEVKIT V1.0 (nodemcu-devkit-v1.0)](https://github.com/nodemcu/nodemcu-devkit-v1.0)
* [NodeMCU Flasher](https://github.com/nodemcu/nodemcu-flasher)

You you can also find some help learning the Lua language here:

* [Programming in Lua, Fourth Edition](https://www.amazon.com/exec/obidos/ASIN/8590379868/lua-start-20)
* [course notes based on the above book](http://www.dcc.ufrj.br/~fabiom/lua/)
* [Learn Lua in 15 minutes](https://coronalabs.com/learn-lua/)
* [Embeddable scripting with Lua](https://www.ibm.com/developerworks/library/l-lua/)
* [Lua Unofficial FAQ (uFAQ)](http://www.luafaq.org/)
* [The Lua language (v5.1) Cheat Sheet](http://thomaslauer.com/download/luarefv51.pdf)

Programming the ESP8266 with eLua and NodeMCU appears to be one of the easier methods.
One key benefit is that this technique gives you an interactive shell on the ESP8266
in which you can program and experiment with little chance of bricking the unit permanently.

## FreeRTOS
[!freertos-logo](https://www.microsemi.com/images/soc/partners/solution/ip/FreeRTOSlogov1.jpg)
The developer of the ESP8266, Espressif, has also created a ESP8266 SDK based on [FreeRTOS][63]
called [ESP8266_RTOS_SDK][64].
There is also a community developed fork (sponsored by [SuperHouse Automation][66])
called [esp-open-rtos][65] but claims to be
substantially different from the Espressif version.
Off hand, this community version appears better documented and supported.

FreeRTOS is a popular [real-time operating system][72] kernel
for embedded devices that has been ported to 35 microcontrollers.
FreeRTOS is designed to be small and simple.
The kernel itself consists of only three C files.
To make the code readable, easy to port, and maintainable, it is written mostly in C,
but there are a few assembly functions included where needed
(mostly in architecture-specific scheduler routines).
FreeRTOS provides methods for multiple threads or tasks, mutexes, semaphores and software timers.
A tick-less mode is provided for low power applications.

* [FreeRtos on Esp8266](http://correderajorge.github.io/Esp8266-FreeRtos/)
* [ESP8266 FreeRTOS Introduction](http://www.nefastor.com/esp8266-freertos-introduction/)
* [ESP8266 FreeRTOS SDK – blinking LED example](http://www.pratikpanda.com/esp8266-blinking-led-example/)
* [ESP8266 FreeRTOS Test](https://blog.the-jedi.co.uk/2015/02/14/esp8266-freertos-test/)
* [Setting Up FreeRTOS on Arduino](https://exploreembedded.com/wiki/Setting_Up_FreeRTOS_on_Arduino)
* [Using FreeRTOS multi-tasking in Arduino](https://www.hackster.io/feilipu/using-freertos-multi-tasking-in-arduino-ebc3cc)
* [Tiny $7 IoT module packs WiFi, BLE, and sensors, runs FreeRTOS](http://linuxgizmos.com/tiny-7-iot-module-packs-wifi-ble-and-sensors-runs-freertos/)

## PlatformIO
[!platfromio-logo](http://cdn.platformio.org/images/platformio-logo.17fdc3bc.png)
[PlatformIO][73] is an open source Integrated Development Environment (IDE) for IoT development
and an alternative to the Arduino IDE.
This IDE has a clean and easy-to-use interface.
It offers not only a visual IDE to develop projects,
but it has a CLI (Command Line Interface).
It is based on Python and runs on multiple OSs (Windows, OS X, and Linux).
PlatformIO has excellent [documentation][74],
well supported including a [professional version PlaformIO Plus][75],
and main features it brags about are:

* [next-generation IDE](http://platformio.org/platformio-ide) using [Atom text editor](https://atom.io/)
* C/C++ code completion, smart code linter
* Multi-project support
* theme support
* cross-platform support
* serial port monitor
* supports a multitude of [boards](http://platformio.org/boards), [platforms/processors](http://platformio.org/platforms/atmelavr), [frameworks](http://platformio.org/frameworks/arduino)
* library management system via a online [library registry](http://platformio.org/lib)
* [coding examples for the libraries](http://platformio.org/lib/examples)
* and continuous integration support via [Travis CI](https://docs.travis-ci.com/user/integration/platformio/)

PlatformIO is a popular IDE on it own but appears have a siginificant
following within the ESP8266 couuminty,
as illustrated by the postings below:

* [PlatformIO: An Alternative Arduino IDE](https://dzone.com/articles/platformio-iot-integrated-platform)
* [PlatformIO: Arduino on the SparkFun WRL-13678 (ESP8266)](http://blog.coria.com/platformio-arduino-on-the-sparkfun)
* [OTA: PlatformIO and ESP8266](http://tiestvangool.ghost.io/2017/01/12/ota-platformio-and-esp8266/)
* [Over-the-Air ESP8266 programming using PlatformIO](https://www.penninkhof.com/2015/12/1610-over-the-air-esp8266-programming-using-platformio/)
* [GETTING STARTED WITH PLATFORMIO AND ESP8266 NODEMCU](https://www.losant.com/blog/getting-started-with-platformio-esp8266-nodemcu)
* [1/3: PlatfomIO overview & compiling + uploading locally and on a Raspberry Pi](https://blog.openenergymonitor.org/2016/06/platformio/)
* [2/3: Continuous testing and auto release binary generation using PlatformIO & TravisCI](https://blog.openenergymonitor.org/2016/06/auto-build-continuous-test-firmware/)
* [3/3: Continuous Deployment (OTA to ESP8266)](https://blog.openenergymonitor.org/2016/06/esp8266-ota-update/)

## Mongoose OS
[!mongoos-os-logo](https://blog.cesanta.com/hubfs/logo_blue_MOS.png?t=1490439456366)
An open source Operating System for microcontrollers: ESP32, ESP8266, STM32, TI CC3200.
It also claims to natively support Amazon AWS IoT integation,
over-the-air (OTA) updates, and remote device management.

* [Mongoose OS](https://mongoose-os.com/)
* [How to build an IoT project with Mongoose OS](https://opensource.com/article/17/3/mongoose-os-iot-development?sc_cid=70160000001290lAAA)

# ESP-01
assuming at power up the Blue led flashed twice quickly and then flashes every second, this means it attempting to connect to your WiFi network. It should do this for about 30 seconds then if it can’t connect the flashing will stop and it will become it’s own access point on 192.168.4.1.

* https://www.itead.cc/wiki/ESP8266_Serial_WIFI_Module
* http://www.whatimade.today/esp8266-and-the-water-heater/

* [ESP8266 Quick Start](http://benlo.com/esp8266/esp8266QuickStart.html)
* [Update the Firmware in Your ESP8266 Wi-Fi Module](https://www.allaboutcircuits.com/projects/update-the-firmware-in-your-esp8266-wi-fi-module/)
* [How to Flash ESP-01 Firmware to the Improved SDK v2.0.0](https://www.allaboutcircuits.com/projects/flashing-the-ESP-01-firmware-to-SDK-v2.0.0-is-easier-now/?utm_source=All+About+Circuits+Members&utm_campaign=498644bd29-EMAIL_CAMPAIGN_2017_03_23&utm_medium=email&utm_term=0_2565529c4b-498644bd29-270523833)
* [ESP8266 WiFi Module Quick Start Guide](http://rancidbacon.com/files/kiwicon8/ESP8266_WiFi_Module_Quick_Start_Guide_v_1.0.4.pdf)

# Working with ESP-01 or Similar Boards
[!esp-01-512K-1M](https://cdn.instructables.com/ORIG/F4Q/KV0K/IO4JRAXC/F4QKV0KIO4JRAXC.jpg)
This tiny ESP8266 WiFi Module is a self contained System on a Chip (SOC),
with integrated TCP/IP protocol stack,
and can give a microcontroller access to your WiFi network.
The ESP8266 is capable of either hosting a small application
or offloading all WiFi networking functions in support of another application processor.
This module has a powerful enough on-board processing
and storage capability that allows it to be integrated with the sensors
and other application specific devices through its GPIOs with minimal development.

Each ESP8266 module comes pre-programmed with an AT command set firmware.
this means you can simply hook this up to your processor
and get about as much WiFi-ability as a WiFi Shield offers.

The ESP-01 version of the ESP8266 WiFi module comes in two version.
The orginal (blue board) had a flash disk size of 512k
and the new version (black board, with words "AI Cloud inside" near the antenna)
with 1MB of flash.

**Note:** The ESP8266 Module is not capable of 5-3V logic shifting
and will require an external Logic Level Converter.
**Do not** power it directly with 5V.

To enable ESP8266 firmware flashing,
GPIO-0 pin must be pulled low before the device is reset.
Conversely, for a normal boot, GPIO-0 must be pulled high or floating.

If you have a NodeMCU dev kit then you don't need to do anything,
as the USB connection can pull GPIO-0 low.

If you have an ESP-01 or other device without built-in USB, you will need to enable flashing yourself by pulling GPIO0 low or pressing a "flash" switch, while powering up or resetting the module.

https://www.youtube.com/watch?v=5ovkcvEzohU

# Working with ESP8266 on Development Board
The ESP8266 like the ESP-01 is small, super-cheap, being installed everywhere,
and creating all sorts of activity.
But hacking a solution together can be a challenge if you working close the [bare metal][77].
Getting the ESP8266 to work requires a fair amount of work and to make things easier,
several teams have built a ESP8266 [development board][76],
most popular being the NodeMCU.
If your just starting with the ESP8266,
start with the developer board version.

## NodeMCU
[!nodemcu-logo](https://avatars1.githubusercontent.com/u/9865736?v=3&s=400)
While the ESP8266 chip has been very popular, its can also be very difficult to use.
Most of the low cost modules (e.g. ESP-01) are a challege to program,
don't have an onboard 500mA 3.3V regulator or level shifting.
The [NodeMCU DevKit][34] costs $9 and is programable via a [cheap CH340G][39] USB interface.
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

Some good source materials for NodeMCU is:
* [NodeMCU Home Page](http://www.nodemcu.com/index_en.html)
* [NodeMCU Firmware](https://github.com/nodemcu/nodemcu-firmware)
* [NodeMCU Flasher](https://github.com/nodemcu/nodemcu-flasher)
* [NodeMCU DevKit V1.0](https://github.com/nodemcu/nodemcu-devkit-v1.0)
* [NodeMCU Documentation](https://nodemcu.readthedocs.io/en/master/)

Give this is open source,
you'll find [muliple providers of NodeMCUs][41].
A comparison can be confusing since there are many different boards
but this artcle ["Comparison of ESP8266 NodeMCU development boards"][42]
does a reasonable job.
The NodeMCU boards I will be covering here are:

1. [Adafruit Feather HUZZAH][38] similar to the Adafruit HUZZAH below but with
a micro USB port for serial access, the USB can also supply power,
and power can be supplied via Lithium Polymer battery
1. [Adafruit HUZZAH][33] is similar to the NodeMCU DevKit but
you must supply a USB-to-serial cable to interface
1. [NodeMCU DevKit][34] is popular version of the NodeMCU v1.0 board
is manufactured by [HiLetgo][27] easily obtainable via [Amazon][28],
eBay, or other sources for around $8.79.

I will cover these boards in the order listed above.
I'll do that beacuse of the easy of use.
The first two are delivered by Adafruit already flashed with
NodeMCU 0.9.5 and Lua 5.1.4 firmware.
This is a older but stable version of the firmware,
but the main advantage is that you can be up and running quickly.
Flashing the device, while not difficult,
has multiple steps and many place where you can go wrong.
The third NodeMCU board is widely use,
and is generally not delivered pre-flashed.

### NodeMCU v0.9, v1.0 and v2.0
If you purchase a NodeMCU board it’s important to know there
are [two official versions and a third less than offical][42]:

* NodeMCU v0.9 / v1 with ESP-12 module, USB to UART chip is ch340G,
and [nodemcu-devkit-v1](https://github.com/nodemcu/nodemcu-devkit) software
(**not recommended**)
* NodeMCU v1.0 / v2 with ESP-12E module, USB to UART chip is CP2102,
and [nodemcu-devkit-v1](https://github.com/nodemcu/nodemcu-devkit-v1.0) software
* NodeMCU v3 with ESP-12E module, “version” invented by producer LoLin to provide
minor improvements to the V2 boards (**not recommended**)

[!nodemcu-photo](http://www.cnx-software.com/wp-content/uploads/2015/10/NodeMCU_0.9_vs_NodeMCU_1.0_Large.jpg)

A common complaint about the NodeMCU v0.9 is that it takes the full width of a breadboard,
while NodeMCU v1.0 leaves room for jumper wires.
In the photo above. the NodeMCU v0.9 is left and v1.0 is on the right.

You'll find the boards pin out below:

ESP-12E Pin Out - http://www.kloppenborg.net/images/blog/esp8266/esp8266-esp12e-pinout.png
NodeMCU - http://www.kloppenborg.net/images/blog/esp8266/esp8266-node-mcu-pinout.png
(Images taken from [ESP8266 NodeMCU Arduino Killer](https://www.slideshare.net/roadster43/esp8266-nodemcu))

### Building NodeMCU Firmware - DONE
The NodeMCU documentation discusses [three ways to build your NodeMCU firmware][84]:
[cloud build service][86], [Docker images][81],
or cross-compiler environments for building from source (via [NodeMCU GitHub site][79]).
You'll also find some scattered sites with pre-compiled, [binary files][80].
All these essentually require or have done a manual build using the firmware source code
and will requires some [configuration to control firmware size][85].

But by far the easiest way to go for the typical NodeMCU user is the
[NodeMCU custom builds][86] cloud tool.
You'll get to choose what functionality is installed, thereby contolling the firmware size.
This tool will deliver two binaries, one is "integer" and the other "float" firmware.
The integer version does not support floating point operations nor does it allow non-integer numbers.
The float version typically runs a little larger in size.
For example, when built against the master branch,
and including the modules `file`, `gpio`, `http`, `net`, `node`, `tmr`, `uart`, `wifi`,
I got the following:

```bash
# example nodemcu firmware
$ lsl
total 820
-rw-rw-r-- 1 jeff jeff 402944 Apr  8 12:12 nodemcu-master-8-modules-2017-04-08-15-46-11-integer.bin
-rw-rw-r-- 1 jeff jeff 417264 Apr  8 12:11 nodemcu-master-8-modules-2017-04-08-15-46-11-float.bin
```

### Flashing the NodeMCU - DONE
Once you have your NodeMCU firmware built and downloaded,
ideally via the [NodeMCU custom builds][86] cloud tool,
you'll need a tool that can flash the firmware to the NodeMCU / ESP8266.
The [documentation on flashing][47] indicates you can use either
a Python utility called [esptool][40]
or you can use [NodeMCU Flasher][48] to program the chip.
In fact, there are several methods available to program (aka flash) the ESP8266.
A list of some of the options are:

* [**esptool.py**][40] - a Python utility to communicate with the ROM bootloader.
It is simple and platform agnostic. This is open source, widely used, and well documented. **Recommended**.
* [**esptool-ck**][49] - a C program to create firmware files for and flash the ESP8266 chips using a serial port.
It is also platform agnostic and open source. It supports a variety of boards and has decent documentation,
but I never got it to work.
To install it, you could choose [Ubuntu package][82] (documentation found [here][83]),
or the more up to date GitHub source [esptool-ck][49].  **Not recommended**.
* [**nodemcu-flasher**][48] - a GUI application which is designed specifically for the NodeMCU board.
It is very easy to use, open source, and reasonably well documented, but its GitHub site hasn't been touch in
a long time. **Not recommended**.
* **Over the Air** - there are various methods to download a new firmware image from Internet and flash the chip live.
One example can be found in the [ESP8266 Arduino Core project][50] and there are [methods for NodeMCU][51] as well.
**Use for post-development updates**.

>**NOTE:** To enable ESP8266 firmware flashing,
GPIO0 pin must be pulled low before the device is reset.
Conversely, for a normal boot, GPIO0 must be pulled high or floating.
If you have a NodeMCU dev kit or the Adafruit HUZZAH device then you don't need to do anything.
The USB connection can pull GPIO0 low automatically while flashing.
If you have an ESP-01 or other device without built-in USB,
you will need to enable flashing yourself by pulling GPIO0 low or pressing a "flash" switch.

Learning how to successfully flash the firmware can be a challenge
because of the widely dispersed documentation.
A good stating point is the [offical NodeMCU documentation][87].
If you're upgrading from a previous version,
you should carefully study the "[Upgrading Firmware][88]" instructions.

#### Flashing NodeMCU With esptool.py - DONE
The [`esptool.py`][40] is the preferred tool to do your firmware flashing.
It is a Python-based, open source, platform independent,
utility to communicate with the ROM bootloader in Espressif ESP8266.
To install this tool:

```bash
# install esptool.py
pip install --user esptool

# esptool.py will be istalled with your python packages
$ pywhereis esptool
esptool: /home/jeff/.local/bin/esptool.py

# make sure the package is with your path
$ whereis esptool.py
esptool: /home/jeff/bin/esptool /home/jeff/.local/bin/esptool.py /home/jeff/.local/bin/esptool.pyc

# note: esptool-ck is also in your path and may cause confusion
$ whereis esptool
esptool: /home/jeff/bin/esptool /home/jeff/.local/bin/esptool.py /home/jeff/.local/bin/esptool.pyc

# check your python path
$ pywhereis esptool
esptool: /home/jeff/.local/bin/esptool.py

# validate the install and see the version number
$ ~/.local/bin/esptool.py version
esptool.py v1.3
1.3
```

Documentation for the `esptool.py` can be found
[here](https://github.com/espressif/esptool).
You can also find good examples on the many ways of using `esptool.py`
[here](https://nodemcu.readthedocs.io/en/master/en/flash/),
and [here](https://github.com/espressif/esptool/issues/68).
Also, the tool itself provides some basic information about its use,
as illustrrated belowL

```bash
# see theesptool.py help documentation
$ ~/.local/bin/esptool.py --help
usage: esptool [-h] [--port PORT] [--baud BAUD]
               {load_ram,dump_mem,read_mem,write_mem,write_flash,run,image_info,make_image,elf2image,read_mac,chip_id,flash_id,read_flash,verify_flash,erase_flash,version}
               ...

esptool.py v1.3 - ESP8266 ROM Bootloader Utility

positional arguments:
  {load_ram,dump_mem,read_mem,write_mem,write_flash,run,image_info,make_image,elf2image,read_mac,chip_id,flash_id,read_flash,verify_flash,erase_flash,version}
                        Run esptool {command} -h for additional help
    load_ram            Download an image to RAM and execute
    dump_mem            Dump arbitrary memory to disk
    read_mem            Read arbitrary memory location
    write_mem           Read-modify-write to arbitrary memory location
    write_flash         Write a binary blob to flash
    run                 Run application code in flash
    image_info          Dump headers from an application image
    make_image          Create an application image from binary files
    elf2image           Create an application image from ELF file
    read_mac            Read MAC address from OTP ROM
    chip_id             Read Chip ID from OTP ROM
    flash_id            Read SPI flash manufacturer and device ID
    read_flash          Read SPI flash content
    verify_flash        Verify a binary blob against flash
    erase_flash         Perform Chip Erase on SPI flash
    version             Print esptool version

optional arguments:
  -h, --help            show this help message and exit
  --port PORT, -p PORT  Serial port device
  --baud BAUD, -b BAUD  Serial port baud rate used when flashing/reading
```

To do the actual flashing of firmware,
you first download your desired NodeMCU firmware from the [NodeMCU custom builds][86] cloud tool.
There are both float and integer versions, but since I just wanted to toggle GPIOs,
I'll flash with the integer version.

```bash
# move to directory containing the firmware
cd ~/Downloads/nodemcu-binary

# generally not required, erase flash on a NodeMCU board
esptool.py --port /dev/ttyUSB0 erase_flash

# determine the manufacturer ID and a chip ID
$ esptool.py --port /dev/ttyUSB0 flash_id
esptool.py v1.3
Connecting....
Manufacturer: c8
Device: 4016

# flash the firmware
# note: flash size of 32m = 32M bits = 32Mb = 4M bytes = 4MB
$ esptool.py --port /dev/ttyUSB0 write_flash -fm dio -fs 32m 0x00000 nodemcu-1.5.4.1-final-8-modules-2017-04-17-19-54-04-integer.bin
esptool.py v1.3
Connecting....
Running Cesanta flasher stub...
Flash params set to 0x0240
Wrote 450560 bytes at 0x0 in 39.2 seconds (92.0 kbit/s)...
Leaving...
```

The firmware flash will take a little bit of time, but once its done,
you can connect to the ESP8266 via a USB cable and starting up a serial terminal like this:

```bash
# works for Adafruit's HUZZAH devices
screen /dev/ttyUSB0 9600
screen /dev/ttyUSB0 74400

# works for the NodeMCU DevKit
screen /dev/ttyUSB0 115200
```

Now reboot the board using the reset switch on the DevKit board.
If all goes well, you should be greeted by a Lua prompt like the following:

```
NodeMCU custom build by frightanic.com
        branch: 1.5.4.1-final
        commit: 1885a30bd99aec338479aaed77c992dfd97fa8e2
        SSL: false
        modules: file,gpio,http,net,node,tmr,uart,wifi
 build  built on: 2017-04-17 19:53
 powered by Lua 5.1.4 on SDK 1.5.4.1(39cb9a32)
lua: cannot open init.lua
>
```

If you get some jibberish text,
try changing the baud setting in the call to screen.
After this, you can proceed to write code following
the instructions found in the [NodeMCU Documentation][53].

**NOTE:** In some cases, the init data may be invalid beacuase of previous flahing,
and NodeMCU may fail to boot.
The easiest solution is to fully erase the chip before flashing:

```bash
# fully erease the flash
$ esptool.py --port /dev/ttyUSB0 erase_flash
esptool.py v1.3
Connecting....
Running Cesanta flasher stub...
Erasing flash (this may take a while)...
Erase took 0.5 seconds
```

## Adafruit's HUZZAH ESP8266 Breakout - DONE
[!huzzah-esp8266](https://cdn-learn.adafruit.com/guides/images/000/001/007/medium800/qt.jpg?1448302153)
The advantage of the [$9.95 Adafruit HUZZAH ESP8266 Breakout][89]
is that it comes with firmeware pre-installed
but unlike the the standard  NodeMCU hardware, it doesn't have a USB interface.
The module comes pre-loaded with NodeMCU's Lua interpreter
([NodeMCU 0.9.5 build 20150318 / Lua 5.1.4][55]),
and since it doesn't have a USB connection,
you'll need to use a [USB console cable][90], [FTDI Friend][91], or a [FTDI cable][92]
to power and upload software to the HUZZAH ESP8266.
The [tutorial on the Adafruit HUZZAH ESP8266 breakout][55]
shows you how to use these cables.

A variation to the HUZZAH ESP8266 is the
[Adafruit Feather HUZZAH with ESP8266 WiFi][38].
You'll find ESP8266 breakout board
on the higher end of the price list
([$16.96 directly from Adafruit][38]),
but you will get a battery connector for added portability,
and programable via a USB port.
Of all the ESP8266-based boards available,
this is one of the best in terms of intuitive setup and thorough [instructions and documentation][54].

### Accessing the Console on Adafruit's HUZZAH ESP8266 Breakout - DONE
Using one of the cables referenced above,
plug in the cable to the HUZZAH ESP8266 and your computer.
You will see a blue LED (near the WiFi antenna),
and a red LED,
quickly flash twice indicating the ESP8266 is up and running.
They will not stay lit.

Next, use a serial console program, such as `screen` on Linux,
access the HUZZAH ESP8266 console.

```bash
# access the console on the huzzah esp8266 (9600 or 74400 baud)
screen /dev/ttyUSB0 74400

# press the reset button on the huzzah esp8266
<press reset>
NodeMCU 0.9.5 build 20150318  powered by Lua 5.1.4
lua: cannot open init.lua
>
```

Notice the version number of the NodeMCU and Lua software.
The latest version of Lua can be found at the [Lua website][56]
To get a more up todate version,
you will need to flash the firmware via the [NodeMCU custom builds][86] cloud tool.

Now lets do a test command to see if Lua is working.

```lua
> print("Hello World")
Hello World
```

You can connecting the HUZZAH ESP8266 to your WiFi access point.
We can connect to the access point with `wifi.sta.config` and `wifi.sta.connect`.
It will take a second or two to complete the connection,
and then you can query the module to ask the status with `wifi.sta.status()`.
When you get a `5` it means the connection is completed and DHCP successful.

```lua
> wifi.setmode(wifi.STATION)
> wifi.sta.config("74LL5","password")
> wifi.sta.connect()
> print(wifi.sta.status())
5
> print(wifi.sta.getip())
192.168.1.38    255.255.255.0   192.168.1.1
>
```

### Uploading Lua Scripts - DONE
The draw back of the examples above is that they all required you
the get into the Lua interpreter environment and hand type in each line.
Any large or complex script will require a better approach.
The Python script [`luatool`][52] doe this by give you easy uploading of any Lua-based script
into the NodeMCU flash memory.
(`luatool` is one of [several NodeMCU Lua script upload tools][61])

First, clone the `luatool` on your devlopment envirnment:

```bash
# clone the luatool
cd ~/src
git clone https://github.com/4refr0nt/luatool.git

# put the tool in your PATH
cp ~/src/luatool/luatool/luatool.py ~/bin

# print out the help message
$ luatool.py --help
usage: luatool.py [-h] [-p PORT] [-b BAUD] [-f SRC] [-t DEST] [-c] [-r] [-d]
                  [-v] [-a] [-l] [-w] [-i] [-e] [--delay DELAY]
                  [--delete DELETE] [--ip IP]

ESP8266 Lua script uploader.

optional arguments:
  -h, --help            show this help message and exit
  -p PORT, --port PORT  Device name, default /dev/ttyUSB0
  -b BAUD, --baud BAUD  Baudrate, default 9600
  -f SRC, --src SRC     Source file on computer, default main.lua
  -t DEST, --dest DEST  Destination file on MCU, default to source file name
  -c, --compile         Compile lua to lc after upload
  -r, --restart         Restart MCU after upload
  -d, --dofile          Run the Lua script after upload
  -v, --verbose         Show progress messages.
  -a, --append          Append source file to destination file.
  -l, --list            List files on device
  -w, --wipe            Delete all lua/lc files on device.
  -i, --id              Query the modules chip id.
  -e, --echo            Echo output of MCU until script is terminated.
  --delay DELAY         Delay in seconds between each write.
  --delete DELETE       Delete a lua/lc file from device.
  --ip IP               Connect to a telnet server on the device (--ip IP[:port])
```

With the `luatool` you can now upload files,
like a new `init.lua` file, and its source file is called `file.lua`.
If you want to upload and autoexecute this new software, add the option `--dofile`.
For example:

```lua
# upload lua script to main.lua and then then execute it
luatool.py --port /dev/ttyUSB0 --src file.lua --dest init.lua --baud 74400 --dofile
```

Now lets create a script that will set the ESP8266
into WiFi client mode (aka station or STA) and run a WiFi scan.
Then have it print out the available access points.
Using your file editing tool,
create the following script to do this is and name the file `scanner.lua`:

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

Now reset the NodeMCU board and up load the file using `luatool`:

```bash
# upload lua script to init.lua and then execute it
luatool.py --port /dev/ttyUSB0 --src scanner.lua --dest init.lua

# get console access
screen /dev/ttyUSB0 74400

# restart the huzzah esp8266 (or press the reset button)
> node.restart()
NodeMCU 0.9.5 build 20150318  powered by Lua 5.1.4
>
                SSID    BSSID                     RSSI          AUTHMODE        CHANNEL
               56X3L    f8:e4:fb:ad:62:39         -93           3               6
          FiOS-DCJ9G    c8:a7:0a:95:7b:c4         -91           3               11
               74LL5    48:5d:36:2e:ee:08         -30           3               1
      Download Virus    90:72:40:1b:c4:c6         -78           3               6
             thefarm    4c:8b:30:9b:ea:01         -88           3               6
Campbell Wi-Fi Network  0c:51:01:e5:36:58         -92           3               1
             hpsetup    00:1e:0b:55:65:40         -89           0               6
               W7JKF    f8:e4:fb:7c:7a:b1         -92           3               1
               SQLKL    18:1b:eb:b2:79:08         -80           4               1
```

You could avoid the need for entering the NodeMCU console by having
`luatool.py` echo back what is happening.
For example:

```bash
# upload lua script to init.lua, and then then execute it, and echo back the output
$ luatool.py --port /dev/ttyUSB0 --src init.lua --dest init.lua --dofile --echo

->file.open("init.lua", "w") -> ok
->file.close() -> ok
->file.remove("init.lua") -> ok
->file.open("init.lua", "w+") -> ok
->file.writeline([==[-- execute these files at startup]==]) -> ok
->file.writeline([==[dofile("scanner.lua")]==]) -> ok
->file.flush() -> ok
->file.close() -> ok
->dofile("init.lua") -> send without checkdofile("init.lua")
>
                SSID	BSSID			  RSSI		AUTHMODE	CHANNEL
             hpsetup	00:1e:0b:55:65:40	  -88		0		6
               74LL5	48:5d:36:2e:ee:08	  -27		3		1
      Download Virus	90:72:40:1b:c4:c6	  -79		3		6
             thefarm	4c:8b:30:9b:ea:01	  -91		3		6
               SQLKL	18:1b:eb:b2:79:08	  -82		4		1
         TRENDnet637	00:14:d1:c3:c0:6f	  -85		1		10

```

The NodeMCU will autostart `init.lua` after boot.
To prevent being stuck in a boot loop,
full test using a `--dest scanner.lua` upload,
and then execute within `initlua` via `dofile("scanner.lua")` first.

You can also upload scripts via TCP/IP if your NodeMCU is already accessible via TCP/IP
and the telnet server `telnet_srv.lua` is running.
See typical telnet server `telnet_srv.lua` [here][60].

### Access File System and other Commands - DONE
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

A simpler approach to get a listing of the NodeMCU file system  is via the `luatool.py`:

```bash
# list the files on the nodemcu
$ luatool.py --port /dev/ttyUSB0 --list

->local l = file.list();for k,v in pairs(l) do print('name:'..k..', size:'..v)end -> send without checklocal l = file.list();for k,v in pairs(l) do print('name:'..k..', size:'..v)end
name:init.lua, size:56
name:scanner.lua, size:500
```

### init.lua
With `luatool` you can upload to any script on the NodeMCU,
one that will be uploading most frequently is the file called [`init.lua`][58].
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
a good starting point for creating your own `init.lua`
can be found [here][58], [here][59], and [here][78].

My example below (tested on NodeMCU 2.0 firmware) has four files:
`credentials.lua`, `http-server.lua`, `scanner.lua`, and the `init.lua` file.
Below is the `credentials.lua`, which contains the WiFi configuration information
for my home network.

```lua
AP_NAME = "Home WiFi"

-- wifi access point credentials
station_cfg = {}
station_cfg.ssid = "<my-ssid>"
station_cfg.pwd = "<my-password>"
--station_cfg.bssid = "AA:BB:CC:DD:EE:FF"    -- specify MAC address
station_cfg.auto = false                   -- DO NOT auto connect to access point
station_cfg.save = false                   -- DO NOT save config to flash
```

The `http-server.lua` file contains a very simple HTTP server.

```lua
 -- Start a simple http server
srv=net.createServer(net.TCP)
srv:listen(80, function(conn)
    conn:on("receive",function(conn, payload)
        print(payload)
        conn:send("<h1> Hello, NodeMCU!!! </h1>")
    end)
  conn:on("sent", function(conn) conn:close() end)
end)
```

`scanner.lua` performs a WiFi scan for access points and prints them out.

```lua
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

Here is the `init.lua` file with an abort feature to protect you from endless looping.

```lua
--load wifi credentials
dofile("credentials.lua")

-- this function calls your application
function startup()
    if abort == true then
        print("startup is aborted!")
        return
    else
        file.close("init.lua")
        -- the actual application is executed here
        dofile("scanner.lua")
        dofile("http-server.lua")
    end
end

-- set the wifi mode you wish to use
wifi.setmode(wifi.STATION)
print('Mode:\t', 'STATION '..'(mode='..wifi.getmode()..')')
print('MAC Address: ', wifi.sta.getmac())
print('Chip ID: ', node.chipid())
print('Heap Size: ', node.heap(), '\n')

-- provide credentials and make your connection to access point
wifi.sta.config(station_cfg)
print("Connecting to "..AP_NAME.." access point...")
wifi.sta.connect()

-- wait until you get an ip address and then start your application
tmr.create():alarm(1000, tmr.ALARM_AUTO, function(cb_timer)
    if wifi.sta.getip() == nil then
        print("Waiting for IP address...")
    else
        cb_timer:unregister()
        print("WiFi connection established...")
        ip, nm, gw=wifi.sta.getip()
        print("IP Address:\t", ip)
        print("Netmask:\t", nm)
        print("Gateway Address:", gw, '\n')
        print("You have 5 seconds to abort.  Type \"abort=true\".  Waiting...\n")
        tmr.create():alarm(5000, tmr.ALARM_SINGLE, startup)
    end
end)
```

And here is an example output of the application when loaded on the NodeMCU.
It includes the WiFi scan output and
the HTTP output when I entered its HTTP server at `192.168.1.42`.

```
> node.restart()

NodeMCU custom build by frightanic.com
        branch: master
        commit: 22e1adc4b06c931797539b986c85e229e5942a5f
        SSL: false
        modules: file,gpio,http,net,node,tmr,uart,wifi
 build  built on: 2017-04-08 15:45
 powered by Lua 5.1.4 on SDK 2.0.0(656edbf)
Mode:           STATION (mode=1)
MAC Address:    5c:cf:7f:d5:e6:27
Chip ID:        14018087
Heap Size:      41048

Connecting to Home WiFi access point...
> Waiting for IP address...
Waiting for IP address...
WiFi connection established...
IP Address:             192.168.1.42
Netmask:                255.255.255.0
Gateway Address:        192.168.1.1

You have 5 seconds to abort.  Type "abort=true".  Waiting...


                SSID    BSSID                     RSSI          AUTHMODE        CHANNEL
      Download Virus    90:72:40:1b:c4:c6         -86           3               6
             hpsetup    00:1e:0b:55:65:40         -91           0               6
         TRENDnet637    00:14:d1:c3:c0:6f         -86           1               10
               74LL5    48:5d:36:2e:ee:08         -20           3               1
GET / HTTP/1.1
Host: 192.168.1.42
Connection: keep-alive
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8
```

Check [NodeMCU Documentation][57] for the details on what functions are available to you,
as well as [Lua Org site][56] to learn more about the Lua scripting language

## NodeMCU DevKit Breakout
Unlike the pre-loaded Adafruit boards, for the NodeMCU DevKit,
I choose to use the latest firmware available.

```bash
# move to directory containing the firmware
cd ~/Downloads/nodemcu-binary

# generally not required, erase flash on a NodeMCU board
esptool.py --port /dev/ttyUSB0 erase_flash

# determine the manufacturer ID and a chip ID
$ esptool.py --port /dev/ttyUSB0 flash_id
esptool.py v1.3
Connecting....
Manufacturer: c8
Device: 4016

# flash the firmware
# note: flash size of 32m = 32M bits = 32Mb = 4M bytes = 4MB
$ esptool.py --port /dev/ttyUSB0 write_flash -fm dio -fs 32m 0x00000 nodemcu-master-8-modules-2017-04-08-15-46-11-integer.bin
esptool.py v1.3
Connecting....
Running Cesanta flasher stub...
Flash params set to 0x0240
Wrote 405504 bytes at 0x0 in 35.3 seconds (92.0 kbit/s)...
Leaving...
```

The firmware flash will take a little bit of time, but once its done,
you can connect to the ESP8266 via a USB cable and starting up a serial terminal like this:

```bash
# works for the NodeMCU DevKit
screen /dev/ttyUSB0 115200
```

Now reboot the board using the reset switch on the DevKit board.
If all goes well, you should be greeted by a Lua prompt like the following:

```
NodeMCU custom build by frightanic.com
        branch: master
        commit: 22e1adc4b06c931797539b986c85e229e5942a5f
        SSL: false
        modules: file,gpio,http,net,node,tmr,uart,wifi
 build  built on: 2017-04-08 15:45
 powered by Lua 5.1.4 on SDK 2.0.0(656edbf)
lua: cannot open init.lua
>
```





# Upload Code Wirelessly
* [ESP8266 Upload Code Wirelessly!](https://www.youtube.com/watch?v=bplYzg6-_i4)
* [Upload Programs Over the Air (OTA)](https://www.youtube.com/watch?v=GoQXOLB50HA)


# ESP8266 Surveillance Camera
I have been exploring and experiment ways to make a simple spy camera
that could be be battery powered and dropped almost anywhere.

* ESP8266 Camera
    * [JPEG camera + ESP8266](http://www.roboremo.com/jpeg-camera--esp8266.html)
    * [Truly Versatile ESP8266 WiFi Webcam Platform](http://hackaday.com/2016/01/24/truly-versatile-esp8266-wifi-webcam-platform/)
    * [ArduCAM now Supports ESP8266 Arduino Board with WIFI Websocket Camera Demo](http://www.arducam.com/arducam-supports-esp8266-arduino-board-wifi-websocket-camera-demo/)
    * [The GotchaCAM Portable DIY Wifi Camera Based Travel and Home Security and Surveillance System](http://www.arducam.com/)
    * [GitHub for ArduCAM](https://github.com/ArduCAM)
    * http://hackaday.com/2017/04/11/esp32-wifi-hits-10km-with-a-little-help/
        * [more information](https://www.youtube.com/watch?v=yCLb2eItDyE)


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


##########################################################
If you want to build custom NodeMCU firmware for the ESP8266 (Wikipedia) I suggest you don't build it yourself but have it built by this configurable service.
https://nodemcu-build.com/index.php
##########################################################



# Working without ESP8266 Development Board
The sections above take your through the use of an ESP8266 on some for of development board.
But what do you do for a devices like the ESP-01
where you basically just have the process and a WiFi antenna, without an operating system?
This [bare metal environment][77] presents additional challeges.

bla bla bla

# Sources
* Early News Articles
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
    * [GPS Tracker Using NEO 6M and ESP-12](https://www.kolkataonweb.com/code-bank/tag/ai-cloud-inside/)

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
[67]:https://en.wikipedia.org/wiki/FTDI
[68]:http://www.kloppenborg.net/blog/microcontrollers/2016/08/02/getting-started-with-the-esp8266
[69]:https://github.com/esp8266/Arduino
[70]:http://www.esp8266.com/viewforum.php?f=25
[71]:http://hackaday.com/2015/05/01/review-huzzah-is-the-esp8266-wifi-setup-you-need/
[72]:https://en.wikipedia.org/wiki/Real-time_operating_system
[73]:http://platformio.org/
[74]:http://docs.platformio.org/en/latest/what-is-platformio.html
[75]:https://pioplus.com/
[76]:https://en.wikipedia.org/wiki/Microprocessor_development_board
[77]:https://en.wikipedia.org/wiki/Bare_machine
[78]:https://bigdanzblog.wordpress.com/2015/04/24/esp8266-nodemcu-interrupting-init-lua-during-boot/
[79]:https://github.com/nodemcu?tab=repositories
[80]:https://github.com/nodemcu/nodemcu-firmware/releases/download/0.9.6-dev_20150704/nodemcu_integer_0.9.6-dev_20150704.bin
[81]:https://hub.docker.com/r/marcelstoer/nodemcu-build/
[82]:https://www.howtoinstall.co/en/ubuntu/xenial/esptool
[83]:http://manpages.ubuntu.com/manpages/xenial/man1/esptool.1.html
[84]:http://nodemcu.readthedocs.io/en/master/en/build/
[85]:https://github.com/nodemcu/nodemcu-firmware#select-modules
[86]:https://nodemcu-build.com/index.php
[87]:https://nodemcu.readthedocs.io/en/1.5.4.1-final/en/flash/
[88]:https://nodemcu.readthedocs.io/en/1.5.4.1-final/en/flash/#upgrading-firmware
[89]:https://www.adafruit.com/product/247
[90]:https://www.adafruit.com/product/954
[91]:https://www.adafruit.com/products/284
[93]:https://www.adafruit.com/products/70
[94]:
[95]:
[96]:
[97]:
[98]:
[99]:
[100]:

