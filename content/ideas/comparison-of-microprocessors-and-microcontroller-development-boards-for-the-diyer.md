Title: Comparison of Microprocessors and Microcontroller Development Boards for the DIY'er
Date: 2100-01-01 00:00
Category: 
Tags: 
Slug: comparison-of-microprocessors-and-microcontroller-development-boards-for-the-diyer
Author: Jeff Irland
Summary: bla bla bla

Are you feeling confined by the Arduino's limited environment, peripherals, and power?
You're beginning to look around for other options, but your finding there are too many choices?
There are microcontrollers from dozens of vendors in 8-bit, 16-bit, and 32-bit flavors,
each requiring its own compilers and programmers, which could add up to a fortune.
Is there no cheap and viable alternative for the little blue board
that has captured your imagination?

## AVR / Atmel
The [AVR][01] is a [modified Harvard architecture][05] 8-bit RISC single chip microcontroller
which was developed by Atmel in 1996. 
The megaAVR chips became extremely popular after they were designed into the
8-bit Arduino platform in 2005.

* [Arduino](http://arduino.cc/en/Main/Products)

## PIC / Microchip Technology
PIC is a family of modified Harvard architecture microcontrollers made by [Microchip Technology][04] but,
originally developed by General Instrument's Microelectronics Division.
The name PIC initially referred to "Peripheral Interface Controller" now it is "PIC" only.

## ARM / ARM Holding
[ARM][03] is a family of instruction set architectures for computer processors based
on a reduced instruction set computing (RISC)
architecture developed by British company [ARM Holdings][02].
The ARM Cortex-M is a group of 32-bit RISC ARM processor cores licensed by ARM Holdings.
The cores are intended for microcontroller use, and consist of the Cortex-M0, M0+, M1, M3, M4, and M7.
The latest generation of chips, [Cortex-M7][07],
is a 32-bit processor that provides double the compute performance
and digital signal processing (DSP) capability of the previous generation of ARM-based microcontrollers.

In addition, ARM has [announced][08]
a new software platform and free operating system to simplify
and speed up the creation and deployment of Internet of Things (IoT) products
called the [ARM mbed™ IoT Device Platform][09].

* [Teensy 3.1](https://www.pjrc.com/teensy/)
* [BeagleBone](http://beagleboard.org/bone)
* [Freedom](http://mbed.org/platforms/FRDM-KL46Z/)

## Intel
* [Intel Edison Module](http://www.intel.com/content/www/us/en/do-it-yourself/edison.html)

## Feescale
* [UDOO](http://www.udoo.org/)
* [Wandboard](http://www.wandboard.org/)
* [RIoTboard](http://www.riotboard.org/)
* [WaRP](http://www.warpboard.org/)

## Other Processors
* [WRTnode](http://wrtnode.com/) - 
The MT7620 router-on-a-chip includes an 802.11n MAC and baseband,
a 2.4 GHz radio, a 580 MHz CPU, a 5-port 10/100 switch
and two Reduced Gigabit Media Independent Interface (RGMII).
The CPU can process advanced
applications such as routing, security, and VoIP.
The MT7620 also includes a selection of interfaces to support a variety of applications,
such as a USB port for accessing external storage.
* [pcDuino3](http://www.pcduino.com/pcduino-v3/) -
Allwinner Technology is a China-based fabless semiconductor company that designs
mixed-signal [SoC][06] and provides total system solution.


Maybe this is all you need for this post:

* [Open Source Hardware](http://au.mouser.com/applications/open-source-hardware/)
* [Microcontroller Comparison](http://www.makershed.com/pages/microcontroller-comparison)
* [How Intel's Edison Stacks Up Against Arduino And Raspberry Pi](http://readwrite.com/2014/09/10/intel-edison-raspberry-pi-arduino-comparison)
* [The Edison is Not a Raspberry Pi](https://www.sparkfun.com/news/1603?utm_source=SparkFun+Customer+Newsletter&utm_campaign=4dbf6c0ad1-StandardNewsletterSept22-26&utm_medium=email&utm_term=0_fa5287abaf-4dbf6c0ad1-7212537)
* []()

This interactive site contains information on many of the latest open source hardware boards and accessories, including BeagleBone, Arduino, Netduino, STMicroelectronics Nucleo, Texas Instruments LaunchPad, and the Intel Galileo.

The site contains schematic diagrams, technical details, and compatible expansion boards for the most common OSHW boards.

The new site is project oriented, allowing developers to sort and select parametric data for the desired board requirements of their particular project.

Parameters include processor type and speed; number of analog and digital inputs; wireless options including WiFi and Bluetooth; USB ports including host, client, and/or OTG; video connectivity; and more.

* [Processor Boards for IoT](https://iotdc.hackpad.com/Processor-Boards-for-IoT-jBHdtN5BRrZ)
* [Embedded Linux board comparison chart and more!](http://www.adafruit.com/blog/2014/05/06/embedded-linux-board-comparison-chart-and-more/)
* [Fubarino SD Development Board](http://www.microchip.com/stellent/idcplg?IdcService=SS_GET_PAGE&nodeId=1406&dDocName=en566210)
* [iMX233-OLinuXino-NANO](https://www.olimex.com/Products/OLinuXino/iMX233/iMX233-OLinuXino-NANO/)
* [TE-TM4C123](http://community.arm.com/docs/DOC-8010)
* [TinyDuino](https://tiny-circuits.com/products/tinyduino/)
* [MinnowBoard](http://www.minnowboard.org/)
* [ODROID-U3](http://hardkernel.com/main/main.php)
* [MSP430 Launchpad](http://embedded-lab.com/blog/?p=4114&mid=5508)
* [HummingBoard](http://imx.solid-run.com/wiki/index.php?title=HummingBoard_Hardware)
* [CuBox-i](http://cubox-i.com/)
* [chipKIT Uno32](https://digilentinc.com/Products/Detail.cfm?NavPath=2,892,893&Prod=CHIPKIT-UNO32)
* [BananaPi](http://bananapi.org/)
* [CubieTruck](http://www.cubietruck.com/)
* [Tiva C Series Connected LaunchPad](http://www.automationworld.com/control/prototype-internet-things-apps-20)
* [Tiniest Linux COM yet - OpenWRT Linux on a MIPS-based Ralink RT5350 SoC](http://linuxgizmos.com/tiniest-linux-com-yet/)
* [WeIO - Tiny open-source module aims to make IoT apps easy](http://linuxgizmos.com/tiny-open-source-module-aims-to-make-iot-apps-easy/)
* [P-Star 25K50 Micro](http://www.pololu.com/product/3150)
* [ARM-BMW, The Open Hardware Cortex-M0 Development Board](http://theanine.io/projects/arm-bmw/)
* [Radxa](http://radxa.com/)
* [CuBox](http://www.solid-run.com/product/cubox-i2/)

| Board | Processor | Flash Memory | RAM Memory | EEPROM | I/O | Analog In | PWM | UART, I2C, SPI |
|:------|:---------:|:------------:|:----------:|:------:|:---:|:---------:|:---:|:------------:|
|Teensy 3.1|MK20DX25, 32 bit ARM Cortex-M4, 72 MHz|262144|65536|2048|34, 3.3V, 5V|21|12|32, 2, 1|

Wireless Enabled

* [RFduino](http://www.rfduino.com/)
* [Blend Micro - an Arduino Development Board with BLE](http://www.seeedstudio.com/depot/Blend-Micro-an-Arduino-Development-Board-with-BLE-p-1834.html?utm_source=EDM20140520&utm_medium=EDM20140520&utm_campaign=EDM20140520)
* [VoCore: A coin-sized Linux computer with wifi](https://www.indiegogo.com/projects/vocore-a-coin-sized-linux-computer-with-wifi#home)
* [JeeNode](http://jeelabs.net/projects/hardware/wiki/JeeNode)
* [ATmega128RFA1](https://www.sparkfun.com/products/11197)
    * [ATmega128RFA1 Dev Board Hookup Guide](https://learn.sparkfun.com/tutorials/atmega128rfa1-dev-board-hookup-guide)
    * [TinyOS](http://www.tinyos.net/)
* [WiDo - Arduino Compatible + WiFI IoT Node](http://www.dfrobot.com/index.php?route=product/product&product_id=1159&utm_medium=email&utm_campaign=September+is+great%2C+here%27s+why&utm_source=YMLP&utm_term=image+576)
* [Waspmote](http://www.cooking-hacks.com/documentation/tutorials/waspmote)
* [Moteino](https://lowpowerlab.com/shop/index.php?_route_=Moteino-R4)
* [Energia](http://www.element14.com/community/people/janisalnis/blog/2014/09/13/energia-is-out-there-for-cc3200)
* []()

[01]:http://en.wikipedia.org/wiki/Atmel_AVR
[02]:http://en.wikipedia.org/wiki/ARM_Holdings
[03]:http://en.wikipedia.org/wiki/ARM_architecture
[04]:http://en.wikipedia.org/wiki/Microchip_Technology
[05]:http://en.wikipedia.org/wiki/Modified_Harvard_architecture
[06]:http://en.wikipedia.org/wiki/System_on_a_chip
[07]:http://venturebeat.com/2014/09/23/arm-aims-to-put-real-brains-in-devices-for-internet-of-things/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+Venturebeat+VentureBeat
[08]:http://www.arm.com/about/newsroom/arm-announces-device-platform-and-free-os-to-accelerate-internet-of-things-deployment.php
[09]:http://mbed.org/
[10]:
[10]:

