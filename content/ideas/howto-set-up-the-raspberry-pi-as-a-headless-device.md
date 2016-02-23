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
Just follow steps XXXXXXXXXXXXXXXX.
If you want to also upgrade your existing Raspberry Pi OS to the latest version,
check out the article "[Raspbian GNU/Linux upgrade from Wheezy to Raspbian Jessie 8][11]".

# Step 1: Download Raspberry Pi Image
Before you can load a copy of the latest Raspberry Pi image onto your micro SD Card,
you must first download the official Raspberry Pi operating system, [Raspbian][03]
(in my case, the version is [Jessie][10]).
You can get that download [here][02].

The Raspbian download site also lists a check sum for the download file.
(**NOTE:** In my case, I down loaded the Raspbian file to `/home/jeff/Downloads/`.)
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

# Step 2: Write Raspberry Pi Image to SD Card
Next using Linux, you have copied the Raspbian image onto the SD card mounted to your system.
I'll be using the [Rocketek 11-in-1 4 Slots USB 3.0 Memory Card Reader][04] to create my SD Card.
Make sure to [choose a reputable SD Card][05] from [here][13], don't go cheap.

When using your card reader,
you'll need to know the device name of the reader.
The easiest way to find this is just unplug your card reader from the USB port,
run `df -h`, then plug it back in, and run `df -h` again.

~~~~{.bash hl_lines="28"}
# with the SD card reader unpluged
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

# Step 3: Configure your WiFi
Unplug your SD Card reader and plug it back in
and this will mount the Raspbia image on your Linux box.
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
(**NOTE:** On a Mac, you can’t access EXT4 partitions without fiddling with 3rd party software.)

Change directory to root on the SD card via `cd /media/jeff/23c4ddbc-85fa-4cea-b96b-edae0bb138c9/`.
(**NOTE:** Pay special attention to the path in the files referenced below.
There is no leading slash since you want to edit the files on your SD Card and not the ones on your host system!)
Next we're going to configure the network interface by editing the interfaces file `etc/network/interfaces`.
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

```
network={
    ssid="<your-network-ssid-name>"
    psk="<your-network-password>"
    proto=RSN
    key_mgmt=WPA-PSK
    pairwise=CCMP
    auth_alg=OPEN
}
```

* `proto` could be either RSN (WPA2) or WPA (WPA1).
* `key_mgmt` could be either WPA-PSK (most probably) or WPA-EAP (enterprise networks)
* `pairwise` could be either CCMP (WPA2) or TKIP (WPA1)
* `auth_alg` is most probably OPEN, other options are LEAP and SHARED

# Step 4: Boot the Raspberry Pi
Now unmount the SD Card, put the SD Card into the Raspberry Pi,
plug the WiFi in and power it up.
After approximately a minute, the Raspberry Pi will have completely booted up.
At this point your WiFi router should have automatically assigned an IP to the Raspberry Pi
(assuming the router is running DHCP).

To access the Raspberry Pi,
we’ll need to get the IP address it has been assigned,
which you can get via your WiFi routers administrate interface or `nmap` or `arp`.
Try the following:

```bash
# using nmap to list IP for devices running with port 22 open
sudo nmap -p22 -sV 192.168.0.0/24

# using arp to find the IP address
arp -a
```

So lets assume from the above output that the Raspberry Pi has an IP address of 192.168.1.89.
SSH is running on this Raspberry Pi, so it can be accessed at via `ssh pi@192.168.1.89`
Enter the default password `raspberry` and you will now get to the command prompt.
If this is your first time for logging in, you will also be a message:

```
NOTICE: this Raspberry Pi has not been fully configured. Please run 'sudo raspi-config'
```

When a new image that contains the `raspi-config` utility is booted the first time,
the session starts with the `raspi-config` screen
(This behaviour is driven by the `raspi-config.sh` script in the `/etc/profile.d` directory).

# Step X: Configure to Boot into Commandline <-- combine with section below???
The Raspberry Pi OS image [Jessie][10] default behaviour is to boot straight to the desktop GUI,
not to the Linux command line.
The motivation is that is the expected behaviour for all modern computers.
It is still possible to set the Pi to boot to the command line.

Boot without starting X-server - http://raspberrypi.stackexchange.com/questions/1318/boot-without-starting-x-server
Trying to turn off X11 in Jessie - http://raspberrypi.stackexchange.com/questions/31439/trying-to-turn-off-x11-in-jessie
http://www.modmypi.com/blog/boot-to-command-line-raspbian-jessie
http://ask.xmodulo.com/disable-desktop-gui-raspberry-pi.html
http://ask.xmodulo.com/boot-into-command-line-ubuntu-debian.html

# Step X: Set the Hostname

# Step X: Configure the Raspberry Pi
You should now run the `sudo raspi-config` (see [raspi-config documentation][12])
as prompted to perform some initial configuration of the Raspberry Pi.

The following things can be configured within the configuration tool:

* **expand_rootfs** - required to allow you to use all the space on your SD card if it is bigger than 2GB. Or you could manually partition if you prefer.
* **overscan** - not required that relates to using a TV / monitor
* **change_pass** - it is very important that you change the password as the password is otherwise at the default.
* **configure_keyboard** - not required as we don't have a keyboard physically connected.
* **change_locale** - required if not in the UK
* **change_timezone** - choose appropriate time zone, otherwise UTC (GMT) is used. Note that the Raspberry Pi does not include a realtime clock, but it will use the network time protocol to get the time from the Internet if available.
* **memory_split** - this allows you to change the amount of memory available for the video and main system. Without a TV / monitor connected then you should set to "224MiB for Arm, 32MiB for VideoCore".
* **ssh** - leave enabled
* **finish** - choose the finish option to quit and not show the "not fully configured" message in future. You can always run the configuration tool again by using `sudo raspi-config`.

You should configure to expand the root partition via `expand_rootfs`,
change the location via `change_locale`,
set the local time zone via `change_timezone`,
and then select `finish`.

Finally reboot so that the configuration changes are all applied.

```bash
sudo reboot
```

# Step X: Set Up DNS
Add the DNS server address to /etc/resolv.conf

# Step X: OS Updates
Let's sure you have all the most current Linux packages.
This will patch the Linux operating system and all its GPL applications

```bash
# commandline utility for applications upgrade
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

# graphics utility for applications upgrade
update-manager -c

# if packages were installed, reboot
sudo reboot
```

After a successful upgrade, use `hostnamectl` to see your current Raspbian version

```bash
# check you current OS version
```

# Step XA: Updating Firmware for Raspberry Pi
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

# Step XB: Updating Firmware for Raspberry Pi (Adafruit's Occidentalis)
If your using the [Adafruit's Occidentalis distribution][08],
this requires a [slightly different update tool][09]
(`git` needs to be installed):

```bash
# install tools to upgrade Raspberry Pi's firmware
sudo wget https://raw.github.com/Hexxeh/rpi-update/master/rpi-update -O /usr/bin/rpi-update
sudo chmod +x /usr/bin/rpi-update
```

**NOTE:*** Once these tools have been installed,
periodically you can update the firmware via the command below:

```bash
# periodically you can update the firmware via the command

# check for and install any required Raspberry Pi firmware upgrades
sudo BRANCH=next rpi-update

# if firmeware is installed, reboot
sudo reboot
```

# Step X: Package Installs
While the Raspberry Pi comes with a a fairly robust set of Linux packages,
it could use some beefing up for most uses.
For example, while the distribution is likely to already have some python packages installed,
execute the following to make sure you have all that is needed

```bash
sudo apt-get install python
sudo apt-get install python-dev
sudo apt-get install libjpeg-dev
sudo apt-get install libfreetype6-dev
sudo apt-get install python-setuptools
sudo apt-get install python-pip
```

With this done, now its time to install the required Python libraries

```bash
# first update the Python distribution
sudo easy_install -U distribute

# install the RPi GPIO and other packages
sudo pip install RPi.GPIO install pySerial nose cmd2
```

Install X Window utilities and other applications

```bash
# some X Window utilities
sudo apt-get install x11-apps x11-xserver-utils xterm

# development tools
sudo apt-get install markdown git vim vim-gtk microcom node i2c-tools python-smbus

# so you can connect via .local
sudo apt-get install avahi-daemon netatalk

# handy tools
sudo apt-get install sendmail

# basic networking tools
sudo apt-get install wavemon ievent netstat nicstat
```

# Step X: Password-less Login via SSH Keys
Generate SSH Keys on Your Mac (Not the RPi) For Password-less Logins

```bash
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub | ssh pi@<ip_address_of_raspberry_pi> "mkdir .ssh;cat >> .ssh/authorized_keys"
```

Replace  <ip_address_of_raspberry_pi>  with the IP address of the RPi.
This command will copy the public key generated on the Mac into the authorized_keys file on the Pi.
You will need to enter the password of the pi user to execute this command.
If you try to SSH into the machine after this command, no password will be required.

# Step X: Install Watchdog
[Howto Use Linux Watchdog](https://embeddedfreak.wordpress.com/2010/08/23/howto-use-linux-watchdog/)
[Using the Watchdog Timer in Linux](http://www.jann.cc/2013/02/02/linux_watchdog.html)
[The Linux Watchdog driver API](https://www.kernel.org/doc/Documentation/watchdog/watchdog-api.txt)
[Linux Watchdog Daemon - Configuring](http://www.sat.dundee.ac.uk/psc/watchdog/watchdog-configure.html)
[Keeping your Raspberry Pi alive: enabling Hardware Watchdog under Arch Linux](http://dovgalecs.com/blog/keeping-your-raspberry-pi-alive-enabling-hardware-watchdog-under-arch-linux/)

# Step X: Configure Firewall

# Step X: Install Fail2Ban
[How Fail2Ban Works to Protect Services on a Linux Server](https://www.digitalocean.com/community/tutorials/how-fail2ban-works-to-protect-services-on-a-linux-server)
[How To Protect SSH with Fail2Ban on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-ubuntu-14-04)
[How to protect SSH with fail2ban](https://kyup.com/tutorials/protect-ssh-fail2ban/)
[Preventing Brute Force Attacks With Fail2ban On Debian Etch](https://www.howtoforge.com/fail2ban_debian_etch)
[Using Fail2ban to Secure Your Server](https://www.linode.com/docs/security/using-fail2ban-for-security)

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
[14]:
[15]:
[16]:
[17]:
[18]:
[19]:
[20]:
