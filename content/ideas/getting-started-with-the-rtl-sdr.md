Check out [Listen to the Globe](http://hackaday.com/2017/01/02/listen-to-the-globe/)

* [Using the RTL-SDR in the Pothos Dataflow Processing Platform](http://www.rtl-sdr.com/using-rtl-sdr-pothos-dataflow-processing-platform/)
* [csdr - build DSP processing chains by shell pipes](https://github.com/simonyiszk/csdr)
* [Sniffing ANT-FS with an RTL-SDR and MMDS Downconverter in Pothos](http://www.rtl-sdr.com/sniffing-ant-fs-with-an-rtl-sdr-and-mmds-downconverter-in-pothos/)
* [SDR (Software Defined Radio)](http://osmocom.org/projects/sdr/wiki/rtl-sdr)

# Selecting a RTL-SDR
[RTL-SDR.COM][15] is an excelent souce for the latest intell on the RTL-SDR,
and provides several guides aimed at helping you set-up your RTL-SDR.
This includea a [Quick Start Guide][16], [RTL-SDR Buyers Guide][17],
and a large set of [Tutorials][18].
Anothe excellent source is [Radio for Everyone][19].

* [An Introductory Project for Software Defined Radio](https://www.allaboutcircuits.com/projects/an-introductory-project-for-software-defined-radio/?utm_source=All+About+Circuits+Members&utm_campaign=e01676fafa-EMAIL_CAMPAIGN_2017_02_08&utm_medium=email&utm_term=0_2565529c4b-e01676fafa-270523833/)
* [Buy RTL-SDR Dongles](http://www.rtl-sdr.com/buy-rtl-sdr-dvb-t-dongles/)
* [Getting Started with RTL-SDR and SDR-Sharp](https://cdn-learn.adafruit.com/downloads/pdf/getting-started-with-rtl-sdr-and-sdr-sharp.pdf)
* [RTLSDR4Everyone: The best RTL-SDR setup for $60](http://www.rtl-sdr.com/rtlsdr4everyone-the-best-rtl-sdr-set-up-for-60/)
* [RTL_SDR Blog V3 Dongles User Guide](http://www.rtl-sdr.com/rtl-sdr-blog-v-3-dongles-user-guide/)
* [The Hobbyist's Guide to the RTL-SDR: Really Cheap Software Defined Radio](https://www.amazon.com/gp/product/B00KCDF1QI/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00KCDF1QI&linkCode=as2&tag=book0674-20&linkId=RSP53QLYXP4IS32X)
* [RTL_SDR for Linux Quick Start Guide](http://www.rtl-sdr.com/a-good-quickstart-guide-for-rtl-sdr-linux-users/)

# Setup
* [New Linux RTL-SDR Driver with Fully Exposed Controls](http://www.rtl-sdr.com/new-linux-rtl-sdr-driver-with-fully-exposed-controls/)
* [Raspberry Pi SDR](http://hackaday.com/2017/01/27/raspberry-pi-sdr/)

# Installing GNU Radio

# Lows Noise Amplifier (LNA)
[Why use a Preamp?](http://www.radioforeveryone.com/p/why-use-preamp.html)
* [LNA4All](http://lna4all.blogspot.com/)
* [Review - LNA4ALL](http://www.radioforeveryone.com/p/summary-buy-one-works-as-advertised.html)
* [Review: LNA4ALL Antenna Amplifier](http://www.radioforeveryone.com/2013/08/antenna-amplifier.html)
* [INSMA 0.1-2000MHz RF Wideband Amplifier 30dB low-noise LNA Broadband Module Receiver](https://www.amazon.com/INSMA-0-1-2000MHz-Amplifier-low-noise-Broadband/dp/B01D5RRT0I/ref=sr_1_2?s=electronics&ie=UTF8&qid=1483585185&sr=1-2&keywords=lna)

## Bias Tee
Bias-T is nothing more than a simple diplexer.

* [DIY Bias-T](http://lna4all.blogspot.com/2014/11/diy-bias-t.html)
* [RTL-SDR Bias Tee Hack](http://www.rtl-sdr.com/rtl-sdr-bias-tee-hack/)

http://forums.solidsignal.com/showthread.php/167-Diplexer-Splitter-Combiner-What-are-these-things

# Tuning the RTL-SDR for Optimal Use
You'll find that the dongle is limited by the following:

* frequency offset
* quality of the antenna
* sample rate you can obtain
* bandwidth of the device
* A/D bit resolution

Improving the Quality of the Antenna

* [Antenna-Theory.com][01]
* [Broadband Discone Antenna][02]
* [VE3SQB ANTENNA DESIGN PROGRAMS][03]
* [D.I.Y. Discone for RTLSDR][04]
* [Understanding Antenna Specifications and Operation](http://www.digikey.com/en/articles/techzone/2011/mar/understanding-antenna-specifications-and-operation)

## Determining Your Dongles Frequency Off-Set
Once you start playing around with any of the RTL-SDR dongles and some of the Software Defined Radio (SDR) tools out there, you observer that the frequency settings/readings your using don't make sense.
In fact, they seem to be way off, like tens of kHz off!  So any attempt to tune into a specific local radio station (like this for example:
`rtl_fm -W -f 99.5M | play -r 32k -t raw -e signed-integer -b 16 -c 1 -V1 -`) can often produce a very noisy / distorted signal or nothing intelligent at all.
One of the root cause of this is the low quality local oscillator used on the dongles.e
These oscillators frequency are engineered for a specific value (28.8MHz in the case of the RTL2832U-based USB DVB-T adapters dongle like mine) but will vary significantly among the device manufactured (it will also drift with temperature).

Now if you know how far off your dongles oscillators frequency was from its specification value, then you could compensate for it.
So in my `rtl_fm` example above, you would adjust the `-f 99.5M` parameter to compensate for the off-set.
Each unique device has its own off-set, so how do you determine your devices off-set?
Thanks to the [work of  Joshua Lackey and Steve Markgraf][05], there exist a tool to calculate this value.
That tool is called [kalibrate, or kal][06] (actually, we be using [kalibrate-rtl][07]
which is a fork of the software from [kalibrate][08]
and specifically designed for the RTL-SDR dongles) uses the precise known frequencies of used within GSM base stations to calculate the local oscillator frequency offset.
GSM base stations timing is required to be very accurate (to within 0.05 ppm), so if we can measure the dongles frequency relative to this very stable GSM frequency, we have an accurate measure of our dongles off-set.

In fact, there is a [video][09] on how to use this tool with RTL-SDR dongles.

``` bash
cd ~/src
git clone git://github.com/steve-m/kalibrate-rtl.git
cd kalibrate-rtl
./bootstrap &amp;&amp; CXXFLAGS='-W -Wall -O3'
./configure
make
```

I did the commands below because "make install" failed
``` bash
cd src
/usr/bin/install -c kal '/home/jeff/bin'
```

Data captured using kalibrate-rtl:

```
kal -s GSM850 --> channel 238 --> kal -c 238 --> -891.2MHz   30.254 ppm, -20.256 ppm
kal -s GSM900 --> channel 989 --> kal -c 989 --> 928.0MHz   26.225 ppm, 26.023 ppm
kal -s GSM900 --> channel 991 --> kal -c 991 --> 928.4MHz   7.793 ppm, -1.919 ppm
kal -s GSM900 --> channel 998 --> kal -c 998 --> 929.8MHz   1.712 ppm, 2.508 ppm
```

Baried with in the http://superkuh.com/

frequency offset

Kalibrate-RTL

[RTLSDR Scanner](http://eartoearoak.com/software/rtlsdr-scanner) is a simple cross platform python based spectrum analyzer for the RTL-SDR. The scanner also has an auto calibration feature which can help find the PPM offset of a dongle.

[HOW TO CALIBRATE RTL-SDR USING KALIBRATE-RTL ON LINUX][10]

<strong>Improving Your Dongles Antenna</strong>

[Home Made Coat Hanger Discone][11]

Improving Your SDR Radio

* [Adding more frequencies to your software defined radio][12]
* [Improving a software defined radio with a few bits of wire][13]
* [RTL-SDR Improvement Tips][14]

# RTL-SDR Based Tools
* [RFTap: A Bridge Between GNURadio and Wireshark](http://www.rtl-sdr.com/rftap-a-bridge-between-gnuradio-and-wireshark/)
* [SDRDue: New Software for Passive Radar with Two Coherent RTL-SDR Dongles](http://www.rtl-sdr.com/sdrdue-new-software-for-passive-radar-with-two-coherent-rtl-sdr-dongles/)
* [SDR Spectrum Grabber](http://hackaday.com/2016/11/18/cache-shortwave-signals-for-later-with-this-sdr-spectrum-grabber/)
* [Reverse Engineering Signals with the Universal Radio Hacker Software](http://www.rtl-sdr.com/reverse-engineering-signals-universal-radio-hacker-software/)

# Projects
* [Using MATLAB and SDR to Reverse Engineer 433MHz Messages](http://hackaday.com/2015/02/16/using-matlab-and-sdr-to-reverse-engineer-433mhz-messages/)
* [Building A LoRa PHY With SDR](http://hackaday.com/2016/11/18/building-a-lora-phy-with-sdr/)
* [WSPR reception setup using RTL-SDR dongle V3](https://docs.google.com/document/d/10_xEGW_tdC7LhA-5_UE7ZmgMfPv4ySvz6DQrv02X4ek/mobilebasic)
* [RTL-SDR Tutorial: GPS Decoding and Plotting](http://www.rtl-sdr.com/rtl-sdr-tutorial-gps-decoding-plotting/)



[01]:http://www.antenna-theory.com/
[02]:http://www.ramseyelectronics.com/downloads/manuals/DA25.pdf
[03]:http://www.ve3sqb.com/
[04]:http://helix.air.net.au/index.php/d-i-y-discone-for-rtlsdr/
[05]:https://github.com/steve-m/kalibrate-rtl
[06]:http://thre.at/kalibrate/
[07]:https://github.com/steve-m/kalibrate-rtl
[08]:http://thre.at/kalibrate/
[09]:http://www.youtube.com/watch?v=VaKzhaf5iKg
[10]:http://www.securitytube.net/video/7726
[11]:http://www.rtl-sdr.com/home-made-coat-hanger-discone/
[12]:http://hackaday.com/2012/07/08/adding-more-frequencies-to-you-software-defined-radio/
[13]:http://hackaday.com/2012/05/14/improving-a-software-defined-radio-with-a-few-bits-of-wire/
[14]:http://www.ab9il.net/software-defined-radio/rtl2832-sdr.html
[15]:http://www.rtl-sdr.com/
[16]:http://www.rtl-sdr.com/rtl-sdr-quick-start-guide/
[17]:http://www.rtl-sdr.com/buy-rtl-sdr-dvb-t-dongles/
[18]:http://www.rtl-sdr.com/category/tutorial/
[19]:http://www.radioforeveryone.com/p/reducing-electrical-noise.html
[20]:

