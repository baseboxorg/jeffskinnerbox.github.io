Status: draft
Title: Cheap Linux Laptop
Date: 2100-01-01 00:00
Category: Software, Hardware
Tags: Chrome, Chromebook, Linux
Slug: cheap-linux-laptop
Author: Jeff Irland
Image: toshiba-chromebook-linux.jpg
Summary: This post is a somewhat disjointed dump of things that I’ve done in order to be comfortable working with the Chromebook.

I wanted to get a Linux laptop for some lightweight development
but I couldn't justify the price tag for my limited needs.
[Chromebook's are cheap & popular][31]
and which can be purchased for $300 or less
(In fact, [Amazon's top three computers sold over the 2014 Christmas season were Chromebooks][32]).
I knew you could installing a traditional Linux environment on a Chromebook,
so I got myself a [Toshiba CB35-B3340 Chromebook 2][01] with 4G of memory and 16G drive
(see a review [here][38]).
Note that this Chromebook uses an Intel process,
which is [important for installing Linux][04].
Chromebook isn't a PC replacement, but for many users, a [better alternative][23].
See the [Chrome Help Center][21] and [Chromebook Help Center][22] for more information.

Conveniently, Chromebooks have a Developer Mode,
which lets you bypass all the normal checks and balances that Google
use to ensure that rogue software does not run on Chrome OS devices.
After you have switched into developer mode,
your Chromebook will run whatever you want it to.
You can open up a Linux shell in a browser tab
([Chromebooks are running a cut down Linux distribution][39] after all)
simply by hitting `Ctrl`+`Alt`+`T` on the keyboard.

Installing a traditional Linux environment on your Chromebook is a quick and easy
because the Chrome OS is a Linux-based operating system.
You can install an alternative Linux environment and get a fully-fledged Linux desktop
along side Chromebook.
There are two main ways to install a traditional Linux environment on your device,
either in a dual-boot environment using [ChrUbuntu][02],
or in a chroot environment using [Crouton][03].
There is a third method.
The “[Boot from USB][06]” option will allow you to activate booting from USB devices.
This allows you to boot a full Linux environment from a USB drive without modifying your Chrome OS system.

Crouton appears to be the best supported way of running another OS on top of Chrome OS.
It’s quite impressive how easy it is to use and what I will use.

# The Linux Install
I choose to use the crouton method, which is a set of scripts,
to use the Linux command chroot ([Change Root][13]) to simultaneously
run a Linux operating system alongside Chrome OS.
Chroot was meant for Linux administrators to easily fix problems while running as the root,
superuser, without logging off the current user.
Here, it's being used to run a primitive form of container.
It has neither the sophistication of a [virtual machine (VM)][40]
or an advanced container such as Docker or Google lmctfy.
What chroot has going for it is that it's very lightweight
and is present on almost all versions of Linux (including Chrome OS).
Its downside is that in this mode users have a great deal of power over their system,
so be careful not to do foolish things with your Chromebook.

## Step 1: Backup Your Chromebook Data
Since all of your data is synced to Google Server,
you actually don’t have to worry about losing any data.
The only data that you must make a back-up of is the `Download` folder
because the content of this folder is not synced.

## Step 2: Backup Your Chromebook Environment
Once you have taken the back-up, it’s also a fail-safe plan to create a restore USB of Chrome OS,
in case something goes badly wrong and you need to re-install Chrome OS.
Install Chromebook recovery utility from the Chrome web store.
Go to the [Chrome Web Store][07]
and install the [Chromebook Recovery Utility][08].
Open the app and follow the instructions to create the recovery drive.
All you need is working Internet and a USB drive with at least 4GB space.

## Step 3: Putting the Chromebook into Developer Mode
Putting Chromebook into “[Developer Mode][19]” will give you full root access,
including the ability to modify your Chromebook’s system files.
We'll use it to install a full Linux system with Crouton.
The article "[How to Enable Developer Mode on Your Chromebook][05]"
and the [this video][09] gives a complete description of this process.
There are a few subtle steps that can trip you up, so read it.

>**Warning:** Entering developer mode will wipe all data off of the SSD.

As part of the process of enabling Developer Mode, your Chromebook will be “powerwashed.”
All the user accounts and their files will be removed from your Chromebook.
Also keep in mind that Developer Mode will need access to the Internet to download files.
This means you need to have initialized the native Chromebook with access to WiFi.

## Step 4: Download and Install Crouton
Crouton is a set of scripts that bundle up the installation of Ubuntu or Debian OS for the Chromebook.
All the best documentation is maintained on Github's
[crouton: Chromium OS Universal Chroot Environment][10]
and the [Wiki][15].
There you will find a easy to use link to download crouton.
Just execute this link [https://goo.gl/fd3zc][11] from your Chromebook browser.

You should also install the [crouton extension][12].
This works with with the "extension" or "[xiwi][18]" targets (see below),
provides much improved integration with Chromium OS
by putting X11 in a native window.

## Step 5: Choose a Linux Target
To install you Linux OS onto the Chromebook,
follow the procedures  outline in Step 4 of the article
"[How to Easily Install Ubuntu on Chromebook with Crouton][14]".

When installing using Crouton, you have to specify a target Linux environment.
For example, `sudo sh ~/Downloads/crouton -r trusty -t xfce,xiwi` installs the Xfce desktop
with the `trusty` version of Ubuntu.
You’ll find other targets here too — Ubuntu’s Unity desktop, KDE, GNOME, LXDE, Enlightenment,
and even command-line only targets like “core” and “cli-extra” if you don’t need a fancy desktop.
To get a listing, use the commands below:

```bash
# see a list of targets
sh ~/Downloads/crouton -t help

# see a list of Linux distributions and their releases
sh ~/Downloads/crouton -r list
```

I used the following command line to install my system:

```bash
# install your desired Ubuntu release and targets
sudo sh ~/Downloads/crouton -e -r trusty -t xfce-desktop,xiwi,keyboard,extension,core,cli-extra
```

The Crouton [Wiki][15] discusses [security][17]
and points out that crouton is not, and cannot be, as secure as Chromium OS in verified mode.
Becasue of this, I use the second "-e" option to encrypt the Linux instancance.

## Step 6: Managing Crouton
Unlike the Chromebook itself,
whe a new version of Crouton comes out, the software in your chroot will not automatically update itself.
To update it, enter your chroot and run the following command.
That means this command must be run from that Crouton Linux system:

```bash
croutonversion -u -d -c
```

Next, exit the chroot and run the following command from the Chrome OS shell,
replacing “name” with the name of your chroot.
If you didn’t specify a name,
it’s probably the name of the release you installed — for example, “trusty”, in my case.

```bash
# trusty is the name of the Linux version to be installed
sudo sh ~/Downloads/crouton -u -n trusty
```

The article "[How to Manage the Crouton Linux System on Your Chromebook][24]"
gives some additiona pointers on manging your Crounton-enabled Chromebook.
It covers things like backing up the chroot, creating multiple chroots, etc.

# Working with Chrome OS and Linux
Switching from a PC to a Chromebook comes with a few adjustments.
For one, you’ll need to have access to a WiFi signal for most Chrome apps to function.
Also, the Chromebook doesn't have a standard PC keyboard (e.g. no Page Up / Down keys).
There is also a number of keyboard shortcuts you’ll need to learn,
and touchpad motions that are different from the average PC.

* Click the touchpad with two fingers to open the **right-click menu** .
* Place two fingers on the touchpad and move up and down or right to left to **scroll**.
* Click and hold on an item you want to **drag and drop** using one finger. Then, with a second finger move to where you want that item dropped.
* Swipe left or right quickly using two fingers to **switch between open tabs**.

https://support.google.com/chromebook/answer/1047367?hl=en&ref_topic=2589149
http://blog.laptopmag.com/how-to-right-click-on-a-chromebook

## Linux in a Chromium OS Window
https://github.com/dnschneid/crouton/wiki/crouton-in-a-Chromium-OS-window-(xiwi)

## Commands, Tips, and Tricks
* [Chrome Story][37]
* [100 Tips for Google Chrome][41]
* [Getting Started with your Chromebook][35]
* [100 Best Chromebook Tips, Tricks and Time Savers][36]

### Chromebook
You can find thousands of apps for the Chromebook on the web
to do things like create documents, edit photos, and listen to music in the browser.
Google has provided a recommendation list at the sites
"[Find apps for your Chromebook][26]",
"[10 Top Tweaks and Tips for Chromebook][27]",
"[Chromebook tips and tricks: Getting the most out of your Chrome OS machine][29]",
"[15 essential Chrome OS keyboard shortcuts][30]".

https://gigaom.com/2012/07/09/10-google-chromebook-tips-tricks-and-tweaks/

Google's Chrome OS uses some familiar keyboard shortcuts as well as some unique ones.
A few of these access Chrome OS settings
and others take the place of missing physical keys on Chromebook keyboards
( e.g. Page Up, Page Down, Home, End).

Full list of Chromebook's [Keyboard shortcuts][42].

| Keys         | Operation                       |
|--------------|---------------------------------|
| Ctrl+?       | Open help                       |
| Shift+Esc    | Open task manager               |
| Ctrl+Alt+/   | Open keyboard shortcut list     |
| Ctrl+M       | Open file manager               |


| Keys                 | Operation                       |
|----------------------|---------------------------------|
| Alt+ up arrow        | Page Up                         |
| Alt+ down arrow      | Page Down                       |
| Ctrl+Alt+ up arrow   | Home                            |
| Ctrl+Alt+ down arrow | End                             |
| Ctrl+Tab             | Switch to next browser tab      |
| Ctrl+W               | Close current tab               |
| Ctrl+Shift+T         | Reopen last closed tab          |
| Ctrl+N               | Open new browser window         |
| Alt+Tab              | Switch to next open window      |
| Ctrl+Shift+Q         | Sign out of Google account      |
| Alt+backspace        | Delete file(s) in file manager  |


### Crosh
Crosh is a shell environment known as “chrome shell”
that is provided with Chrome OS.
Crosh allows users to run several commands directly from Chrome OS.
Developer mode is not required to use crosh.
The vast majority of linux commands are locked down inside crosh.
Crosh can be accessed by pressing `Ctrl`+`Alt`+`T` on the keyboard.
This will open a new tab with the crosh terminal.

cosh has two separate versions of help.
you can access basic help in the crosh window by simple typing `help`.
This will give you a list of commands that can be used inside crosh.
To get a list of the more advanced commands type `help_advanced`.
To access further functionality from crosh such as as the Bash Shell,
chromeos needs to be in developer mode.

There are several commands included in Chrome OS’s crosh shell.
You find several of them documented in the articles
"[10+ Commands Included In Chrome OS’s Hidden Crosh Shell][25]",
"[Customize Chromebook Chrosh Shell Environment][28]".

[10 Commands In Chrome’s Crosh Shell](http://efytimes.com/e1/fullnews.asp?edid=124113)
http://krypted.com/unix/helpful-chrome-os-shell-crosh-commands/
[25 Helpful Chrome OS Shell (crosh) Commands](http://krypted.com/unix/helpful-chrome-os-shell-crosh-commands/)
http://www.dudleymediagroup.com/Detail/id/5-tips-after-installing-crouton-on-a-chromebook-2654

Crosh even supports full-blown bash with ssh-agent and Vim.
To get Vim working, do the following:

```
CTRL+ALT T
crosh> shell
chrosos@localhost / $ echo $SHELL
/bin/bash
chrosos@localhost / $ vim
```

The problem with running crosh in the browser is that if you want to use shortcuts like Ctrl+w
(in Vim, for example), Chrome will take the default action associated to that shortcut.
One solution is to open crosh as a window.

You can also put crosh in a window, independent of your Chrome browser.
You can do this via a Chrome app called [Crosh Window][33]
(You must have [Secure Shell][34] installed for this to work).
When clicked, this app opens a new crosh window without any chrome browser,
but pressing `Ctrl`+`Alt`+`T` still brings up crosh in the Chrome browser.

#### Ssh Tunnelling on Chrome OS
To use [ssh tunnelling on Chrome OS][20],
open the crosh shell by pressing `Ctrl`+`Alt`+`T` anywhere in Chrome OS.
The shell will open in a browser tab.
Next, use the appropriate `ssh` command to connect to an SSH server and establish a tunnel.
You’ll do this by running the `ssh` command and then by typing every option on its own line, like so:

![crosh ssh](http://cdn3.howtogeek.com/wp-content/uploads/2014/11/img_546b9898a9e3f.png)

You could also just type in the whole line like `ssh jeff@desktop`
to secure shell into the `desktop` system using the login `jeff`.

#### Connectivity Command
[CHROME OS – USING THE CROSH CONNECTIVITY COMMAND](https://failicide.wordpress.com/2015/02/19/chrome-os-using-the-crosh-connectivity-command/)

### Crouton
[Crouton Command Cheat Sheet][16]
http://fuyuko.net/basic-tweaks-and-tips-for-crouton-in-chromebook/

### Linux
Xfce tweaks

* Turn on X11 Forwarding - http://www.webupd8.org/2013/12/things-to-do-after-installing-ubuntu-on.html
* Make sure the TERM varable is set to the same value as the remote system your logging into (XTERM=xterm-256color)
* download your .bash, .vim, etc.

## Starting and Stopping Linux
There are a few things you need to know to move between Chrome OS and Linux.
First of all, to start your Linux, you'll need to
press `Ctrl`+`Alt`+`T`
to bring up a Chrome Shell or `crosh` terminal on your Chromebook.
Then type `shell` at the prompt to get to the root Linux shell
(this can only be done in [Developer Mode][19]).

You can open your running chroot desktops by clicking on the extension icon.
Once in a crouton window, press fullscreen or the "switch window" key to switch
back to Chromium OS.

The screen will go black for a minute and boot into the Linux desktop.

```bash
# start linux command line mode
sudo enter-chroot

# start X Windows envirnment
sudo startxfce4 -b -X xiwi

sudo enter-chroot startxfce4
```

You can launch individual apps in crouton windows by using the "xiwi" command
in the chroot shell.
Use startxiwi to launch directly from the host shell.
Use the startxiwi parameter -b to run in the background.

```bash
# within shroot shell, run a xterm in it own window
sudo startxiwi -b xterm
```

You can start Xfce via the startxfce4 host command:

```bash
sudo startxfce4
```

You can start a shell in a new VT via the startcli host command:

```bash
sudo startcli
```

## Getting to a Command Prompt
https://www.chromium.org/chromium-os/poking-around-your-chrome-os-device

### Getting the Command Prompt Through Crosh
**NOTE:** You can actually create as many shells as you want.
Just hit `Ctrl`+`Alt`+`T` again and a second shell will be opened.

### Get the Command Prompt Through VT-2
One way to get the login prompt is through something called VT-2, or "virtual terminal 2".
You can get to VT-2 by pressing:
[ Ctrl ] [ Alt ] [ => ]
...where the [ => ] key is the right-arrow key just above the number 3 on your keyboard.

## Chromebook Factory Reset
http://www.cnet.com/how-to/what-does-it-mean-to-powerwash-a-chromebook/

## Microsoft Apps
http://www.omgchrome.com/microsoft-brings-office-online-chrome-web-store/

## Update a Crouton Chroot
When a new version of Crouton comes out,
the software in your chroot will be outdated.
It won’t automatically update itself, but you can update it fairly quickly.

```bash
# enter your chroot and run the following command.
croutonversion -u -d -c

# trusty is the name of your chroot
sudo sh ~/Downloads/crouton -u -n trusty
```

## When Linux Stops Working
Linux may stop working after a Chrome OS update.
If that's the case, update all the installed targets using the following command
(in Chrome OS, open a terminal using `Ctrl`+`Alt`+`T`, then type "shell"):

```bash
# trusty is the name of your chroot
sudo sh -e ~/Downloads/crouton -u -n trusty
```

Where "trusty" is the name of the chroot you want to update.
The default chroot name is the codename for the Ubuntu version you've installed
(regardless of the desktop environment you've installed).
For example, if you've installed Ubuntu 12.04 Precise, the default chrootname is "precise"

## Developing on a Chromebook
* [Developing on a Chromebook - Part 1: The Chromebook](http://blog.tomtasche.at/2011/11/developing-on-chromebook-part-1.html)
* [Developing on a Chromebook - Part 2: Cloud, it's not me, it's you.](http://blog.tomtasche.at/2011/11/developing-on-chromebook-part-2-cloud.html)
* [Developing on a Chromebook - Part 3: X-Forwarding, or "Eclipse on a Chromebook"](http://blog.tomtasche.at/2012/01/developing-on-chromebook-part-3-x.html)
* [Developing on a Chromebook - Part 4: Back to the past](http://blog.tomtasche.at/2012/02/developing-on-chromebook-part-4-back-to.html)
* [State of Developing on a Chromebook](http://matthewphillips.info/posts/state-of-developing-on-a-chromebook.html)
* [Using Cloud Drives on Chromebooks](http://matthewphillips.info/posts/using-cloud-drives-on-chromebooks.html)
* [Coder on a Chromebook with Crouton](https://github.com/googlecreativelab/coder/wiki/Coder-on-a-Chromebook-with-Crouton)

## Printing with Chromebook
So how do you print on a Chromebook?
You use Google Cloud Print.
Some new printers support Google Cloud Print,
so you can connect them to your network and easily print to them.
If you have an old printer connected to a Windows or Mac computer,
you can use the Google Cloud Print Connector feature to make an older printer
accessible to Google Cloud Print.
Don’t try to plug your printer directly into your Chromebook, though — that won’t work.

https://github.com/dnschneid/crouton/wiki/Printing
http://www.cnet.com/how-to/how-to-print-from-a-chromebook/

## Google Drive
Visit www.drive.google.com/settings to see the total space remaining.

## Dropbox
https://github.com/dnschneid/crouton/wiki/Dropbox

## Chrome Remote Desktop
http://computers.tutsplus.com/tutorials/use-chrome-remote-desktop-to-access-your-computer-anywhere--cms-21227

## Postman
https://www.getpostman.com/


[01]:http://www.cnet.com/products/toshiba-chromebook-2-review/
[02]:http://chromeos-cr48.blogspot.mx/
[03]:https://github.com/dnschneid/crouton
[04]:http://www.howtogeek.com/185039/4-things-to-keep-in-mind-when-buying-a-chromebook-for-linux/
[05]:http://www.howtogeek.com/210817/how-to-enable-developer-mode-on-your-chromebook/
[06]:http://www.pcworld.com/article/2873561/google-just-made-it-easier-to-run-linux-on-your-chromebook.html
[07]:https://chrome.google.com/webstore/category/apps
[08]:https://chrome.google.com/webstore/detail/chromebook-recovery-utili/jndclpdbaamdhonoechobihbbiimdgai
[09]:https://www.youtube.com/watch?v=d_MuVwJq_XQ
[10]:https://github.com/dnschneid/crouton
[11]:https://goo.gl/fd3zc
[12]:https://chrome.google.com/webstore/detail/crouton-integration/gcpneefbbnfalgjniomfjknbcgkbijom
[13]:https://wiki.archlinux.org/index.php/Change_root
[14]:https://www.linux.com/learn/tutorials/795730-how-to-easily-install-ubuntu-on-chromebook-with-crouton
[15]:https://github.com/dnschneid/crouton/wiki
[16]:https://github.com/dnschneid/crouton/wiki/Crouton-Command-Cheat-Sheet
[17]:https://github.com/dnschneid/crouton/wiki/Security
[18]:https://github.com/dnschneid/crouton/wiki/crouton-in-a-Chromium-OS-window-(xiwi)
[19]:https://software.intel.com/en-us/blogs/2014/07/01/chrome-os-whats-developer-mode
[20]:http://www.howtogeek.com/202768/how-to-use-ssh-tunnelling-on-chrome-os/
[21]:https://support.google.com/chrome#topic=3227046
[22]:https://support.google.com/chromebook/?hl=en#topic=3399709
[23]:https://www.google.com/chromebook/switch/
[24]:http://www.howtogeek.com/210047/how-to-manage-the-crouton-linux-system-on-your-chromebook/
[25]:http://www.howtogeek.com/170648/10-commands-included-in-chrome-oss-hidden-crosh-shell/
[26]:https://support.google.com/chromebook/answer/1056325?hl=en
[27]:http://www.technorms.com/35871/top-tweaks-and-tips-for-chromebook
[28]:https://gist.github.com/aaronhalford/a009bc73498407ae80e2
[29]:http://www.pocket-lint.com/news/129107-chromebook-tips-and-tricks-getting-the-most-out-of-your-chrome-os-machine
[30]:http://www.cnet.com/how-to/15-essential-chrome-os-keyboard-shortcuts/
[31]:http://www.zdnet.com/article/few-business-takers-yet-but-chromebook-sales-to-grow-7-3-million-this-year/
[32]:http://www.zdnet.com/article/top-3-holiday-computers-on-amazon-were-chromebooks/
[33]:https://chrome.google.com/webstore/detail/crosh-window/nhbmpbdladcchdhkemlojfjdknjadhmh?hl=en-US
[34]:https://chrome.google.com/webstore/detail/secure-shell/pnhechapfaindjhompbnflcldabbghjo
[35]:http://www.chromestory.com/Getting_Started_With_Your_Chromebook.pdf
[36]:http://www.chromestory.com/google-chromebook/
[37]:http://www.chromestory.com/
[38]:https://failicide.wordpress.com/2014/12/18/toshiba-chromebook-2-an-amazing-device/
[39]:https://en.wikipedia.org/wiki/Chrome_OS
[40]:https://en.wikipedia.org/wiki/Virtual_machine
[41]:http://www.chromestory.com/100_Chrome_ChromeOS_And_ChromeBook_Tips_Ebook.pdf
[42]:https://support.google.com/chromebook/answer/183101?hl=en&source=genius-rts
[43]:
[44]:
[45]:
[46]:
[47]:
[48]:
[49]:
[50]:
