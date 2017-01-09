Status: draft
Title: Installing Linux on Chromebook
Date: 2100-01-01 00:00
Category: Software, Hardware
Tags: Chrome, Chromebook, Crouton, Linux
Slug: installing-linux-on-chromebook
Author: Jeff Irland
Image: toshiba-chromebook-linux.jpg
Summary: The price of the Chromebook makes it a very attractive, assuming you can get your favorite tools working on it.  Well, you can install Linux, along with all the tools Linux brings to your development needs. This post is a somewhat disjointed dump of things that I’ve done to create a comfortable working envirnment on a Chromebook.


* [Now you can unlock Chrome OS with a PIN code](https://www.engadget.com/2016/08/19/unlock-chrome-os-with-pin/)
* [Unlock your Chromebook with your Android phone](https://support.google.com/chromebook/answer/6070209?hl=en-GB)
* [Android apps are now available on these Chromebooks](http://www.techradar.com/news/mobile-computing/laptops/android-apps-are-now-available-on-these-chromebooks-1323567)
* [How To Run Android Apps on Your Chromebook](http://fieldguide.gizmodo.com/how-to-run-android-apps-on-your-chromebook-1786505928)
* See the split screen, how do you do this - [Putting Linux on your Chromebook is easier than you think (and totally worth it!)](http://www.androidcentral.com/putting-linux-your-chromebook-easier-you-think)



<a href="http://www.pcmag.com/article2/0,2817,2470486,00.asp">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="This Chromebook 2 is thin and light, which is pretty impressive, considering it has a 13.6-inch HD display. The plastic chassis measures just 0.76 by 12.76 by 8.4 inches (HWD) and weighs only 2.95 pounds." alt="chromebook picture" src="{filename}/images/toshiba-chromebook-linux.jpg" width="250" height="250" />
</a>
I wanted to get a Linux laptop for some lightweight development
and remote login into my home Linux box,
but I couldn't justify the price tag for my limited needs.
[Chromebook's are cheap & popular][31]
and can be purchased for $300 or less
(In fact, [Amazon's top three computers sold over the 2014 Christmas season were Chromebooks][32]).
I knew you could installing a traditional Linux environment on a Chromebook,
so I got myself a [Toshiba CB35-B3340 Chromebook 2][01] with 4G of memory and 16G drive
(see a review [here][38]).
Note that this Chromebook uses an Intel process,
which is [important for installing Linux][04].
Chromebook isn't a PC replacement, but for many users, a [better alternative][23].
See the [Chrome Help Center][21] and [Chromebook Help Center][22] for more information.

Conveniently, Chromebooks have a [Developer Mode][58],
which lets you bypass all the normal checks and balances that Google
use to ensure that rogue software does not run on Chrome OS devices.
After you have switched into developer mode,
your Chromebook will run whatever you want it to.
You can open up a Linux shell in a browser tab
([Chromebooks are running a cut down Linux distribution][39] after all)
simply by hitting `Ctrl`+`Alt`+`T` on the keyboard,
or bring ups a [crosh shell][33].

Installing a traditional Linux environment on your Chromebook is a quick and easy
because the Chrome OS is a Linux-based operating system.
You can install an alternative Linux environment and get a fully-fledged Linux desktop
along side Chromebook.
There are three main ways to install a traditional Linux environment on your device:

* The traditional dual-boot environment using [ChrUbuntu][02].  So here you have two operating systems, but only one of them can be executing at any one time.
* [Boot from USB][06] option will allow you to activate booting from USB devices. This is assentually the same as the first method but not booting from the hard drive.
* Run Linux along side of Chrome OS in a [chroot][74] environment using [Crouton][03].  In this case, you have two operating systems concurrently operating.

Crouton appears to be the best supported way of running another OS on top of Chrome OS.
Crouton [chroot environment][75] to run both Chrome OS and Ubuntu at the same time.
Chroot is an operation that changes the apparent root directory
for the current running process and their children.
A program that is run in such a modified environment cannot access files and commands
outside that environmental directory tree.
This modified environment is called a "[chroot jail][76]".
Crouton is quite impressive how easy it is to use and
comes with a [rich set of options][51].
(By the way, there happens to be a way to merging ChromeOS and Android
via [ARC Welder][54].)

# Quick Chromebook Introduction
You can find thousands of apps for the Chromebook on the web
to do things like create documents, edit photos, and listen to music in the browser.
Google has provided a recommendation list at the sites like
"[Find apps for your Chromebook][26]",
"[10 Top Tweaks and Tips for Chromebook][27]",
"[Chromebook tips and tricks: Getting the most out of your Chrome OS machine][29]",
"[15 essential Chrome OS keyboard shortcuts][30]".

## Chromebook as a Development Environment
I'm not the first to consider the Chromebook as an alternative development environment.
In fact, Martin Malinda's posting
Ultimate guide for Web Development on Chromebook —
[Part 1: Crouton][55] and
[Part 2: ChromeOS tricks and workflows][56]
and Joe Marini's [Tools for Developing on ChromeOS][57]
are a good read to understand how to make the Chromebook a powerful developers tool.

Keep in mind that the Chrome browser comes pre-packaged with
Chrome Developer Tools ([DevTools][62] for short),
which is a set of web authoring and debugging tools built into Google Chrome.
I will not cover that here, but you can learn more about it at
[Code School][63] for free.
DevTools can also optimize your workflow and make life easier.

## Working with Chromebook / Chrome Browser
Switching from a PC to a Chromebook comes with a few adjustments.
For one, you’ll need to have access to a WiFi signal for most Chrome apps to function.
Also, the Chromebook doesn't have a standard PC keyboard (e.g. no Page Up / Down keys).
For a fuller list of shortcuts,
see "[Cheatsheet: Chromebook and Chrome OS Keyboard Shortcuts][XXX]".

There are several features that are not available from the Chrome Menu,
which you can access only from a special URI scheme to
display some special pages that show information about memory usage, cached files, plug-ins and more.
These commands start with an `about:` or `chrome://`.
Check out "[20+ Google Chrome's about: and chrome:// commands][25]" more information,
or to get a full listing of these commands,
put "`about:about`" in the Chrome browsers commandline.
There is even [experimental features][28] offered by Chrome via `chrome://flags`.

## Working With Chrome OS
Chromebooks are foundationally different from traditional PCs,
and there are a [lot of misconceptions][66]
about how they work and what they can and cannot do.
The fact is, Chromebooks with its Chrome OS are [very capable machines][67].
First of all, [Chrome OS][68] (designed by Google) is based upon the Linux kernel.
This gives the OS a great number of things it can exploit.

In this section, I'm going to touch on only those things most relievent to
installing Linux but for some additional Chrome OS commands, tips, and tricks,
check out the following:

* [Chrome Story][37]
* [100 Tips for Google Chrome][41]
* [Getting Started with your Chromebook][35]
* [100 Best Chromebook Tips, Tricks and Time Savers][36]
* [11 tips to get the most out of your Chromebook][50]

### Crosh
Crosh is a shell environment known as “Chrome Shell”
that is provided with Chrome OS.
Crosh allows users to run [several commands][65] directly from Chrome OS.
Developer mode is not required to use crosh.
The vast majority of linux commands are locked down inside crosh
unless you are in [developer mode][69].

Crosh can be accessed by pressing `Ctrl`+`Alt`+`T` on the keyboard.
This will open a new tab with the crosh terminal.
**NOTE:** You can actually create as many shells as you want.
Just hit `Ctrl`+`Alt`+`T` again and a second shell will be opened.

`crosh` has two separate versions of help.
you can access basic help in the crosh window by simple typing `help`.
This will give you a list of commands that can be used inside crosh.
To get a list of the more advanced commands type `help_advanced`.
To access further functionality from crosh such as as the Bash Shell,
Chrome OS needs to be in [developer mode][69].

There are several commands included in Chrome OS’s crosh shell.
You'll find many of them documented in these articles:

* [25 Helpful Chrome OS Shell (crosh) Commands](http://krypted.com/unix/helpful-chrome-os-shell-crosh-commands/)
* [10+ Commands Included In Chrome OS’s Hidden Crosh Shell](http://www.howtogeek.com/170648/10-commands-included-in-chrome-oss-hidden-crosh-shell/)
* [Customize Chromebook Chrosh Shell Environment](https://gist.github.com/aaronhalford/a009bc73498407ae80e2)
* [10 Commands In Chrome’s Crosh Shell](http://efytimes.com/e1/fullnews.asp?edid=124113)

Crosh even supports full-blown `bash` shell with ssh-agent and Vim.
To get Vim working, do the following:

```
CTRL+ALT+T
crosh> shell
chrosos@localhost / $ echo $SHELL
/bin/bash
chrosos@localhost / $ vim
```

The problem with running crosh in the browser is that if you want to use shortcuts like `Ctrl`+`w`
(in Vim, for example), Chrome will take the default action associated to that shortcut.
One solution is to open crosh as a window.

You can also put crosh in a window, independent of your Chrome browser.
You can do this via a Chrome app called [Crosh Window][33]
(You must have [Secure Shell][34] installed for this to work).
When clicked, this app opens a new crosh window without any chrome browser,
but pressing `Ctrl`+`Alt`+`T` still brings up crosh in the Chrome browser.

### xiwi - X11 in a Chrome OS Window
One of the most impressive things that you can do with Crouton is run native Linux apps,
either in a window of their own, or as a browser tab, using [`xiwi`][18].
Xiwi is a [X.org][70] X11 backend running unaccelerated integration with Chromium OS.
With xiwi installed,
you can run a X11 desktop environment or
you can launch apps on an individual basis in a Chromium OS window or tab.
You can do things like running the GIMP image editor as a Chrome browser tab.
This is literally as simple as typing `xiwi -t gimp` within crosh, at the Linux command line.
More about this below.

# Crouton
* [Crouton Command Cheat Sheet][16]
* http://fuyuko.net/basic-tweaks-and-tips-for-crouton-in-chromebook/
* https://github.com/dnschneid/crouton/wiki/Crouton-Command-Cheat-Sheet

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

## Managing Crouton
Unlike the Chromebook itself,
whe a new version of Crouton comes out,
the software in your chroot will not automatically update itself.
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
gives some additional pointers on manging your Crounton-enabled Chromebook.
It covers things like backing up the chroot, creating multiple chroots,
deleting a chroot, etc.

# The Linux Install
I choose to use the [Crouton method][03], which is a set of scripts,
to use the Linux command chroot ([Change Root][13]) to simultaneously
run a Linux operating system alongside Chrome OS.
Chroot was meant for Linux administrators to easily fix problems while running as the root,
superuser, without logging off the current user.
Here, it's being used to run a primitive form of container.
It has neither the sophistication of a [virtual machine (VM)][40]
or an advanced container such as [Docker][52] or [Vagrent][53].
What chroot has going for it is that it's very lightweight
and is present on almost all versions of Linux (including Chrome OS).
Its downside is that in this mode users have a great deal of power over their system,
so be careful not to do foolish things with your Chromebook.

I'm also going to install two different X window managers,
[Xfce][47] and [i3][44].
While both are not necessary, they are very different and suited for different needs.
You have a command line choose for which one you wish to start with Linux.

## Step 0: Inttialize New Chromebooks
If your dealing with a new Chromebook,
make sure you have established an initial Google account
and set up the WiFi connectivity.

## Step 1: Backup Your Chromebook Data
Since all of your data is synced to Google Server,
you actually don’t have to worry about losing any data.
The only data that you must make a back-up of is the `Download` folder
because the content of this folder is not synced.

## Step 2: Backup Your Chromebook Environment
Once you have taken the back-up,
it’s also a fail-safe plan to create a restore USB of Chrome OS,
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

As part of the process of enabling Developer Mode, your Chromebook will be “[powerwashed][43].”
All the user accounts and their files will be removed from your Chromebook.
Also keep in mind that Developer Mode will need access to the Internet to download files.
This means you need to have initialized the native Chromebook with access to WiFi.

## Step 4: Download and Install Crouton
Crouton is a set of scripts that bundle up the installation of
Ubuntu or Debian OS for the Chromebook.
All the best documentation is maintained on Github's
[crouton: Chromium OS Universal Chroot Environment][10]
and the [Wiki][15].
There you will find a easy to use link to download Crouton.
Just execute this link [https://goo.gl/fd3zc][11] from your Chromebook browser.
Download Crouton via the link to the directory `Downloads`,
pop open a shell (`Ctrl`+`Alt`+`T`, within the popped up window type `shell` and hit enter),
and run `sh ~/Downloads/crouton` to see some examples on what you can to with this utility.

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
# install your desired Ubuntu release and targets (NOTE: drive is not encripted)
sudo sh ~/Downloads/crouton -r trusty -t xfce-desktop,x11,xiwi,keyboard,extension,core,cli-extra
```

* xfce-desktop - [Xfce][47] is a lightweight desktop environment aiming to be light on system resources,
while still being visually appealing and user friendly.
* xiwi - [xiwi][18] (X11 in a Window) works by creating a window in Chrome and
* x11 - X Window System and is essential to run most programs.
channeling a virtual X11 framebuffer over to it.
* keyboard - adds support for Chromebook keyboard special keys
* extension - implements clipboard syncing through WebSockets so you can copy paste from browser to xiwi tabs and windows without issues.
* core - performs core system configuration (a must have)
* cli-extra - basic command line interface tools like ssh


This installs the Ubuntu instance in the directory
`/mnt/stateful_partition/crouton/chroots/trusty`.
If you choose to install additional instances with crouton, like trusty,
they will be places in
`/mnt/stateful_partition/crouton/chroots`.

The Crouton [Wiki][15] discusses [security][17]
and points out that crouton is not, and cannot be, as secure as Chromium OS in verified mode.
If this is a concern, you can use the second "-e" option to encrypt the Linux instance.

```bash
# install your desired Ubuntu release and targets and encript the drive
sudo sh ~/Downloads/crouton -e -r trusty -t xfce-desktop,x11,xiwi,keyboard,extension,core,cli-extra
```

## Step 6: Test It Out
You can now test out your Ubuntu instance by entering your chroot in commandline mode via:

```bash
# enter command line mode of Linux instance
sudo enter-chroot -n trusty
```

Notice that if you started with a `Ctrl`+`Alt`+`T`,
your Linux instances is running within the Chrome browser tab!
Also notice that your present working directory is `/home/jeff`
and the downloaded instance of crouton is in the directory `/home/jeff/Downloads`.

## Step 7: Install Drop Box
You'll inevitably need to move files into this new environment,
so lets get Dropbox working.
The only way I know of getting Dropbox install on an Ubuntu instance is via the
[Ubuntu Apps Directory][48].
Via the browser,  click on the download button and follow the procedures.

## Step 8: Install i3
[i3][44] is a [tilling window manager][45] that is configurable, fast, well documented,
and primarily targeted at advanced users and developers.
While you may already fined i3 installed,
you can install i3 from via the chroot
(i.e. `Ctrl+Alt+T` then `shell` then `sudo enter-chroot -n trusty`).
Make sure you using the latest version of i3 via `i3wm.org` site:

```bash
# make sure you have the latest linux packages
sudo apt-get update && sudo apt-get dist-upgrade

# this ubuntu repository is provides the latest stable release of i3
sudo echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get --allow-unauthenticated install sur5r-keyring
sudo apt-get update

# install i3
sudo apt-get install i3
```

Your can [run i3 from within xfce by placing it in the "Application Autostart"][46],
but but you can jump right into from crosh shell if you set up your
`.xinitrc` file to execute i3.

```bash
# add exec i3 to ~/.xinitrc
echo "exec i3" > ~/.xinitrc

# launch i3 directly from the crosh shell
# use native Xorg instead of xiwi (linux runs full screen, no access to Chrome)
sudo enter-chroot -X xorg -n trusty xinit

# launch i3 directly from the crosh shell
# use native Xorg instead of xiwi (linux runs full screen, no access to Chrome)
sudo enter-chroot -X xiwi -n trusty xinit
```

The i3 tilling window manager is highly configurable but entirely keyboard driven.
You will not see any buttons or menus,
and for the uninitiated, you'll be completely lost on what to do
to create a window or navigate.
Check out my [cheatsheet][] to find you way out of the darkness.

## Step 9: Final Touches and Make a Backup
Change the name of the Linux system to something memerable:

```bash
# change the computers name
sudo hostname chrbook
```

## Step N: Push Backup to Google Drive

# Starting Up Linux and Linux Apps
There are several ways to start up your Linux instance on the Chromebook,
but they all start from the crosh shell.
To get to the crosh shell,
type `Ctrl`+`Alt`+`T` to bring up a Chrome Shell or `crosh`.
Then type `shell` at the prompt to get to the root Linux shell
(this can only be done in [Developer Mode][19]).
Now within this window, enter one of the following:

```bash
# command line only
sudo enter-chroot -n trusty

# run full Xfce Window Manger
# use native xiwi (linux runs in chroos window or Chrome tab)
sudo startxfce4 -X xiwi -n trusty

# run full Xfce Window Manger
# use native Xorg instead of xiwi (linux runs full screen, no access to Chrome)
sudo startxfce4 -X xorg -n trusty

# lightweight, tilling window manager - i3 Window Manager
sudo enter-chroot -X xiwi -n trusty xinit
```

You can also run Linux programs, including X Window programs,
as individual programs without pulling up a desktop envirnment as you do with xfce and i3.
With the [crouton chrome extension & xiwi][12],
this enables running the X11 windows in the Ubuntu chroot as
native Chrome OS windows.
You enter chroot via `sudo enter-chroot` and the run the app via `xiwi`.
you use `xiwi -T <app>` to launch in Chrome browser tab,
or `xiwi -F <app>` to launch full-screen.
You can silence output and run the command in the background via
`sudo enter-chroot -b xiwi -T <app>`.

You can launch individual apps in crouton windows by using the "xiwi" command
in the chroot shell.
Use startxiwi to launch directly from the host shell.
Use the startxiwi parameter -b to run in the background.

If your application forks and quits,
xiwi may get confused and quit as well
(you'll get an error/quit when the window launches).
Often you must pass your app the  `-f` parameter.
If you can't find one,
you can pass `-f` to xiwi itself
(e.g., `xiwi -f gvim` or `xiwi gvim -f`),
and xiwi will not close unless there are no applications visible
and you close the Chromium OS window.
Also, xiwi doesn't know you current directory so use full paths
(e.g. `sudo enter-chroot -b xiwi gimp ~/Downloads/img.jpg`).

For example,

```bash
# run the program node-red in the background
sudo startxiwi -b node-red

# run the program node-red in the foreground (also brings up an additional window)
Sudo enter-chroot xiwi node-red

# run a xterm in the forground
sudo startxiwi -f xterm
xiwi -f xterm
```

https://support.google.com/chromebook/answer/1047367?hl=en&ref_topic=2589149
http://blog.laptopmag.com/how-to-right-click-on-a-chromebook

## Xhost / Xauth
The X server will not accept connections from just anywhere.
You don't want everyone to be able to display windows on your screen or read what you type
(Someone with access to your display can read and write your screens, read your keystrokes, and read your mouse actions).
The X Server has ways to authenticating connections to it: the host list mechanism (`xhost`)
and the magic cookie mechanism (`xauth`).
Then there is `ssh`, the secure shell, that can forward X connections.

Some X Servers can be configured not to listen on the usual TCP port where you would access the X Server.xi
Notably the default configuration of Debian GNU/Linux is to disable the X server listening on the TCP port.
If you wish to use remote X on a Debian system, you should re-enable this by altering the way the X server is started. Look at /etc/X11/xinit/xserverrc for a start.

finish finish finish finish

http://www.tldp.org/HOWTO/Remote-X-Apps-6.html
http://users.stat.umn.edu/~geyer/secure.html
http://serverfault.com/questions/51005/how-to-use-xauth-to-run-graphical-application-via-other-user-on-linux
http://www.tldp.org/HOWTO/Remote-X-Apps-6.html

## Changing Host Name
The Linux instance host name will default to `localhost`.
[This can be changed][64] to something more appropriate, like `chromebook`, via

```bash
sudo homstname chromebook
```

## Aliases
To make this all easier to remember, you could create some aliases'.
Aliases have to be stored in `~/.bashrc` to persist indefinitely
(Note `~` is `home/chronos/user`.  Make sure to do `cd` when you enter the shell).

There is one problem with aliases'.
If you launch applications via aliases,
the xiwi command will not know about them.
You can add the [following snippet][42] to your `~/.bashrc` to handle basic aliases:

```bash
# Wrap xiwi so that aliases work
xiwi() {
    local xiwiargs=''
    while [ "${1#-}" != "$1" ]; do
        xiwiargs="$xiwiargs $1"
        shift
    done
    local cmd="`alias "$1" 2>/dev/null`"
    if [ -z "$cmd" ]; then
        cmd="$1"
    else
        eval "cmd=${cmd#*=}"
        cmd="env $cmd"
    fi
    shift
    eval "/usr/local/bin/xiwi $xiwiargs $cmd \"\$@\""
}
```

For example, to create an alias for starting i3, xfce, and command line version of Ubuntu
I putting the following in my  `~/.bashrc` file:

```bash
```

>NOTE: You do your edits of `~/.bashrc` from inside your crosh/shell, edit, not chroot.

## Switching Between Crouton and ChromeOS
You can switch between your Crouton session and ChromeOS by using four keys:
`CTRL+ALT+SHIFT+→` (the left or right arrow key on the top row of your keyboard).
Left or right arrow will toggle you between Crouton / ChromeOS session.

## Linux in a Chromium OS Window
https://github.com/dnschneid/crouton/wiki/crouton-in-a-Chromium-OS-window-(xiwi)

## Markdown
https://chrome.google.com/webstore/detail/markdown-preview/jmchmkecamhbiokiopfpnfgbidieafmd

#### Ssh Tunnelling on Chrome OS
To use [ssh tunnelling on Chrome OS][20],
open the crosh shell by pressing `Ctrl`+`Alt`+`T` anywhere in Chrome OS.
The shell will open in a browser tab.
Next, use the appropriate `ssh` command to connect to an SSH server and establish a tunnel.
You’ll do this by running the `ssh` command and then by typing every option on its own line, like so:

![crosh ssh](http://cdn3.howtogeek.com/wp-content/uploads/2014/11/img_546b9898a9e3f.png)

You could also just type in the whole line like `ssh jeff@desktop`
to secure shell into the `desktop` system using the login `jeff`.

While chromebook can support `ssh` natively, it is a bit limited.
I have run had problem getting access to devices running OpenWrt,
bu there are some [apps you can install that give more full features][73].

#### Connectivity Command
[CHROME OS – USING THE CROSH CONNECTIVITY COMMAND](https://failicide.wordpress.com/2015/02/19/chrome-os-using-the-crosh-connectivity-command/)

### Linux
Xfce tweaks

* Turn on X11 Forwarding - http://www.webupd8.org/2013/12/things-to-do-after-installing-ubuntu-on.html
* Make sure the TERM varable is set to the same value as the remote system your logging into (XTERM=xterm-256color)
* download your .bash, .vim, etc.


## Getting to a Command Prompt
https://www.chromium.org/chromium-os/poking-around-your-chrome-os-device

## Chromebook Factory Reset
http://www.cnet.com/how-to/what-does-it-mean-to-powerwash-a-chromebook/

## Run Linux Desktop in Browser Tab
http://www.howtogeek.com/208368/how-to-run-a-full-linux-desktop-in-a-browser-tab-on-your-chromebook/

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
* Ultimate guide for Web Development on Chromebook — [Part 1: Crouton][55] and [Part 2: ChromeOS tricks and workflows][56]
* [Tools for Developing on ChromeOS][57]

## Printing with Chromebook
So how do you print on a Chromebook?
You use [Google Cloud Print][59].
Some new printers support Google Cloud Print,
so you can connect them to your network and easily print to them.
If you have an old printer connected to a Windows or Mac computer,
you can use the Google Cloud Print Connector feature to make an older printer
accessible to Google Cloud Print.
Don’t try to plug your printer directly into your Chromebook, though — that won’t work.

## Chromebook Backup
The [Github Wiki for Crouton][49] provides a very complete description of making backups.
The command below should get started quickly on do a Crouton chroot backup,
but its wise to read the wiki.

These command creates a tar archive in the current directory from which
the command is executed.
When doing the backup, enter crosh and shell,
and make sure no other chroot intances are running.

*[An Official Google Drive for Linux is Here, Sort Of — Maybe This Is All We’ll Ever Get](http://www.howtogeek.com/196635/an-official-google-drive-for-linux-is-here-sort-of-maybe-this-is-all-well-ever-get/)
*[Using Google Drive from the Linux Command Line](http://linuxnewbieguide.org/?p=1078)
*[GDRIVE: A SIMPLE GOOGLE DRIVE CLI CLIENT (CROSS-PLATFORM)](http://www.webupd8.org/2014/09/gdrive-simple-google-drive-cli-client.html)
*[How to sync Google Drive from the command line on Linux](http://xmodulo.com/how-to-sync-google-drive-from-the-command-line-on-linux.html)

Push the file to Google Drive
http://www.howtogeek.com/196635/an-official-google-drive-for-linux-is-here-sort-of-maybe-this-is-all-well-ever-get/

https://developers.google.com/drive/v2/reference/files/insert

```bash
# move to the directory where you want the backup saved
cd ~/Downloads

# backup your chroot files
sudo edit-chroot -b trusty

# move the tar file to GDrive
xxx
```

You can restore the backup later with the following command:

```bash
# restore your backup
sudo edit-chroot -r trusty
```

Or perhaps you’ve powerwashed your Chromebook and you want to get
your customized Linux environment back.
You can run the following command while installing Crouton.
The Crouton installer script will restore your chroot
from the backup file you provide,
so replace `backupfile.tar.gz` with the name of the backup file you want to restore.

```bash
# restore backup to a powerwashed Chromebook
sudo sh ~/Downloads/crouton -f backupfile.tar.gz
```

# Connecting Chromebook to Ethernet
Wireless internet is great,
but sometimes you might find yourself in a situation where only
a physical Ethernet Internet connection will do.
Most Chromebooks do not include an Ethernet LAN port,
but you can easily add this functionality with a USB Ethernet adapter.
Headed on over to Amazon to look for an adapter.
I got the [Rankie SuperSpeed USB 3.0 to RJ45 Gigabit Ethernet Network Adapter - R1161][72].
It works fine with my Chomebook's USB 3.0 port and it was just plug and play.

# Chrome Apps to Install
* Ultimate guide for Web Development on Chromebook — [Part 1: Crouton][55] and [Part 2: ChromeOS tricks and workflows][56]

* [Postman][60] is a great utility for testing REST based APIs.
* [GistBox][81] can access and store code snippets (or "Gists", in their terms) for easy access them from everywhere.

### Dropbox
* https://github.com/dnschneid/crouton/wiki/Dropbox
* [How to enable Dropbox integration into the file manager on your Chromebook](http://www.androidcentral.com/how-enable-dropbox-integration-file-manager-your-chromebook?utm_source=related&utm_medium=module&utm_campaign=next)

### Chrome Remote Desktop
http://computers.tutsplus.com/tutorials/use-chrome-remote-desktop-to-access-your-computer-anywhere--cms-21227

### Microsoft Apps
http://www.omgchrome.com/microsoft-brings-office-online-chrome-web-store/

# Run Android App On Chromebook
Eventually, Google hopes, you’ll be able to run potentially millions of Android apps
within Chrome or Chrome OS once they’re formally ported over.
But you can get make that vision start to happen today—with a new Google tool called ARC Welder.

* [Here's how to run Android apps on Chrome with Google's new tool](http://www.pcworld.com/article/2905297/heres-how-to-run-android-apps-on-chrome-with-googles-new-tool.html)
* [How to Install Android Applications Directly on Chromebook](https://www.maketecheasier.com/install-android-applications-chromebook/)
* [How to install Android apps on Chrome/Chromebooks](https://www.youtube.com/watch?v=fgOd0qdR_AU)




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
[25]:http://techmeasy.blogspot.com/2011/10/20-google-chromes-about-and-chrome.html
[26]:https://support.google.com/chromebook/answer/1056325?hl=en
[27]:http://www.technorms.com/35871/top-tweaks-and-tips-for-chromebook
[28]:http://beebom.com/2015/10/chrome-flags-guide-to-enhance-web-browsing
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
[42]:https://github.com/dnschneid/crouton/wiki/crouton-in-a-Chromium-OS-window-(xiwi)
[43]:http://www.cnet.com/how-to/what-does-it-mean-to-powerwash-a-chromebook/
[44]:http://i3wm.org/
[45]:https://en.wikipedia.org/wiki/Tiling_window_manager
[46]:https://github.com/dnschneid/crouton/wiki/i3
[47]:http://www.xfce.org/
[48]:https://apps.ubuntu.com/cat/applications/nautilus-dropbox/
[49]:https://github.com/dnschneid/crouton/wiki/Backups
[50]:http://www.geek.com/chips/11-tips-to-get-the-most-out-of-your-chromebook-1637058/
[51]:http://tomwwolf.com/chromebook-14-compedium/chromebook-crouton-cookbook/
[52]:https://www.docker.com/
[53]:https://www.vagrantup.com/
[54]:https://chrome.google.com/webstore/detail/arc-welder/emfinbmielocnlhgmfkkmkngdoccbadn
[55]:https://medium.com/@martinmalinda/ultimate-guide-for-web-development-on-chromebook-part-1-crouton-2ec2e6bb2a2d#.unzzpg2a1
[56]:https://medium.com/@martinmalinda/ultimate-guide-for-web-development-on-chromebook-part-2-chromeos-tricks-and-workflows-4dfcc308d391#.k4axwqchl
[57]:http://joemarini.blogspot.com/2013/11/tools-for-developing-on-chromeos.html
[58]:https://sites.google.com/site/chromeoswikisite/home/what-s-new-in-dev-and-beta/developer-mode
[59]:http://www.cnet.com/how-to/how-to-print-from-a-chromebook/
[60]:https://www.getpostman.com/
[61]:https://chrome.google.com/webstore/detail/gistbox-desktop/pdjgfbgklbmmigkmmdbbhfchdldngkml
[62]:https://developers.google.com/web/tools/chrome-devtools/
[63]:https://www.codeschool.com/courses/discover-devtools
[64]:http://www.ducea.com/2006/08/07/how-to-change-the-hostname-of-a-linux-system/
[65]:http://krypted.com/unix/helpful-chrome-os-shell-crosh-commands/
[66]:http://www.computerworld.com/article/2474456/cloud-computing/say-what-3-major-misconceptions-about-google-s-chrome-os.html
[67]:http://www.pcworld.com/article/2691209/5-powerful-things-you-didnt-know-chromebooks-could-do.html
[68]:https://en.wikipedia.org/wiki/Chrome_OS
[69]:http://www.howtogeek.com/210817/how-to-enable-developer-mode-on-your-chromebook/
[70]:http://x.org/wiki/
[72]:https://www.amazon.com/Network-Adapter-Rankie-SuperSpeed-Ethernet/dp/B010SEARPU/ref=sr_1_3?ie=UTF8&qid=1476410333&sr=8-3&keywords=ethernet+adapter
[73]:https://chrome.google.com/webstore/detail/secure-shell/pnhechapfaindjhompbnflcldabbghjo?utm_source=gmail
[74]:https://en.wikipedia.org/wiki/Chroot
[75]:https://help.ubuntu.com/community/BasicChroot
[76]:http://unix.stackexchange.com/questions/105/chroot-jail-what-is-it-and-how-do-i-use-it
[77]:
[78]:
[79]:
[70]:
[80]:
