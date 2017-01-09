
* [RedBearLab Discussion forum](http://discuss.redbear.cc/)


There are [three options][05] to program your [BLE Nano with MK20 USB board][04]:

1. [Arduino Library for nRF51822](https://github.com/RedBear/nRF51822-Arduino)
    * Video Tutorial: [RedBear BLE Nano Quick Start with Arduino IDE](https://www.youtube.com/watch?v=d75strWav5k&feature=youtu.be)
1. [Nordic nRF51822 BLE SDK](https://developer.nordicsemi.com)
1. [mbed's Bluetooth Low Energy API](http://developer.mbed.org/teams/RedBearLab/)

While it is possible to upload firmware to a BLE Nano without using a MK20 USB board,
(via special debugger hardware [JLink][03]),
most instructions for the BLE Nano assumes you have a MK20 USB board by RedBearLab.



Nordic [nRF51822 SoC][01] supports Bluetooth low energy protocol stacks
and is built around a 32-bit ARM Cortex M0 CPU with 256kB/128kB flash + 32kB/16kB RAM
The embedded 2.4GHz transceiver supports both Bluetooth low energy
and the [Nordic Gazell 2.4 GHz protocol stack][02] which is on air compatible
with the nRF24L series products from Nordic Semiconductor.




[RedBear IoT pHAT provides both BLE and WiFi](https://redbear.cc/product/rpi/iot-phat.html),
designed for the Raspberry Pi Zero (other RPi boards with 40-pin header will also work).

[Bluefruit LE Friend - Bluetooth Low Energy (BLE 4.0) - nRF51822 - v2.0](https://www.adafruit.com/product/2267?gclid=CjwKEAiA1vjCBRDd-9q3w4OF6WUSJACWv_sVbsEecu1xm43PB7VQqLwQfFM2rZchpBigtlcFETwQkBoCASLw_wcB)



[01]:https://www.nordicsemi.com/eng/Products/Bluetooth-low-energy/nRF51822
[02]:https://devzone.nordicsemi.com/documentation/nrf51/4.1.0/html/index.html
[03]:https://www.adafruit.com/product/1369
[04]:https://redbear.cc/product/ble/ble-nano-kit.html
[05]:http://redbearlab.com/blenano/
[06]:
[07]:
[08]:
[09]:
[10]:
