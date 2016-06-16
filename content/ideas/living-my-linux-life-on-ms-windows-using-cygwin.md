# What is Cygwin?
[!pic](http://i1-news.softpedia-static.com/images/news2/Linux-Will-Probably-Force-Microsoft-to-Offer-Future-Windows-OSes-for-Free-423014-2.jpg)
Cygwin is a Linux-like environment for MS Windows.
You can read more about it on [Cygwin's home page][02]
and it [X Window System][12] version [Cygwin/X][03].
It is a large collection of [GNU][05] and Open Source tools
which provide functionality similar to a Linux distribution,
and a dynamic-link library (`cygwin1.dll`)
which provides substantial [POSIX API][04] functionality.
If your a Unix / Linux lover,
Cygwin can provide you a small island of bliss in the miserable world of MS Windows.

## Basic Installation - DONE
Download the Cygwin `setup.exe` via
[`http://cygwin.com/setup-x86.exe`](http://cygwin.com/setup-x86.exe)
for the 32 bit version or
[`http://cygwin.com/setup-x86_64.exe`](http://cygwin.com/setup-x86_64.exe)
for the 64 bit version.
Keep the `setup.exe` for later,
because you'll want it to update your installation too.
Run it now, and hit "Next".
Answer "Install from Internet" and hit "Next".
Answer "c:\cygwin", "All Users", "Unix / binary", and hit Next.
I don't think the local package directory matters, so just hit "Next".
Hit "Next" again.
Choose a nearby server and hit "Next".

You'll now be asked to select from a nightmarish list of packages.
You'll have trouble guessing what you'll need, but you can come back later for more.
For this initial installation, don't select any (extra) packages, just hit "Next".
Now the main part of the installation will run for several minutes.
Allow the installer to create a desktop shortcut and your now have a basic instance
of Cygwin operational.

For further installation of packages,
you can simply start the installer again and select your package from the menu.
An alternative method is to us the `-P` switch on the `setup.exe` command-line.
Lets add some useful packages using this method
(**Note:** `setup.exe` needs to be run from a DOS prompt not from bash):

```
...\setup.exe -q -P python,wget,awk,gawk,bzip2
```

## Installing Package Manager within Cygwin - DONE
[`apt-cyg`][01] is a Cygwin package manager.
It includes a command-line installer for Cygwin which cooperates with Cygwin Setup
and uses the same repository.
`apt-cyg` operates very much like the Debian Linux `apt-get` package management utility.
The `apt-cyg` utility cannot be used to install Cygwin from scratch.
Before `apt-cyg` can be used or even installed,
the `bash`, `wget`, `tar`, `awk` (or `gawk`) and `bzip2` packages must be installed.

The `apt-cyg` syntax is based on `apt-get` but simplified.
You can use the command like this:

* `apt-cyg install <package names>` to install packages
* `apt-cyg remove <package names>` to remove packages
* `apt-cyg update` to update setup.ini
* `apt-cyg show` to show installed packages
* `apt-cyg find <patterns>` to find packages matching patterns
* `apt-cyg describe <patterns>` to describe packages matching patterns
* `apt-cyg packageof <commands or files>` to locate parent packages

To download and install `apt-cyg` from within Cygwin

```bash
cd /bin
wget https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg
chmod a+x apt-cyg
```

If you have already installed Cygwin
and you are looking for a convenient way to install additional software from the command line,
`apt-cyg` may be just what you need.

## Complete the Install - DONE
Now within a Cygwin terminal at the bash prompt,
you can install some additional useful utilities using `apt-cyg`:

```bash
cyg-apt install git             # version control system
cyg-apt install openssh         # SSH
cyg-apt install screen          # Terminal multiplexer
cyg-apt install xorg-server     # X Windows server
cyg-apt install xinit xlaunch   # X Windows launchers
cyg-apt install diffutils       # diff
cyg-apt install awk gawk sed    # text formating
cyg-apt install vim gvim        # vim text editor
cyg-apt install inetutils       # telenet
cyg-apt install screen          # terminal multiplexer
cyg-apt install aspell-en ctags ncurses
```

## Using Cygwin
[Cygwin/X User's Guide][06]
[Automatically starting a cygwin X Window Server](http://www.trueblade.com/knowledge/automatically-starting-a-cygwin-x-server)

 Cygwin/X can work with a [Window Manager][07] in several different ways.

* **Internal window manager** - The internal window manager creates a MS Windows
window for each top-level X window.  This window manage is "internal" to the Cygwin X Server.
* **External local window managers** -  These local window managers must be
installed on Cygwin and runs on the PC (e.g. twm, mwm, fvwm2, openbox, aewm++, WindowMaker).
* **Remote window managers** - This would be a situation where the window manager
is on the RPi and would connect via a remote sessions using XDMCP (X Display Manager Control Protocol).

I plan to keep things simple and use the Cygwin internal window manage.

[XWin][11] is the [X Server][13] for the [X Window System][12] on the Cygwin environment
running on Microsoft Windows.
It can operate in [three different modes][08]:

* **Single Window** - This is the default mode.
Each X screen appears as a single MS Windows window and all X windows are
contained within this window.
(In X terminology, the MS Windows window contains the [root window][09] for the screen.)
* **Multi-Window** - In this mode XWin uses its own integrated window manager
in order to handle the top-level X windows,
in such a way that they appear as normal MS Windows windows.
* **Rootless** - In this mode the X Server works in a window containing the
whole screen but this root window (traditionally covered with an X hatch pattern)
is hidden from view, so only top-level X windows are seen.

To get a better idea on what the different modes can provide you from a user experience perspective,
check out some [Cygwin/X screen shots][10].
Again, my objectives are to keep things simple and clean, so I will be using the multi-window mode.

## Starting and Stopping the Cygwin X Server

# Node.js
[Step by step instructions to install NodeJS on Windows](http://boxysystems.com/index.php/step-by-step-instructions-to-install-nodejs-on-windows/)

# Installing TiddlyWiki

# Installing Vim Under Windows
While you can use `vim` within the Cygwin environment,
I often find that I just want edit a text fill
and moving to Cygwin just doesn't make sense.
There is a `vim` for Windows, more specifically the graphical version `gvim`.
I have captured some excellent instructions on installing `vim` on Windows,
an article called ["Simple Steps to Help You Install gVim on Windows 7"][14].

### Download and install Vim - DONE
You can install `vim` from [Vim the Editor][15] download page.
Install it in your home directory
(unless you want other users to have access to `vim` _and _
have administrative control over you PC).
In my case, the directory created vor `vim` is `C:\Users\irlanje\Vim`.

Now delete all the folders in the `C:\Users\irlanje\Vim\vimfiles` folder,
but don't delete `vimfiles` itself.
Next open the `C:\Users\irlanje\Vim\vim74` folder and
you'll find another folder under it called `autoload`.
Cut & paste that folder under `vimfiles` so that it now has only the `autoload` folder.
Next, create another folder in `vimfiles` called `bundle`.

### Install Git Under Windows
Since the `vim` plug-ins, resource file, etc. that I'm using are all stored
out on GitHub, installing [Git][16] is a must.
[Download the Windows version of git][17] and install it in my home directory
like you did for `vim`.

### Install Pathogen for Vim Plug-ins

### Install Your Vim Tools

```bash
# install tools for vim text editor
cd ~
git clone https://github.com/jeffskinnerbox/.vim.git
ln -s ~/.vim/vimrc ~/.vimrc
```



[01]:https://github.com/transcode-open/apt-cyg
[02]:http://www.cygwin.com/
[03]:http://x.cygwin.com/
[04]:https://en.wikipedia.org/wiki/POSIX
[05]:https://en.wikipedia.org/wiki/GNU_Core_Utilities
[06]:http://x.cygwin.com/docs/ug/cygwin-x-ug.pdf
[07]: http://x.cygwin.com/docs/ug/using-window-managers.html
[08]:http://x.cygwin.com/docs/man1/XWin.1.html
[09]:http://en.wikipedia.org/wiki/Root_window
[10]:http://x.cygwin.com/screenshots/
[11]:http://x.cygwin.com/docs/man1/XWin.1.html
[12]:https://en.wikipedia.org/wiki/X_Window_System
[13]:http://www.linfo.org/x_server.html
[14]:https://github.com/jeffskinnerbox/.vim/blob/master/Install_gVim_on_Windows.pdf
[15]:http://www.vim.org/
[16]:https://git-scm.com/
[17]:https://git-scm.com/download/win
[18]:
[19]:
[20]:

