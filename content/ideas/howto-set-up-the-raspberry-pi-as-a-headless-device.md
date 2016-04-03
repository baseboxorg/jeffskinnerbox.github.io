<a href="http://www.raspberrypi-spy.co.uk/2015/11/raspberry-pi-family-photo-by-raspi-tv/">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="The Raspberry Pi is a series of credit card–sized single-board computers developed in England, United Kingdom by the Raspberry Pi Foundation with the intent to promote the teaching of basic computer science in schools and developing countries." alt="rpi family" src="{filename}/images/rasperbby-pi-family.jpg" width="175" height="117" />
</a>
I have set up all my Raspberry Pi's as [headless devices][01].
For one thing, I want to SSH into my devices so I don't want
or need a monitor/keyboard.
But the real trick is being headless even when doing the initial setup of the device,
without an HDMI monitor or a keyboard / mouse.
Using just a SD Card reader/writer, a USB WiFi adapter,
and a Linux machine, I will do the whole setup.

By the way, if you want to make an existing Raspberry Pi headless,
you don't need to follow this whole procedure.
Just make sur SSH is working and follow Step 3.
If you want to also upgrade your existing Raspberry Pi OS to the latest version,
check out the article "[Raspbian GNU/Linux upgrade from Wheezy to Raspbian Jessie 8][11]".

# Step 1: Download Raspberry Pi Image - DONE
Before you can load a copy of the latest Raspberry Pi image onto your micro SD Card,
you must first download the official Raspberry Pi operating system, [Raspbian][03]
(in my case, the version is [Jessie][10]).
You can get that download [here][02].

The Raspbian download site also lists a check sum for the download file.
(In my case, I down loaded the Raspbian file to `/home/jeff/Downloads/`.)
Check whether the file has been changed from its original state
by checking its digital signature (SHA1 hash value).

```bash
# validate file is uncorrupted via check of digital signature
$ sha1sum /home/jeff/Downloads/2016-02-09-raspbian-jessie.zip
da329713833e0785ffd94796304b7348803381db  /home/jeff/Downloads/2016-02-09-raspbian-jessie.zip
```

Next you need to unzip the file to retrieve the Linux image file:

```bash
$ unzip 2016-02-09-raspbian-jessie.zip
Archive:  2016-02-09-raspbian-jessie.zip
  inflating: 2016-02-09-raspbian-jessie.img
```

# Step 2: Write Raspberry Pi Image to SD Card - DONE
Next using Linux, you have copied the Raspbian image onto the SD card mounted to your system.
I'll be using the [Rocketek 11-in-1 4 Slots USB 3.0 Memory Card Reader][04] to create my SD Card.
Make sure to [choose a reputable SD Card][05] from [here][13], don't go cheap.

When using your card reader,
you'll need to know the device name of the reader.
The easiest way to find this is just unplug your card reader from the USB port,
run `df -h`, then plug it back in, and run `df -h` again.

~~~~{.bash hl_lines="28"}
# with the SD card reader unplugged
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            3.9G   12K  3.9G   1% /dev
tmpfs           783M  1.7M  781M   1% /run
/dev/sda3       110G   14G   90G  14% /
none            4.0K     0  4.0K   0% /sys/fs/cgroup
none            5.0M     0  5.0M   0% /run/lock
none            3.9G   90M  3.8G   3% /run/shm
none            100M   80K  100M   1% /run/user
/dev/sda1       461M  132M  306M  31% /boot
/dev/md0        917G  224G  647G  26% /home
/dev/sdb        3.6T  2.5T  950G  73% /mnt/backup

# with the SD card reader plugged in USB
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            3.9G   12K  3.9G   1% /dev
tmpfs           783M  1.8M  781M   1% /run
/dev/sda3       110G   14G   90G  14% /
none            4.0K     0  4.0K   0% /sys/fs/cgroup
none            5.0M     0  5.0M   0% /run/lock
none            3.9G   90M  3.8G   3% /run/shm
none            100M   80K  100M   1% /run/user
/dev/sda1       461M  132M  306M  31% /boot
/dev/md0        917G  224G  647G  26% /home
/dev/sdb        3.6T  2.5T  950G  73% /mnt/backup
/dev/sdj1        15G   32K   15G   1% /media/jeff/3CB1-D9D9
~~~~

Note that in my example above, the new device is `/dev/sdj1`.
The last part (the number 1) is the partition number
but we want to write to the whole SD card, not just one partition.
Therefore you need to remove that part when creating the image.
With this information, and know the location of the Raspbian image and
where we need to write the Raspbian image to the SD Card
(see more detail instructions [here][06]).

```bash
cd /home/jeff/Downloads

# unmount the sd card reader
sudo umount /dev/sdj

# write the image to the sd card reader
sudo dd bs=4M if=2016-02-09-raspbian-jessie.img of=/dev/sdj

# ensure the write cache is flushed
sync

# check the integrity of the sd card image
sudo dd bs=4M if=/dev/sdj of=copy-from-sd-card.img
sudo truncate --reference 2016-02-09-raspbian-jessie.img copy-from-sd-card.img
diff -s 2016-02-09-raspbian-jessie.img copy-from-sd-card.img

# unmount the sd card reader
sudo umount /dev/sdj
```

Don’t remove SD card from the reader on your computer.
We’re going to set up the WiFi interface.

>**NOTE:** You could immediately put the SD Card in the RPi and boot it up,
but you will have no WiFi access.
You can get around this by using a console cable to make the file modification
outline in the next step.
[Adafruit has good description on how to use a console cable][20].

# Step 3: Configure your WiFi - DONE
Unplug your SD Card reader and plug it back in
and this will mount the Raspbian image on your Linux box.
The `df -h` command will show you the device being used, the mount point, and memory used/available.

```bash
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            3.9G   12K  3.9G   1% /dev
tmpfs           783M  1.8M  781M   1% /run
/dev/sda3       110G   14G   91G  13% /
none            4.0K     0  4.0K   0% /sys/fs/cgroup
none            5.0M     0  5.0M   0% /run/lock
none            3.9G   15M  3.9G   1% /run/shm
none            100M   44K  100M   1% /run/user
/dev/sda1       461M  132M  306M  31% /boot
/dev/md0        917G  232G  639G  27% /home
/dev/sdd        3.6T  2.5T  984G  72% /mnt/backup
/dev/sdj2       3.7G  3.3G  206M  95% /media/jeff/23c4ddbc-85fa-4cea-b96b-edae0bb138c9
/dev/sdj1        60M   20M   41M  34% /media/jeff/boot
```

You will find two new partitions, in my case `/dev/sdj1` and `/dev/sdj2`.
As root, you'll need to change directory to the main partition,
in my case `/media/jeff/23c4ddbc-85fa-4cea-b96b-edae0bb138c9`, to edit the files.

>**NOTE:** On a Mac, you can’t access EXT4 partitions without fiddling with 3rd party software.

Change directory to root on the SD card via `cd /media/jeff/23c4ddbc-85fa-4cea-b96b-edae0bb138c9/`.
Pay special attention to the path in the files referenced below.
There is no leading slash since you want to edit the files on your SD Card
and not the ones on your host system!
Next we're going to configure the network interface by
editing the interfaces file `etc/network/interfaces`.
Find this block in the file:

```
allow-hotplug wlan0
iface wlan0 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

Then change it to this:

```
auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

Now open the file `etc/wpa_supplicant/wpa_supplicant.conf` in an editor
and add the following to the bottom of the file:

```bash
# home wifi network settings
network={
    id_str="home"
    ssid="<your-network-ssid-name>"
    scan_ssid=1
    psk="<your-network-password>"
    proto=RSN
    key_mgmt=WPA-PSK
    pairwise=CCMP
    auth_alg=OPEN
}
```

* `id_str` is used to set up custom network settings, depending on which access point we are connected to
* `scan_ssid` is 1 tells your wifi adapter to look for the networks automatically and connect when in range
* `ssid` is the name of the wireless network (what you typically see when you search for wifi connections)
* `psk` is the WiFi password if the network is WPA/WPA2 encrypted, leave out for open or WEP networks
* `proto` could be either RSN (WPA2) or WPA (WPA1)
* `key_mgmt` could be either WPA-PSK (most probably) or WPA-EAP (enterprise networks)
* `pairwise` could be either CCMP (WPA2) or TKIP (WPA1)
* `auth_alg` is most probably OPEN, other options are LEAP and SHARED

If you want to include other WiFi networks,
just add another `network` structure to the file `etc/wpa_supplicant/wpa_supplicant.conf`.
(See examples [here][18] and [here][19])

# Step 4: First Time Boot of the Raspberry Pi - DONE
Now unmount the SD Card, put the SD Card into the Raspberry Pi,
plug a [WiFi dongle][14] into the Raspberry Pi, and power it up.
After approximately a minute, the Raspberry Pi will have completely booted up.
At this point your WiFi router should have automatically assigned an IP to the Raspberry Pi
(assuming the router is running DHCP).

To access the Raspberry Pi, we'll need its host name
(generally this defaults to `raspberrypi`) or
we’ll need to get the IP address it has been assigned by the network,
which you can get via your WiFi routers administrate interface or `nmap` or `arp`.
To begin your can scan using `nmap -sP`,
which will run a ping scan on the specified network.
For instance, `nmap -sP 192.168.1.0/24` will scan the 256 hosts from
192.168.1.0 through 192.168.1.255 to see if they're available, and report back.

```bash
# ping scan on the specified network
sudo nmap -sP 192.168.1.0/24

# using arp to find the IP address
arp -a
```

To check to see what devices are running SSH service on port 22:

```bash
# using nmap to list IP for devices running with port 22 open
sudo nmap -p22 -sV 192.168.1.0/24
```
So lets assume from the above output that the Raspberry Pi has an IP address of 192.168.1.179
and SSH is running on this Raspberry Pi,
so it can be accessed at via `ssh pi@192.168.1.179`
Enter the default password `raspberry` and you will now get to the command prompt.
If this is your first time for logging in, you will also be a message:

```
$ ssh pi@192.168.1.179
The authenticity of host '192.168.1.179 (192.168.1.179)' can't be established.
ECDSA key fingerprint is a6:45:7d:78:4b:c8:52:72:a0:6b:52:37:c8:e6:73:45.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.1.179' (ECDSA) to the list of known hosts.
pi@192.168.1.179's password:

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sat Feb 27 15:10:01 2016
```

You may also be get with the message:

```
NOTICE: this Raspberry Pi has not been fully configured. Please run 'sudo raspi-config'
```

If you get it or not, this should be your next step.

>**NOTE:** When using a keyboard and monitor (not SSH) when logging in,
the Raspberry Pi OS image [Jessie][10] default behaviour is to boot straight to the desktop GUI,
not to the Linux command line as done above.
The motivation is that is the expected behaviour for all modern computers.
When a new image that contains the `raspi-config` utility is booted the first time,
the session starts with the `raspi-config` screen
(This behaviour is driven by the `raspi-config.sh` script in the `/etc/profile.d` directory).
Under these conditions, you would be prompted for the next step automatically.

# Step 5: Configure the Raspberry Pi - DONE
You should now run the `sudo raspi-config` (see [raspi-config documentation][12])
The multiple things can be configured within this configuration tool.
We need to change the following:

* **Expand Filesystem** - select this
* **Boot Options** - select this and choose "B1 Console"
* **Advanced Options** - select this and choose "A2 Hostname", enable "A4 SSH", enable "A5 Device Tree", enable "A6 SPI", enable "A7 IC2", enable "A8 Serial"

Finally, select `<Finish>` and reboot so that the configuration changes are all applied.

```bash
sudo reboot
```

# Step 6: OS Updates - DONE
Let's make sure you have all the most current Linux packages.
This will patch the Linux operating system and all its GPL applications

```bash
# commandline utility for applications upgrade
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get upgrade

# if packages were installed, reboot
sudo reboot
```

After a successful upgrade and reboot,
use `hostnamectl` and `vcgencmd` to see your current Raspbian version
and firmware version using the method shown below:

```bash
# check you current OS version
$ hostnamectl
   Static hostname: mesh01
         Icon name: computer
           Chassis: n/a
        Machine ID: 66ed98ff0e86414096aa89869d8e8c09
           Boot ID: d85f8fc7314f427b8049f304baf05b8c
  Operating System: Raspbian GNU/Linux 8 (jessie)
            Kernel: Linux 4.1.17+
      Architecture: arm

# check the firmware version
$ sudo /opt/vc/bin/vcgencmd version
Feb  1 2016 17:51:17
Copyright (c) 2012 Broadcom
version b3dc56931507f355d503ea69397778643f7a3dc3 (clean) (release)
```

# Step 7: Updating Firmware for Raspberry Pi - DONE
In the case of the Raspberry Pi (RPi), you will want to also upgrade the firmware regularly.
[Raspbian][07] is the standard Linux operating system distribution for the RPi,
but it doesn't include firmware.
Never the less, tools for updating the firmware are included in the Raspbian distribution of Linux.

```bash
# install firmware update tool
sudo apt-get install rpi-update

# check for and install any required Raspberry Pi firmware upgrades
sudo BRANCH=next rpi-update

# if firmeware is installed, reboot
sudo reboot
```
Rerun the tools `hostnamectl` and `vcgencmd` to see how your
kernel and firmware may have changed from the earlier step.

Once these tools have been installed,
periodically you can update the firmware via the commands below:

```bash
# periodically you can update the firmware via the command

# check for and install any required Raspberry Pi firmware upgrades
sudo BRANCH=next rpi-update

# if firmeware is installed, reboot
sudo reboot
```

>**NOTE:** If your using the [Adafruit's Occidentalis distribution][08],
this may require a [slightly different update tool][09]

# Step 8: Package Installs - DONE
While the Raspberry Pi comes with a fairly robust set of Linux packages,
it could use some beefing up for most uses.
For example, while the distribution is likely to already have some Python packages installed,
execute the following to make sure you have all that is needed

```bash
# first install Python packages
sudo apt-get install python python-dev libjpeg-dev libfreetype6-dev python-setuptools python-pip

# update the Python distribution
sudo easy_install -U distribute

# install the RPi GPIO and other packages via pip
sudo pip install RPi.GPIO pySerial nose cmd2
```

Install X Window utilities and other applications

```bash
# some X Window utilities
sudo apt-get install x11-apps x11-xserver-utils xterm

# development tools
sudo apt-get install markdown git vim vim-gtk microcom screen
sudo apt-get install nodejs-legacy npm build-essential i2c-tools python-smbus

# AWS IoT Device SDK to connect hardware device to AWS IoT.
sudo npm install aws-iot-device-sdk

# so you can discover hosts via Multicast Domain Name System (mDNS)
sudo apt-get install avahi-daemon

# basic networking / firewall tools
sudo apt-get install tcpdump wavemon nicstat nmap ufw

# other handy tools
sudo apt-get install sendmail lynx gnome-terminal
```

>**NOTE:** To avoid a [potential namespace collision][17] for the word "node",
specifically as it relates to [Node.js][16],
make sure to use the `nodejs-legacy` package for Node.js.

Appears that getting my favorite browser,
[Chrome][22] or its open source version [Chromium][23],
on the Raspberry Pi [got a bit harder][21].
The default browser for the RPi has been [Midori][24].

```bash
# install the midori browser
sudo apt-get install midori
```

Google Chrome on your armhf architecture is problematic
because of licensing issues with ARM and bugs with ARM's proprietary drivers.
It appears to be supported on the amd64 architecture.
If your using the amd64 architecture,
use the `midori` browser,
goto the Chrome download website
`https://www.google.com/chrome/browser/desktop/index.html`
and get the `.deb` package from Google,
and install it with `sudo dpkg -i ....`.

# Step 8A: Load Personal Tools (Optional)

```bash
https://github.com/jeffskinnerbox/.vim.git
https://github.com/jeffskinnerbox/.bash.git
```

# Step 9: Password-less Login via SSH Keys - DONE
Public key authentication is an alternative means of identifying yourself to a login server,
instead of typing a password.
It is more secure and more flexible, but more difficult to set up.
This is particularly important if the computer is visible on the Internet.
Also, public key authentication allows you to log into a machine
without a user typing in a password.

To setup password-less login via public key authentication,
use the posting "XXX-howto-configure-ssh-public-key-authentication".

# Step 10: Boot Without Starting X Window - DONE
The Raspberry Pi's Jessie image is configured to automatically bring up the X Window
graphics system and the supporting GUI (aka [X Window System Display Manager][28]).
Generally, your not going to be using an RPi to support GUI's for users.
You should turn off X Windows and save yourself some CPU cycles.

You can discover if X Windows being start at boot up via the command:

```bash
# query to find out if your in graphical or multi-user mode
$ systemctl get-default
graphical.target
```

The response `graphical.target` indicates X Windows is being started on boot up.
The utility [`systemd`][15] is an init system and system manager that is widely
becoming the new standard for Linux machines.

To no long use the GUI and boot into multi-user mode, use this command

```bash
# set to multi-user mode
$ sudo systemctl set-default multi-user.target
Removed symlink /etc/systemd/system/default.target.
Created symlink from /etc/systemd/system/default.target to /lib/systemd/system/multi-user.target.

# query to find out if your in graphical or multi-user mode
$ systemctl get-default
multi-user.target
```

Note that at this point the X Server will still be running.
You can see this via the command `ps -aux | grep X`.
You need to reboot the RPi and then you will no long have X Window running.

# Step X: Running X Window Clients When You Want It - DONE
You can run [X Window clients][27] on the Raspberry Pi
(like the `midora` browser)
without any problem if you `ssh -X` into the RPi from a machine running
the [X Window System][25] [X.Org Server][26].

A simple test to see this work is to run `xeyes` on the Raspberry Pi.
A pair of eyes that track you mouse movement should appear in the display
of the machine from which your perfroming the `ssh -X`.
The `xeyes` X Window client is running on the RPi
using the display and XServer of our local machine.

If your not using, `ssh` to connect with the Raspberry Pi,
but just using a terminal, say with [screen][29] using a [console cable][30],
your not going to be able run X Window System applications.
You must be connected via TCP/IP.

# Step X: Static IP Address
Now that your Raspberry Pi connects automatically to your WiFi network every time it is tuned on,
you may want to specify a static IP address to communicate with your RPi.

For example, to set the static IP address to `192.168.100.50`
update the file `/etc/network/interfaces` so it looks like this:

```
auto lo
iface lo inet loopback
iface eth0 inet dhcp
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet static
address 192.168.100.50
netmask 255.255.255.0
network 192.168.100.0
broadcast 192.168.100.255
gateway 192.168.100.1
```

* [Smart Environmental Monitoring](https://www.hackster.io/alapisco/smart-environmental-monitoring-2552bb?utm_source=hackster&utm_medium=email&utm_campaign=new_projects)
* [How do I set up a static ip address on wifi?](https://www.raspberrypi.org/forums/viewtopic.php?f=91&t=49350)

# Step X: configure Raspberry Pi as a Microcontroller
[How to configure Raspberry Pi as a microcontroller](https://opensource.com/life/16/3/how-configure-raspberry-pi-microcontroller)

# Step X: Configure Firewall
We’re going to use `ufw` (Uncomplicated FireWall) to restrict access to our Raspberry Pi.

* [UncomplicatedFirewall](https://wiki.ubuntu.com/UncomplicatedFirewall)

# Step X: Security
* [IoT Security: Tips to Protect your Device from Bad Hackers](https://www.hackster.io/charifmahmoudi/iot-security-tips-to-protect-your-device-from-bad-hackers-768093?utm_source=Hackster.io+newsletter&utm_campaign=3e0b3a91f6-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-3e0b3a91f6-140225889)

# Step X: Install Fail2Ban
[How Fail2Ban Works to Protect Services on a Linux Server](https://www.digitalocean.com/community/tutorials/how-fail2ban-works-to-protect-services-on-a-linux-server)
[How To Protect SSH with Fail2Ban on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-ubuntu-14-04)
[How to protect SSH with fail2ban](https://kyup.com/tutorials/protect-ssh-fail2ban/)
[Preventing Brute Force Attacks With Fail2ban On Debian Etch](https://www.howtoforge.com/fail2ban_debian_etch)
[Using Fail2ban to Secure Your Server](https://www.linode.com/docs/security/using-fail2ban-for-security)

# Step X: Install Watchdog
[Howto Use Linux Watchdog](https://embeddedfreak.wordpress.com/2010/08/23/howto-use-linux-watchdog/)
[Using the Watchdog Timer in Linux](http://www.jann.cc/2013/02/02/linux_watchdog.html)
[The Linux Watchdog driver API](https://www.kernel.org/doc/Documentation/watchdog/watchdog-api.txt)
[Linux Watchdog Daemon - Configuring](http://www.sat.dundee.ac.uk/psc/watchdog/watchdog-configure.html)
[Keeping your Raspberry Pi alive: enabling Hardware Watchdog under Arch Linux](http://dovgalecs.com/blog/keeping-your-raspberry-pi-alive-enabling-hardware-watchdog-under-arch-linux/)

# Step X: Clone the SD Card
* [Backup, Restore, Customize and Clone your Raspberry Pi SD Cards (tutorial)](http://sysmatt.blogspot.com/2014/08/backup-restore-customize-and-clone-your.html)
* [Duplicating Your Raspberry Pi’s SDHC Card](https://programmaticponderings.wordpress.com/2013/02/12/duplicating-your-raspberry-pis-sdhc-card/)
* [CLONE AN SD CARD ON LINUX, UBUNTU 12.04](http://rricketts.com/clone-an-sd-card-on-linux-ubuntu-12-04/)
* [Back-up a Raspberry Pi SD card using a Mac](https://smittytone.wordpress.com/2013/09/06/back-up-a-raspberry-pi-sd-card-using-a-mac/)
* [How to Clone Raspberry Pi SD Cards Using the Command Line in OS X](http://computers.tutsplus.com/articles/how-to-clone-raspberry-pi-sd-cards-using-the-command-line-in-os-x--mac-59911)

# Step X: Raspberry Pi as a Microcontroller
* [How to configure Raspberry Pi as a microcontroller](https://opensource.com/life/16/3/how-configure-raspberry-pi-microcontroller)
* [Node.js app with forever running as a service daemon](http://www.slidequest.com/q/70ang)
* [Node.js and Forever as a Service: Simple Upstart and Init Scripts for Ubuntu](https://www.exratione.com/2013/02/nodejs-and-forever-as-a-service-simple-upstart-and-init-scripts-for-ubuntu/)
* [Starting Node Forever Scripts at Boot w/ CentOS](http://blog.aronduby.com/starting-node-forever-scripts-at-boot-w-centos/)
* [PM2: Advanced, production process manager for Node.js](http://pm2.keymetrics.io/)
* [Goodbye node-forever, hello PM2](http://devo.ps/blog/goodbye-node-forever-hello-pm2/)
* [NPM a Day Series - pm2 vs nodemon vs forever](https://www.youtube.com/watch?v=84d35TwX3fA)
* [Monit](https://mmonit.com/monit/#slideshow)

# Sources
* [Raspberry Pi Zero Headless Setup](http://davidmaitland.me/2015/12/raspberry-pi-zero-headless-setup/)
* [Raspberry Pi 2: Basic setup without any cables (headless)](http://blog.self.li/post/63281257339/raspberry-pi-part-1-basic-setup-without-cables)



[01]:http://internetofthingsagenda.techtarget.com/definition/headless-system
[02]:https://www.raspberrypi.org/downloads/raspbian/
[03]:https://www.raspbian.org/
[04]:http://www.amazon.com/gp/product/B00GVRHON2?psc=1&redirect=true&ref_=oh_aui_detailpage_o00_s01
[05]:http://www.wirelesshack.org/best-micro-sd-card-for-the-raspberry-pi-model-2.html
[06]:https://www.raspberrypi.org/documentation/installation/installing-images/linux.md
[07]:http://www.raspbian.org/
[08]:http://learn.adafruit.com/adafruit-raspberry-pi-educational-linux-distro/overview
[09]:https://github.com/Hexxeh/rpi-update
[10]:https://www.raspberrypi.org/blog/raspbian-jessie-is-here/
[11]:https://linuxconfig.org/raspbian-gnu-linux-upgrade-from-wheezy-to-raspbian-jessie-8
[12]:http://elinux.org/RPi_raspi-config
[13]:http://www.jeffgeerling.com/blogs/jeff-geerling/raspberry-pi-microsd-card
[14]:http://www.amazon.com/Edimax-EW-7811Un-150Mbps-Raspberry-Supports/dp/B003MTTJOY
[15]:https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
[16]:https://nodejs.org/en/
[17]:http://stackoverflow.com/questions/21168141/cannot-install-packages-using-node-package-manager-in-ubuntu
[18]:http://raspberrypi.stackexchange.com/questions/11631/how-to-setup-multiple-wifi-networks
[19]:https://www.raspberrypi.org/forums/viewtopic.php?f=91&t=14226
[20]:https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable/overview
[21]:http://conoroneill.net/running-the-latest-chromium-45-on-debian-jessie-on-your-raspberry-pi-2/
[22]:https://www.google.com/chrome/browser/desktop/index.html
[23]:https://www.chromium.org/
[24]:http://midori-browser.org/
[25]:https://en.wikipedia.org/wiki/X_Window_System
[26]:https://en.wikipedia.org/wiki/X.Org_Server
[27]:http://www.tldp.org/HOWTO/XWindow-Overview-HOWTO/arch-overview.html
[28]:https://en.wikipedia.org/wiki/X_display_manager_(program_type)
[29]:http://aperiodic.net/screen/start
[30]:https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable/overview
[31]:
[32]:
[33]:
[34]:
[35]:
[36]:
[37]:
[38]:
[39]:
[40]:
