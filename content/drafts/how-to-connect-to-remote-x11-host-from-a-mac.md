Status: draft
Title: HowTo: Connecting to Remote X11 Host from a Mac
Date: 2100-01-01 00:00
Category: Software
Tags: Mac, X Window
Slug: howto-connecting-to-remote-x11-host-from-a-mac
Author: Jeff Irland
Image: how-to.jpg
Summary: I want to log into my home Linux box from my work laptop, wich is a Mac.  I also what to use all the tools I  have grown comfortable while on my home system.  This requires X11 to work on the Mac.  This HowTo shows you how this is done on the Mac.

.Xresources or .Xdefaults? - http://superuser.com/questions/243914/xresources-or-xdefaults
A sample .Xdefaults file - http://www2.its.strath.ac.uk/courses/x/subsection3_9_4.html
check out this .Xresource file - http://www.askapache.com/linux/rxvt-xresources.html

Consider getting MacVim - https://github.com/macvim-dev/macvim/releases
Getting MacVim to run properly on Yosemite - http://awebfactory.com/node/541

Logo for XQuartz - http://i1-news.softpedia-static.com/images/news2/X11-and-OS-X-10-8-Mountain-Lion-2.jpg

<a href="http://www.xquartz.org/index.html">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="The XQuartz project is an open-source effort to develop a version of the X.Org X Window System that runs on OS X." alt="XQuartz Logo" src="{filename}/images/take_a_picture.png" width="500" height="500" />
I want to [run a remote X client][04] on my remote Linux desktop (running Ubuntu and X Window)
and get back display to my Apple MacBook Pro laptop with
OS X Yosemite (version 10.10.5) operating system.
I was hoping that since Mac originated from parts of the Linux / X Window world,
I could simply run `ssh -X user@server`, but this doesn't do the trick.

After multiple attempts to get things working,
I [discovered][03] you need to install XQuartz (see `/Applications/Utilities/X11.app` on the Mac)
on OS X v10.8 or above to use ssh with X11 forwarding.
The [XQuartz project][01] is an open-source effort to develop
a version of the [X.Org][05] X Window System that runs on OS X.
This is Apple's version of the X server.
The latest version of Apple OS X no longer ships with X11.app i.e. XQuartz server.
You need to download and install the server before using ssh with X11 forwarding.
Just follow the instructions given [here][03].

Once the install is completed,
click on the XQuratz logo giving you a XTerm,
then run an application on the remote system is use the following commands:

```bash
# execute a XTerm on the remove system and display on you local Mac
ssh -f -X -C user@server-ip

# execute an app on the remote system and display on your local Mac
ssh -f -X -C user@server-ip /path/to/app-name
```

Where,

* **user@server-ip** - Your remote login username and password
* **-f** - Requests ssh to go to background just before command execution. This is useful if ssh is going to ask for passwords or passphrases, but the user wants it in the background. This is the recommended way to start X11 programs at a remote site/host.
* **-X** - Enables X11 forwarding.
* **-C** - Requests compression of all data (including stdin, stdout, stderr, and data for forwarded X11 and TCP connections).
* **-c cipher** - Selects the cipher specification for encrypting the session.
* **-T** - Disable pseudo-tty allocation.

Use comprssion if you think that programs are running slowly because of a lack of bandwidth or network congestion.



[01]:http://www.xquartz.org/
[02]:http://docstore.mik.ua/orelly/networking_2ndEd/ssh/ch09_03.htm
[03]:http://www.cyberciti.biz/faq/apple-osx-mountain-lion-mavericks-install-xquartz-server/
[04]:http://docstore.mik.ua/orelly/unix3/upt/ch06_10.htm
[05]:http://www.x.org/wiki/
[06]:
[07]:
[08]:
