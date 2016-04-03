* [WiFi Ad-hoc Network](https://wiki.debian.org/WiFi/AdHoc#Manual_Method[1])
* [airmesh](http://www.netlore.co.uk/airmesh/)

<a href="https://www.open-mesh.org/projects/open-mesh/wiki">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is a layer 2 routing protocol, implemented in the Linux kernel, for multi-hop ad-hoc mesh networks." alt="batman-adv-logo" src="{filename}/images/batman-adv-log.png" width="115" height="45" />
</a>
I have been thinking about diving into [openHAB][20],
loading it on a [Raspberry Pi][21],
and create a sensor network for some home automation/monitoring devices.
I have also explored using [OpenWrt][22] and [qMp][09] as the network.
I choose [mesh networking][23],
really its a [MANET][24] using a [layer 3 mesh routing protocol][02] like [cjdns][10],
or a level 2 mesh routing protocal like [BATMAN-Adv][05].
Nodes in this mesh network will be gateway'ed and managed via an inexpensive router
(maybe a [Linksys WRT54G][55] or [Western Digital My Net N600][26])
and the nodes will be the [WRTnode][25] or the [GL-AR150][03].
The nodes would then have sensors attached to them.
The ideas I have for sensors include ultrasonic water level monitor for my sump pump,
designed LED lighting for the deck, whole house water leak detection, etc.
An ambitious project I know, but for me, its all about the journey,
not the destination!

I was considering using [Quick Mesh Project (qMp)][09].
qMp is a system for easily deploying Mesh/MANET networks using WiFi technology.
The qMp firmware, based on OpenWrt, works on many embedded WiFi network devices.
The [qMp website states][18] that, in general
every device supported by OpenWrt with 4 MB+ Flash and 32 MB+ RAM can work with qMp.
I have an old [Linksys WRT54G][01] V8 wireless router
and I want to use it as my main node (that is, the node I'll use to mange the network)
for a [Quick Mesh Project (qMp)][09] network.
The main node needs to be beefy enough so support a web server, network management tools, etc.
All the other node, much smaller nodes, will be using WRTnode.

I believe a better alternative to qMp is the [Open-Mesh][04]
routing protocols for ad-hoc networks, [BATMAN-Adv][05].
The name stands for “Better Approach To Mobile Ad-hoc Networking“,
this is a routing protocol for multi-hop ad-hoc mesh networks.
BATMAN-Adv is better supported and documented than qMp.
BATMAN-Adv doesn't claim to have an easy setup like qMp,
but this a small consideration when you see the support behind BATMAN-Adv.
Also, with this project you'll find tools like
`batadv-vis` to visualize your BATMAN-Adv mesh network,
`alfred` for flooding the network with data,
`batctl` is the configuration and debugging tool.

* [airmesh][15]
* [Raspberry Pi WiFi Mesh Network](https://www.raspberrypi.org/forums/viewtopic.php?f=36&t=14835)

## B.A.T.M.A.N. Mesh
Developed by [Freifunk][07] to replace [Optimized Link State Routing Protocol (OLSR)][06]
primarily use case is where a significant number of nodes move around a lot within the mesh area
(vehicle based nodes for instance).
The Open-Mesh web site contains an excellent introduction into the [B.A.T.M.A.N. protocol concept][08].
The original BATMAN protocol ran on the [Network Layer (Layer 3)][13]
but [B.A.T.M.A.N. Advanced (BATMAN-Adv)][05] is a
[Data Link Layer (Layer 2)][12] protocol
and built into the [Linux kernel][11] for greater efficiency.

BATMAN has an extensive history with several branches.
That [history and branching is outlined on the Open-Mesh website][19].
bla bla bla

# Step 1: Prepare the Raspberry Pi
I have a post "XXX-howto-set-up-the-raspberry-pi-as-a-headless-device.md"
that will initialize the Raspberry Pi.
Start with this to get RPi ready for the next steps.

# Step X: Kernel Modual
* [The Kernel Newbie Corner: Your First Loadable Kernel Module](https://www.linux.com/news/software/linux-kernel/23685-the-kernel-newbie-corner-your-first-loadable-kernel-module)
* [Building kernel out of tree](http://www.crashcourse.ca/wiki/index.php/Building_kernel_out_of_tree)
* [Building External Modules - This document describes how to build an out-of-tree kernel module](https://www.kernel.org/doc/Documentation/kbuild/modules.txt)
* [Compiling Kernel Modules](http://www.tldp.org/LDP/lkmpg/2.6/html/x181.html)

Kernel modules, loadable kernel module (LKM),
are pieces of code that can be loaded
and unloaded into the kernel upon demand.
They extend the functionality of the kernel without the need to reboot the system.
Without modules, we would have to build monolithic kernels
and add new functionality directly into the kernel image, creating larger kernels,
and require us to rebuild / reboot the kernel every time we want new functionality.

The term "source tree" refers to the offical, Linux supported kernel source code.
All modules start out as "out-of-tree" developments,
that can be compiled using the context of a source-tree.
Once a module gets accepted to be included, it becomes an "in-tree" module.

To build a Linux kernel "out of tree" is to
leave the source tree alone and generate all output in a separate directory.

Kernel modules, whether in-tree or out-of-tree,
are installed in directories specific to given kernel versions,
that is `/lib/modules/$(uname -r)`.

External modules are installed with modules_install at
`/lib/modules/$(uname -r)/extra/` by default.

# Step X: Installing BATMAN-Adv
BATMAN-Adv is installed via a Linux Kernel modual
and is [now part of the mainline Linux development stream][27].
You can install the packages
[`batctl`][14] (configuration and debugging tool for BATMAN-Adv)
and [`bridge-utils`][16] (utility needed to create and manage bridge devices):

```bash
# install required packages for BATMAN-Adv
sudo apt-get install batctl bridge-utils

# add a loadable kernel module to the Linux kernel and print version
modprobe batman-adv
batctl -v
```

modprobe

While this is easy and convenient, the package could be old.
To get the latest BATMAN-Adv and `batctl` software,
you need to go to the Open-Mesh source code repository.
You'll find links to the latest stable code posted at [Download B.A.T.M.A.N.][17].

* [Compile and install BATMAN-Advanced](https://wiki.hacdc.org/index.php/BATMAN-Advanced_Setup)
* [Mobile Mesh Networks with the Raspberry Pi – Part 1](http://www.ericerfanian.com/mobile-mesh-networks-with-the-raspberry-pi-part-1/)
* [A Raspberry Pi based batman-adv Mesh network node](http://people.skolelinux.org/pere/blog/A_Raspberry_Pi_based_batman_adv_Mesh_network_node.html)
* [Subnodes Project](http://subnodes.org/)
* [Install batman-adv on Raspberry Pi](https://forum.piratebox.cc/read.php?2,5256)
* [Raspberry Pi, Raspbian, Wireless and BATMAN-ADV for meshing](http://mindofdes.blogspot.com/2013/02/raspberry-pi-raspbian-wireless-and.html)
* [B.A.T.M.A.N. (2013.2.0) configuration on Ubuntu 12.10](https://dev.wlan-si.net/ticket/1114)

# Step X: XXX
[B.A.T.M.A.N. Advanced quick start guide](https://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide)

# Step X: batctl
When BATMAN was moved from layer 3 to layer 2 to become BATMAN-Adv operating within the kernel,
a handy tool to manage the module and debug the network became necessary.
The `batctl` tool was created to fill that gap.
As such, [batctl][14] is the configuration and debugging tool for BATMAN-Adv.
`batctl` offers a convenient interface to all the BATMAN-Adv
kernel module's settings as well as status information.
It also contains a layer 2 version of ping, traceroute and tcpdump,
since the virtual network switch is completely transparent for all protocols above layer 2.

All configuration of BATMAN-Adv is done in the virtual filesystem `sysfs`
and `batctl` is merely a convenient interface to this.

* [Using batctl](https://www.open-mesh.org/projects/batman-adv/wiki/Using-batctl)

# Step X: alfred
`alfred` is a user space daemon for distributing arbitrary local information
over the mesh in a decentralized fashion,
but `alfred` is not required to run a batman-adv mesh network.
This data can be anything which appears to be useful.
You may distribute hostnames, administration information, DNS information, etc.
`alfred` does not strictly require BATMAN-Adv to operate,
but can use neighborhood information from BATMAN-Adv when available.

# Step X: XXX

# Step X: Mixing non-BATMAN Systems with BATMAN-Adv
If you have a couple of computers that you don't want to run BATMAN-Adv on
but you still want make use of the mesh network,
you will need to configure an entry point for them on a node running BATMAN-Adv.
Any device running Linux can be setup to work as a mesh entry point.

* https://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide#Mixing-non-BATMAN-systems-with-batman-adv



[01]:http://support.linksys.com/en-us/support/routers/WRT54G
[02]:http://bmx6.net/projects/bmx6
[03]:http://www.gl-inet.com/ar150/
[04]:https://www.open-mesh.org/projects/open-mesh/wiki
[05]:https://www.open-mesh.org/projects/batman-adv/wiki/Doc-overview
[06]:https://en.wikipedia.org/wiki/Optimized_Link_State_Routing_Protocol
[07]:http://freifunk.net/en/what-is-it-about/
[08]:https://www.open-mesh.org/projects/open-mesh/wiki/BATMANConcept
[09]:http://qmp.cat/Home
[10]:https://github.com/cjdelisle/cjdns/blob/master/doc/Whitepaper.md
[11]:https://en.wikipedia.org/wiki/Linux_kernel
[12]:https://en.wikipedia.org/wiki/Data_link_layer
[13]:https://en.wikipedia.org/wiki/Network_layer
[14]:https://downloads.open-mesh.org/batman/manpages/batctl.8.html
[15]:http://www.netlore.co.uk/airmesh/?page=about
[16]:http://www.linuxfromscratch.org/blfs/view/svn/basicnet/bridge-utils.html
[17]:https://www.open-mesh.org/projects/open-mesh/wiki/Download
[18]:http://qmp.cat/Supported_devices
[19]:https://www.open-mesh.org/projects/open-mesh/wiki/BranchesExplained
[20]:http://www.openhab.org/
[21]:http://www.raspberrypi.org/
[22]:https://openwrt.org/
[23]:http://en.wikipedia.org/wiki/Mesh_networking
[24]:http://en.wikipedia.org/wiki/Mobile_ad_hoc_network
[25]:http://wrtnode.com/
[26]:http://www.wdc.com/wdproducts/library/UM/ENG/4779-705072.pdf
[27]:https://www.open-mesh.org/projects/open-mesh/wiki/2009-10-23-batman-goes-mainline
[28]:
[29]:
[30]:
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
