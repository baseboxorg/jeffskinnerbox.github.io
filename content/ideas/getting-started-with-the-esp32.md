
* [The Internet of Things with ESP32](http://esp32.net/)
* [Installing the ESP32 Arduino Core](https://learn.sparkfun.com/tutorials/esp32-thing-hookup-guide#installing-the-esp32-arduino-core)
* [Over-the-air updating an ESP32](https://blog.classycode.com/over-the-air-updating-an-esp32-29f83ebbcca2)
* [Secure over-the-air updates for ESP32](https://blog.classycode.com/secure-over-the-air-updates-for-esp32-ec25ae00db43)
* [ESP32 AT Instruction Set and Examples - Espressif Systems](https://espressif.com/sites/default/files/documentation/esp32_at_instruction_set_and_examples_en.pdf)

# Background
The ESP32 is a low cost, low power microcontroller with integrated 2.4 GHz WiFi (up to 150Mbps)
and dual-mode Bluetooth (classic and BLE),
which employs a dual-core Tensilica Xtensa LX6 microprocessor.
The ESP32 is a successor to the ESP8266 microcontroller,
and like the ESP8266, the ESP32 is created and developed by Espressif Systems,
a Shanghai-based Chinese company.
This chip includes almost everything you’ll need to begin programming the WiFi/Bluetooth SoC
and to create IoT applications.

* ESP32 Key Features
    * 240 MHz dual-core Tensilica LX6 microcontroller with performing at up to 600 DMIPS
    * integrated 520 KB SRAM
    * integrated 802.11/b/g/n HT40 Wi-Fi transceiver,  baseband,  stack and LWIP
    * integrated dual mode Bluetooth (classic and BLE)
    * 16 MB Flash
    * 2.2V to 3.6V operating voltage
    * -40°C to +125°C operating temperature
    * on-board PCB antenna / IPEX connector for external antenna
    * supports sniffer, station, SoftAP and WiFi direct modes
* ESP32 Peripheral Interfaces
    * 12-bit ADC up to 18 channels
    * 2x 8-bit DACs
    * 10x capacitive touch interface
    * Temperature sensor
    * 3x SPI
    * 2x I²S
    * 2x I²C
    * 3x UARTs, including hardware flow control
    * SD/SDIO/MMC host
    * SDIO master/slave 50 MHz
    * Ethernet MAC interface with dedicated DMA and IEEE 1588 support
    * CAN bus 2.0
    * IR (TX/RX)
    * PWM/timer input/output available on every GPIO pin
    * Hall effect sensor
    * Ultra low power and low noise analog amplifier
* ESP32 Security
    * WEP, WPA/WPA2 PSK/Enterprise
    * Hardware accelerated encryption: AES / SHA2 / Elliptical Curve Cryptography / RSA-4096
* ESP32 Performance
    * Max data rate of 150 Mbps@11n HT40, 72 Mbps@11n HT20, 54 Mbps@11g, and 11 Mbps@11b
    * Maximum transmit power of 19.5 dBm@11b, 16.5 dBm@11g, 15.5 dBm@11n
    * Minimum receiver sensitivity of -98 dBm
    * 135 Mbps UDP sustained throughput
    * 2.5 μA deep sleep current
* Resources
    * [ESP32 Datasheet (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32_datasheet_en.pdf)
    * [ESP32 Technical Reference Manual](https://espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf)
    * [ESP32 Pinout v1.0]()
    * [ESP32 Pin List]()
    * [ESP32 Hardware Design Guidelines](https://espressif.com/sites/default/files/documentation/esp32_hardware_design_guidelines_en.pdf)
    * [ESP32 RTOS SDK API Reference](https://github.com/espressif/ESP31_RTOS_SDK/tree/master/documents)
    * [ESP32 Other Resources (Espressif/Documentation)](https://espressif.com/en/products/hardware/esp32/resources)
    * [ESP32 Other Resources (esp32.net)](http://esp32.net/)

# Toolchain
The Espressif Internet Development Framework (ESP-IDF) is core development tool-chain for the ESP32 chip. It includes the compiler, programming tools and various software components that enable software development on the chip.

* [How to Get Started with the ESP32](http://hackaday.com/2016/10/04/how-to-get-started-with-the-esp32/)
* [ESP32 Toolchain Setup on Ubuntu](http://iot-bits.com/esp32/esp32-toolchain-setup/)
* [ESP32 – building the toolchain for Linux (Ubuntu)](http://blog.podkalicki.com/esp32-building-the-toolchain-for-linux-ubuntu/)

# AWS IoT with ESP32 and Mongoose OS
See - https://madcow-public.s3.amazonaws.com/iot_loft_guide.pdf
and - https://www.slideshare.net/AmazonWebServices/rapid-prototyping-with-aws-iot-and-mongoose-os-on-esp8266-esp32-and-cc3200-platforms

Prerequisites
* AWS CLI configured with valid credentials in the AWS account that you intend to use
    * http://docs.aws.amazon.com/cli/latest/userguide/installing.html
* ESP32 Dev board
    * A (good!) USB cable to connect the ESP32 board to your computer
    * mos – The Mongoose OS flashing tool. Download at http://www.mongoose-os.com
* git clone of the Mongoose OS repository from GitHub:
    * git clone https://github.com/

