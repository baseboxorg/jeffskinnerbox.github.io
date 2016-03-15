Status: draft
Title: Cheatsheet: i3 Window Manager
Date: 2100-01-01 00:00
Category: Software
Tags: i3, Window Manager
Slug: cheatsheet-i3-window-manager
Author: Jeff Irland
Image: cheat-sheet.jpg
Summary: The i3 tiling window manager is a nice modern tiling window manager that works unders GNU/Linux/BSD operating systems. It supports tiling, stacking, tabs, virtual desktops, and multiple monitors. You can do almost everything from the keyboard, or mix up keyboard and mouse.  It's well documented and real simple to modify and tinker with. With extremely easy to remember keybindings, using i3 is extremely enjoyable, even without the need for a mouse.

<a href="https://i3wm.org/">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="i3 is a tiling window manager designed for X11  and runs on all version of Linux. It supports tiling, stacking, and tabbing layouts, which it handles dynamically. Configuration is achieved via plain text file and extending i3 is possible using its Unix domain socket and JSON based IPC interface from many programming languages." alt="i3-logo" src="{filename}/images/i3_window_manager_logo.png" width="100" height="100" />
</a>
 The [i3 tiling window manager][01] is a nice modern tiling window manager
 that is open source and very well documented.
 It supports tiling, stacking, tabs, virtual desktops, and multiple monitors.
 You can do almost everything from the keyboard, or mix up keyboard and mouse.
 i3 is highly configruable and not dogmatic about tiling geometry and lets you have it your way.

 ## Installing i3
Install i3, then log out,
and you log back in change your window manger as i3 from your display manager screen.
Here is what you should install:

```bash
sudo apt-get install i3 i3lock xautolock i3status feh wmctrl x11-utils
```

On its first run i3 walks you through a simple configuration wizard.
First you must decide if you want the wizard to create a `~/i3/config` file.
Say yes.
Then choose your mod (modifier) key, either the `Win`
(on many keyboards it bears the Windows logo) or `Alt` key.
If you choose the `Alt` keep in mind that you could conflict
with a lot of application keybindings and commands, so choose `Win` is a good option.
On a Chromebook, there is no `Win` key, so you best bet is the `Alt`.

## Installing i3 Extentions
When i3 is installed,
the background image is whatever has been set for your X11 root window.
You need an external app to set a background image.
`feh` is a nice little app for this.
Open `~/i3/config` and configure a background image
by adding line like this anywhere in the file:

```bash
exec --no-startup-id feh --bg-scale /path/to/picture
```

* `--no-startup-id` disables the startup notification so you don't have an hourglass in your way for 60 seconds.
* `--bg-scale` makes your image fill the screen, and does not preserve the aspect ratio.

## Tools to Help Discover Key Names
Keynames are not always consistent on keyboards,
so you can find the correct keynames with the `xev` command
(contained in the `x11-utils` package).
Run `xev` with no options, and then press keys to see their names and keycodes.
Here is an example when pushing and relasing the "q" key:

```
jeff@desktop: ~ $ xev
  .
  .
  .
KeyPress event, serial 32, synthetic NO, window 0x1000001,
    root 0xd4, subw 0x0, time 254041809, (443,89), root:(447,903),
    state 0x0, keycode 24 (keysym 0x71, q), same_screen YES,
    XLookupString gives 1 bytes: (71) "q"
    XmbLookupString gives 1 bytes: (71) "q"
    XFilterEvent returns: False

KeyRelease event, serial 32, synthetic NO, window 0x1000001,
    root 0xd4, subw 0x0, time 254041927, (443,89), root:(447,903),
    state 0x0, keycode 24 (keysym 0x71, q), same_screen YES,
    XLookupString gives 1 bytes: (71) "q"
    XFilterEvent returns: False
  .
  .
  .
```

## Sending Messages to i3 Window Manager
[i3-msg][02] send messages to i3 window manager

You can do such things as start applications on specific workspaces when i3 starts.
For example, to start firefox on workspace 2,
or to logout of i3, etc.:

```bash
# start firefox on workspace called 2:Web
i3-msg 'workspace 2:Web; exec firefox'

# rename a workspace from 2:Web to FireFox
i3-msg 'rename workspace 2:Web to FireFox'

# reload i3 config file
i3-msg reload

# logout of i3
i3-msg exit
```

## Customizing i3status Bar
i3’s default status bar, encode in the file `/etc/i3status.conf`,
is displayed by a tool called [i3status][03].
Your customized status bar is located in `~/.i3status.conf`.

## Start Applications in Workspaces
start applications on specific workspaces when i3 starts
http://unix.stackexchange.com/questions/96798/i3wm-start-applications-on-specific-workspaces-when-i3-starts

How do you implement layout with the autostarting of applications in the i3 window manager?
http://unix.stackexchange.com/questions/134980/how-do-you-implement-layout-with-the-autostarting-of-applications-in-the-i3-wind

Conky on i3
* https://bbs.archlinux.org/viewtopic.php?id=168415
* http://i3wm.org/docs/user-contributed/conky-i3bar.html
* http://sagar.se/using-conky-with-i3.html
* http://blog.kaiserapps.com/2014/02/my-killer-i3-setup.html

## Basic Layout Management
define containers

Every time you open an application it fills the available space.
Terminals / applications are either lined up side-by-side, or stacked on top of each other.
To open a terminal session, enter `$mod+Return`.
There are also multiple keyboard combinations for selecting the focus window,
such as `$mod+arrow` key.
Press `$mod+v` will cause the next terminal to be stacked vertically,
and `$mod+h` lines them up side-by-side (horizontally).

`$mod+Shift+spacebar` toggles a floating screen.
This removes it from the tiles,
and you can drag it around and resize it like in a non-tiling window manager.

Open a second virtual desktop with `$mod+2`.
i3 closes virtual desktops automatically when you close all the applications on them.
`$mod+n` navigates to an existing virtual desktop, or creates a new one.

`$mod+f` toggles fullscreen.

`$mod+e` toggles horizontal and vertical layout,
`$mod+s` stacks open windows,
and `$mod+w` tabs them.

Open a second virtual desktop with `$mod+2`.
i3 closes virtual desktops automatically when you close all the applications on them.
`$mod+n` navigates to an existing virtual desktop, or creates a new one.
You can also go to a virtual desktop by picking via the mouse the number in lower left.

Resize a window by dragging with the mouse its header bar.

To make a tilled window a floater, `$mod+Shift+Space`.

Drag and resize floating window using `$mod+left/right mouse button`.

## Scratchpad
Scratchpad lets you hide open applications.
For example, if you open up a text document by clicking the file icon in nautilus,
in accordance to the tilling window manager,
it takes one half of the screen.
If you feel nautilus is a nuisance in this situation,
you can hide nautilus by pressing `$mod+Shift+–`, when it is in focus.

This might be useful in situations where you need to compare two documents,
and don’t want the workspace to be taken by other applications.
If you need to bring back applications from scratch, you can press `$mod+–`.
These applications will open in floating mode.
Therefore, to move it back to tilling mode, you can press `$mod+Shift+Space` keys.

## Making Changes to Configuration
For most `~/.i3/config` changes, press `$mod+Shift+c` to reload the file and activate changes.
If that doesn't work then `$mod+Shift+r` restarts i3,
preserving your layout and open applications.
To load your new background image you need to log out of i3 and log back in.
`$mod+Shift+e` exits i3, and then you log back in the usual way with your Linux display manager.

## Auto-start Applications
At launch you configure i3 to run a script to detect/setup
a second display if attached (using [`xrandr`][04]), open a terminal,
and run any extra commands as determined by $HOSTNAME:

## Saving the Screen layout
http://i3wm.org/docs/layout-saving.html
http://www.slackword.net/?p=733

On a Chromebook
For a proper Delete key, usei `bindsym $mod+BackSpace exec xdotool key Delete` in your i3 config

## Cheatsheets
http://i3wm.org/docs/refcard.pdf
http://www.cheatography.com/davechild/cheat-sheets/i3-window-manager/

* General
    * `startx i3` start i3 from command line
    * `$mod+<Enter>` open a terminal
    * `$mod+d` open dmenu (text based program launcher)
    * `$mod+r` resize mode (<Esc> or <Enter> to leave resize mode)
    * `$mod+shift+e` exit i3
    * `$mod+shift+r` restart i3 in place
    * `$mod+shift+c` reload config file
    * `$mod+shift+q` kill window (does normal close if application supports it)

* Windows
    * `$mod+w` tabbed layout
    * `$mod+e` vertical and horizontal layout (switches to and between them)
    * `$mod+s` stacked layout
    * `$mod+f` fullscreen

* Moving Windows
    * `$mod+shift+<direction key>` Move window in _direction_ (depends on direction keys settings)



[01]:http://i3wm.org/
[02]:http://build.i3wm.org/docs/i3-msg.html
[03]:http://i3wm.org/i3status/manpage.html
[04]:http://pkg-xorg.alioth.debian.org/howto/use-xrandr.html
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:
