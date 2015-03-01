<a href="https://www.apc.com/products/resource/include/techspec_index.cfm?base_sku=BN1080G&tab=documentation">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="APC Back-UPS 1080 Provides Battery Backup & Surge Protector for Electronics and Computers (Front Image)" alt="WABAC Pic" src="/images/APC_Back-UPS_NS_1080_front.jpg" />
</a>
<a href="https://www.apc.com/products/resource/include/techspec_index.cfm?base_sku=BN1080G&tab=documentation">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="APC Back-UPS 1080 Provides Battery Backup & Surge Protector for Electronics and Computers (Back Image)" alt="WABAC Pic" src="/images/APC_Back-UPS_NS_1080_back.jpg" />
</a>
I purchased a [APC Back-UPS NS 1080][05] to smooth out the power dips that
are far too frequent in my home.
This product comes with the [PowerChute][06] software to provide safe system shutdown
in the event of an extended power outage.
Unfortunately, this software isn't supported on Linux,
but there is an alternative to PowerChute.

[`apcupsd`][02] (the name stands for APC UPS Daemon) is a [daemon][01] that runs on Linux
that allows the computer to interact with (almost all recent)
[American Power Conversion Corp (APC)][03]
[uninterruptible power supplies (UPS)][04].
During a power failure, `apcupsd` informs users about the loss of utility power
and that a shutdown may occur.
If utility power is not restored,
a system shutdown will follow when the battery is exhausted, a specified timeout expires,
a specified battery charge percentage is reached,
or a specified battery runtime
(based on internal UPS calculations and determined by power consumption rates) expires.
If the utility power is restored before one of the these shutdown conditions is met,
`apcupsd` will inform users of this and the shutdown will generally be cancelled.

# Installation
For my UPS,
the  `apcupsd` daemon will be communnicating with the UPS via a USB connection.
To make sure that your USB subsystem can see the UPS,
just do this from a shell prompt (output included):

```bash
# the lsusb command can show you the hubs connected to your system
$ lsusb | grep American

Bus 003 Device 005: ID 051d:0002 American Power Conversion Uninterruptible Power Supply
```

## Device File Name for the UPS
Under Linux, each and every hardware device, including USB ports,
are treated as a file and call a [device file][07].
A device file allows a user to access hardware devices,
but shields the users from the technical details about the hardware.
A conventional serial port will typically have a device file such as
`/dev/ttyS0`, `/dev/ttyS1`, etc. but a USB serial ports can appear as
`/dev/ttyUSB0`, `/dev/ttyUSB1`, etc. or even appear in `/dev/usb`.

When your device is plugged in, Linux assigns the device file name
as it sees fit and isn’t always predicable ([it doesn’t have to be this way][08]).
From the output of `lsusb`, you can deduce what device file your serial device is connected too.
The string `Bus 003 Device 005` and a search of the directory `/dev/bus`
tells you that the device file is `/dev/bus/usb/003/005`.

Linux creates device nodes dynamically on the fly as they are needed.
It is basically a hotplug system, freeing the user from  making node assignments,
but also means you have to search around to find where Linux put your device file.
The `apcupsd` takes care of all this, so you don't need to create a
[persistent device name][08].

Never the less, if your curious about where things are located,
running of the `lsusb` command above tells us 
UPS's VendorID:ProductID pair is `051d:0002`.
Using the `udevadm info -a -n /dev/bus/usb/003/005` command,
you conclude that the serial number of the device is `0000:00:14.0`.
See below: (command and output)

```bash
# get the serial number of the UPS device
udevadm info -a -n /dev/bus/usb/003/005 | grep ATTRS{serial}

    ATTRS{serial}=="0000:00:14.0"
```

Armed with this information and following guidance from [this post][09],
I could have update the [UDEV rules][08].
**Don't do this**, since I believe it will cause problems with `apcupsd`.
It appears that the daemon is designed to deal with all this.

## Installing and Configuring the UPS Daemon
The `apcupsd` daemon is easy to install
and is well documented at "[apcupsd - Official Ubuntu Documentation][10]".
If you want to see the stat of the UPS through the browser,
you can also install `apcupsd-cgi` package.

```bash
# install the apcupsd daemon and browser package
sudo apt-get install apcupsd apcupsd-cgi
```

Next you edit the `apcupsd` configuration file `/etc/apcupsd/apcupsd.conf`.
Here are the modifications I made to this file:

```bash
# UPS name, max 8 characters 
UPSNAME HOME_UPS

# Defines the type of cable connecting the UPS to your computer.
UPSCABLE usb

# the type of UPS you have
UPSTYPE usb

# with a usb type UPS apcupsd can autodetect the device,
# so you should comment out the DEVICE setting 
#DEVICE /dev/ttyS0

# UPS should do a self test every two weeks
SELFTEST 336
```

Now you must edit the file `/etc/default/apcupsd`.

```bash
# Defaults for apcupsd initscript

# Apcupsd-devel internal configuration
APCACCESS=/sbin/apcaccess
ISCONFIGURED=yes
```

# Starting Things Up
To start/stop the `apcupsd` daemon manually, just execute this command:

```bash
# start the apcupsd daemon
sudo /etc/init.d/apcupsd start

# stop the apcupsd daemon
sudo /etc/init.d/apcupsd stop
```

The UPS daemon can be manual started/stopped, but also,
the command `/etc/init.d/apcupsd` is automatically invoked at system startup and shutdown
and is governed by the [`chkconfig`][11] procedures.

To get a snapshot of the UPS's status, run the command `apcaccess status`.

See the output below:

```bash
# UPS status check
$ apcaccess status
APC      : 001,036,0901
DATE     : 2015-02-07 10:59:40 -0500  
HOSTNAME : desktop
VERSION  : 3.14.10 (13 September 2011) debian
UPSNAME  : desktop
CABLE    : USB Cable
DRIVER   : USB UPS Driver
UPSMODE  : Stand Alone
STARTTIME: 2015-02-07 10:59:39 -0500  
MODEL    : Back-UPS NS1080G 
STATUS   : ONLINE 
LINEV    : 121.0 Volts
LOADPCT  :  20.0 Percent Load Capacity
BCHARGE  : 100.0 Percent
TIMELEFT :  36.1 Minutes
MBATTCHG : 5 Percent
MINTIMEL : 3 Minutes
MAXTIME  : 0 Seconds
SENSE    : Medium
LOTRANS  : 088.0 Volts
HITRANS  : 142.0 Volts
ALARMDEL : 30 seconds
BATTV    : 27.0 Volts
LASTXFER : No transfers since turnon
NUMXFERS : 0
TONBATT  : 0 seconds
CUMONBATT: 0 seconds
XOFFBATT : N/A
SELFTEST : NO
STATFLAG : 0x07000008 Status Flag
SERIALNO : 3B1405X05714  
BATTDATE : 2014-01-28
NOMINV   : 120 Volts
NOMBATTV :  24.0 Volts
NOMPOWER : 650 Watts
FIRMWARE : 914.L2   .D USB FW:
END APC  : 2015-02-07 10:59:43 -0500 
```

This shows that the UPS daemon is configured to do the following thing:

MBATTCHG : 5 Percent
:   If the battery charge percentage (BCHARGE) drops below this value,
    apcupsd will shutdown your system. Value is set in the configuration file (BATTERYLEVEL).
MINTIMEL : 3 Minutes
:   apcupsd will shutdown your system if the remaining runtime equals or is below this point.
    Value is set in the configuration file (MINUTES).
MAXTIME  : 0 Seconds
:   apcupsd will shutdown your system if the time on batteries exceeds this value.
    A value of zero disables the feature. Value is set in the configuration file (TIMEOUT).

These parameters say something about how the UPS is perfroming
(see [apcupsd Status Logging][13] section in the apcupsd User Manual):

STARTTIME: 2015-02-07 10:59:39 -0500
:   The time/date that `apcupsd` was started.
STATUS   : ONLINE 
:   The current status of the UPS (ONLINE, ONBATT, etc.)
LINEV    : 121.0 Volts
:   The current line voltage as returned by the UPS.
LOADPCT  :  20.0 Percent Load Capacity
:   The percentage of load capacity as estimated by the UPS.
BCHARGE  : 100.0 Percent
:   The percentage charge on the batteries.
TIMELEFT :  36.1 Minutes
:   The remaining runtime left on batteries as estimated by the UPS.
LOTRANS  : 088.0 Volts
:   The line voltage below which the UPS will switch to batteries.
HITRANS  : 142.0 Volts
:   The line voltage above which the UPS will switch to batteries.
SELFTEST : NO
:   The results of the last self test, and may have the following values:
    * OK - self test indicates good battery
    * BT - self test failed due to insufficient battery capacity
    * NG - self test failed due to overload
    * NO - No results (i.e. no self test performed in the last 5 minutes)

# Notification and Events
When a major event is generated within `apcupsd`,
control is passed to the script `/etc/apcupsd/apccontrol`.
The event name, and a number of other important parameters are passed to the script.
The major function of the `apccontrol` script is to perform a shutdown of the system
(as well as the killpower operation).
Another major task for this script is to notify you by email
when certain events such as powerfail occur.

Since `apccontrol` is a script,
you can customize it to your own needs using any text editor.
In addition, another feature is that you can write your own scripts
that will be automatically called by `apccontrol` before any of its own code is executed.
For more details, see the [apcupsd User Manual][12].

My `apccontrol` script looks like this
(**WARNING -** The `apccontrol` script will be overwritten every time you update
your `apcupsd`, when doing `make install`):

```bash
```

I have modified the `apccontrol` script to use the push notification utility `apprase`,
which leverages the [Pushover][14] service.
The `apprase` script is the following:

```bash
```

# UPS Test Program
`apctest` is a program that runs low-level tests to check the operation of the UPS,
checks that your `apcupsd` configuration is correctly setup,
and assures you can establish communication with the UPS.

When run, `apctest` displays a menu of options.
Also, `apctest` saves a transcript of the session to the file `apctest.out`
in the directory from which the program was called.

>**IMPORTANT:** Before running `apctest`
 Check that the UPSCABLE, UPSTYPE and DEVICE configuration directives in the
`/etc/apcupsd/apcupsd.conf`
configuration file have been set appropriately;
and **shutdown `apcupsd`** via `sudo /etc/init.d/apcupsd stop` if it is running.
You cannot run both `apcupsd` and `apctest` at the same time.

[apctest - apcupsd test program](http://linux.die.net/man/8/apctest)

# Sources
For more information and details, check out the following:

* [APC UPS Daemon](http://www.apcupsd.org/)
* [apcupsd User Manual](http://www.apcupsd.com/manual/manual.html)
* [Linux: Configure and Control APC SmartUPS During a Power Failure](http://www.cyberciti.biz/faq/debian-ubuntu-centos-rhel-install-apcups/)
* [Configuring Linux Ubuntu 10.04 LTS for APC UPS Network Shutdown](http://www.cloudportal.org/2012/03/07/installing-apc-ups-powerchute-network-shutdown-3-0-0-on-ubuntu-10-04-lts/)
* [apcupsd.conf is the configuration file for the apcupsd program](http://linux.die.net/man/5/apcupsd.conf)
[apcupsd - a daemon for controlling most APC UPS](http://linux.die.net/man/8/apcupsd)



[01]:http://en.wikipedia.org/wiki/Daemon_(computing)
[02]:http://en.wikipedia.org/wiki/Apcupsd
[03]:http://www.apc.com/
[04]:http://en.wikipedia.org/wiki/Uninterruptible_power_supply
[05]:https://www.apc.com/products/resource/include/techspec_index.cfm?base_sku=BN1080G&tab=documentation
[06]:http://www.apc.com/products/family/?id=129
[07]:http://en.wikipedia.org/wiki/Device_file
[08]:http://hintshop.ludvig.co.nz/show/persistent-names-usb-serial-devices/
[09]:http://hackaday.com/2009/09/18/how-to-write-udev-rules/
[10]:https://help.ubuntu.com/community/apcupsd
[11]:http://linux.die.net/man/8/chkconfig
[12]:http://www.apcupsd.com/manual/manual.html#apcupsd-notification-and-events
[13]:http://www.apcupsd.com/manual/manual.html#apcupsd-status-logging
[14]:https://pushover.net/
[15]:
[16]:
[17]:
[18]:
