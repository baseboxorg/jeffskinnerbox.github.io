[Hyperboria DNS solution](http://nxter.org/hyperboria-adopts-nxt-aliases-for-dns-solution/)
[CJDNS NAT Gateway](https://github.com/cjdelisle/cjdns/blob/master/doc/nat-gateway.md)
[fc00](https://www.fc00.org/about)

[cjdns][03] is the routing protocal used by the mesh network [Hyperboria][01],
formerly known as [Project Meshnet][02].
As illustrated in the [promotional video for Hyperboria][11],
its aim is to build a global decentralized computer network based
"on secure protocols for routing traffic over private mesh or
public internetworks independent of a central supporting infrastructure."
So its a decentralized alternative to the Internet (aka [clearnet][12])
with privacy, security, and scalability as the main features.
Networks like Hyperboria are called a [darknet][10] as the are an overlay network
that can only be accessed with specific authorization.
Its like being your own ISP,
independent of the existing infrastructure by joining a local meshnet
or by overlaying your end-to-end encrypted traffic over the Internet (ivp6 over ipv4).
Anyone can join the Hyperboria network by installing [cjdns][03]
and connecting to existing peers.
Its not only about sticking it to the ISPs but addressing some [sociopolitical issues][04]
via "[meshnet activism][09]".

By installing and running cjdns on a home computer, for example,
that computer becomes a cjdns node that can be networked
with any other machine that is also running the protocol.
You can find a more extensive explaintion of cjdns objectives
within [Project Goals][13] and [whitepaper][14] documents on Github.

A few local cjdns communities, called [mesh locals][08] have been established in
[Seattle][05], [NYC][06] and [Maryland][07].
A 'Mesh Local' is a mesh network situated in a particular geography,
focused on providing a community-centric alternative (or complement) to the internet.
The cjdns protocal was designed to be agnostic of the medium over which it communicates.
That means that even if the closest node is beyond the functional range
of that nodes wireless radio, you can still peer with it over the internet.
As a result, you local network can peer with distant cjdns network nodes.

For a more complete introduction of CJDNS and Mesh Networking,
check out my posts xxx and xxx.

###############################

Hyperboria Documenation - https://docs.meshwith.me/

###############################

The general procedure for creating a mesh network with cjdns is:
1. Install cjdns to create a node by following the [README file on Github][03].
1. Make sure your node is configured correctly, which can be determined from the XXXXX Trouble Shooting guide.
1. Locate your nearest Mesh Local, find a peer, and connect your node up with the network.

# Step 1: Prepare the Raspberry Pi - DONE
I have a post "XXX-howto-set-up-the-raspberry-pi-as-a-headless-device.md"
that will initialize the Raspberry Pi.
Start with this to get RPi ready for the next steps.

# Step 2: Retrieve cjdns from GitHub and Build It - DONE
Once you’ve gotten this far,
the instructions on the [Github page of the cjdns source code][03]
(aka README.md file)
walk you through installation, setup of cjdns,
and connecting to friends on the mesh.

```bash
# make sure you already have all the required packages
sudo apt-get install nodejs build-essential git

# go to where you want to place the cjdns source and clone from GitHub
cd /opt
sudo git clone https://github.com/cjdelisle/cjdns.git cjdns

# go to the source directory and run a script to make cjdns
cd cjdns
sudo ./do
```

When you get the message
"Build completed successfully, type ./cjdroute to begin setup"
you can then proceed to the next step.

>**NOTE:** When building cjdns, I recieved the message "Failed to build cjdns.".
I did a search for a solution and I was advised to use the following as a work around:
`sudo NO_TEST=1 Seccomp_NO=1 ./do`.
This gave me the desired message "Build completed successfully, type ./cjdroute to begin setup.".

# Step X: XXX

# Step X: XXX

# Step X: Peering

# Step X; Testing
Most of you might have come across a service called Reddit and some of you might even be very active there. The source code for reddit is available for public. Similarly there is an service called UPPIT in Hyperboria which is a clone of Reddit that will be accessible only on Hyperboria network but not through the regular Internet.

If you try connecting to http://uppit.us through regular internet,
you cannot access the service, but once you started using cjdns & connected to Hyperboaria,
only then you can get access to uppit.us service.


# Heartbeat Services
* [Getting Started with Heartbeat](http://www.linuxjournal.com/article/9838)
* [Linux heartbeat installation](https://www.watters.ws/mediawiki/index.php/Linux_heartbeat_installation)
* [Heartbeat Clustering in Linux](http://www.linuxnix.com/heartbeat-clustering/)
* [The Linux-HA User’s Guide](http://www.linux-ha.org/doc/users-guide/users-guide.html)

# Meshing Raspberry Pi
* [Mesh networking with multiple Raspberry Pi boards](http://hackaday.com/2012/11/14/mesh-networking-with-multiple-raspberry-pi-boards/)
* [Raspberry Pi Wireless Mesh: Scripts, Data, Plots – oh my!](http://lab.uchicago.edu/2013/09/27/raspberry-pi-wireless-mesh-scripts-data-plots-oh-my-part-1/)

# Meshing Raspberry Pi with CJDNS
* [Getting started with Hyperboria (cjdns), on Linux](http://meshbits.io/getting-started-with-meshnet-on-linux/)
* [Running cjdns on Raspbian Jessie](http://mesh.philly2600.net/?p=54)
* [Meshberry v0.2](https://nycmesh.net/meshberry/)
* [How to Connect to a DarkNet](http://www.tinkernut.com/portfolio/connect-to-a-darknet/)
* [Hyperboria Documentation](https://docs.meshwith.me/)



[01]:http://hyperboria.net/
[02]:https://projectmeshnet.wordpress.com/
[03]:https://github.com/cjdelisle/cjdns
[04]:http://makezine.com/2014/11/26/how-meshnets-are-changing-the-face-of-the-web/
[05]:https://seattlemesh.net/about
[06]:https://nycmesh.net/
[07]:https://www.reddit.com/r/marylandmesh
[08]:https://github.com/cjdelisle/cjdns/tree/master/doc/meshlocals/existing
[09]:https://www.newscientist.com/article/mg21929294.500-meshnet-activists-rebuilding-the-internet-from-scratch
[10]:https://en.wikipedia.org/wiki/Darknet
[11]:https://www.youtube.com/watch?v=pSSiqlwzA3U
[12]:https://en.wikipedia.org/wiki/Clearnet_(networking)
[13]:https://github.com/cjdelisle/cjdns/blob/master/doc/projectGoals.md
[14]:https://github.com/cjdelisle/cjdns/blob/master/doc/Whitepaper.md
[15]:
[16]:
[17]:
[18]:
[19]:
[20]:
