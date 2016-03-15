[Hyperboria DNS solution](http://nxter.org/hyperboria-adopts-nxt-aliases-for-dns-solution/)
[CJDNS NAT Gateway](https://github.com/cjdelisle/cjdns/blob/master/doc/nat-gateway.md)
[fc00](https://www.fc00.org/about)
[hyperboria/docs](https://github.com/hyperboria/docs)
[Could You Make Your Own Internet?](https://www.youtube.com/watch?v=OnKMkX0qS3Y)

<a href="https://hyperboria.net/">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="Hyperboria is a peer-to-peer IPv6 network with automatic end-to-end encryption, distributed IP address allocatioonnd  the cjdns routing protocol. " alt="hyperboria-logo" src="{filename}/images/hyperboria-logo.png" width="270" height="58" />
</a>
[cjdns][03] is the routing protocol used by [Hyperboria][01][^A],
formerly known as [Project Meshnet][02].
Hyperboria is an encrypted Mesh Network that utilizes cjdns,
a [network layer (aka layer 3)][22] routing protocol
which implements [end-to-end encryption][21].
As illustrated in the [promotional video for Hyperboria][11],
its aim is to build a global decentralized computer network based
"on secure protocols for routing traffic over private mesh or
public internetworks independent of a central supporting infrastructure."

[^A]:
    In Greek mythology, the [Hyperboreans][24] were mythical people who lived "beyond the North Wind".
    The Greeks thought that Boreas, the god of the North Wind, lived in Thrace,
    and therefore Hyperborea indicates a region that lay far to the north of Thrace.
    This land was supposed to be perfect, with the sun shining twenty-four hours a day.

Hyperboria is a [pseudonymous network][27]
(meaning "false name" or state of disguised identity),
your direct peers can tell where you are (by virtue of their connection),
but no one else can (unless you expose your data personally).
Such a network is resistant to revealing you identity since
each node in a communication path must give up your idenity.
Given Hyperboria's usage focus is on freedom of access and free speech,
[Hyperboria makes a logical case][28] for this less than guaranteed, absolute anonymity.

So Hyperboria is a decentralized alternative to the Internet (aka [clearnet][12])
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
You can find a more extensive explanation of cjdns objectives
within [Project Goals][13] and [whitepaper][14] documents on Github.

A few local cjdns communities, called [mesh locals][08] have been established in
[Seattle][05], [NYC][06] and [Maryland][07].
A 'Mesh Local' is a mesh network situated in a particular geography,
focused on providing a community-centric alternative (or complement) to the internet.
The cjdns protocol was designed to be agnostic of the medium over which it communicates.
That means that even if the closest node is beyond the functional range
of that nodes wireless radio, you can still peer with it over the internet.
As a result, you local network can peer with distant cjdns network nodes.

For a more complete introduction of CJDNS and Mesh Networking,
check out my posts xxx and xxx.

###############################

Hyperboria Documentation - https://docs.meshwith.me/

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
walk you through installation
(i.e. README.md file), https://github.com/cjdelisle/cjdns/blob/master/README.md
setup of cjdns,
and connecting to friends on the mesh.
What you see in this an following steps was derived, in large part,
from the cjdns GitHub site.

The Bash script `do` does the bulk of the work of getting cjdns built.
You'll find some documentation on the `do` script [here][15].
Below is how you should install the cjdns source and execute this script.

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

>**NOTE:** When building cjdns, I received the message "Failed to build cjdns.".
I did a [search for a solution][23] and I was advised to use the following as a temporary work around:
`sudo NO_TEST=1 Seccomp_NO=1 ./do`.
This gave me the desired message "Build completed successfully, type ./cjdroute to begin setup.".

In the future, if compilation errors occur in build,
you should back up `cjdroute.conf` to somewhere outside your source tree
and run `sudo ./clean`.

# Step X: Generate cjdns Configuration File - DONE
The utility `cjdroute` is used to start up cjdns,
but it is also used to create a configuration file.
Using `sudo ./cjdroute --help` will give you some documentation
on the use of `cjdroute` is shown below:

```bash
# change directory to cjdns location
cd /opt/cjdns

# print help information for cjdroute
$ ./cjdroute --help
Cjdns armel linux
Usage:
    cjdroute --help                This information
    cjdroute --genconf [--no-eth]  Generate a configuration file, write it to stdout
                                   if --no-eth is specified then eth beaconing will
                                   be disabled.
    cjdroute --bench               Run some cryptography performance benchmarks.
    cjdroute --version             Print the protocol version which this node speaks.
    cjdroute --cleanconf < conf    Print a clean (valid json) version of the config.
    cjdroute --nobg                Never fork to the background no matter the config.

To get the router up and running.
Step 1:
  Generate a new configuration file.
    cjdroute --genconf > cjdroute.conf

Step 2:
  Find somebody to connect to.
  Check out the IRC channel or http://hyperboria.net/
  for information about how to meet new people and make connect to them.
  Read more here: https://github.com/cjdelisle/cjdns/#2-find-a-friend

Step 3:
  Add that somebody's node to your cjdroute.conf file.
  https://github.com/cjdelisle/cjdns/#3-connect-your-node-to-your-friends-node

Step 4:
  Fire it up!
    sudo cjdroute < cjdroute.conf

For more information about other functions and non-standard setups, see README.md
```

To generate a cjdns configuration file, do the following:

```bash
sudo touch cjdroute.conf
sudo chmod a+w jcdroute.conf

# generate a cjdns configuration file
sudo ./cjdroute --genconf > cjdroute.conf

#  permissions set so only you can read & write to it
sudo chmod go-rwx cjdroute.conf
```

> **NOTE:** A lost cjdroute.conf file means you lost your password and connections to peered nodes.
Anyone who connected to you will no longer be able to connect.
A compromised cjdroute.conf file means that other people can impersonate you on the network.

Beyond creating a configuration file,
`cjdroute --genconf` generates a password (which you keep secret) and public key
that you can share with nodes you wish to peer and authorize them to connect to you,
and a IPv6 address that uniquly identifies your node.
(You'll find this at the top of the `cjdroute.conf` file.)
Whenever a message tries to be routed to your instance of cjdns,
these these trusted nodes will encrypt that password with that public key.
So your instance of cjdns can verify that someone else has the correct password,
and that the password was meant only for you, and only you can decrypt that password.

# Step X: Find a Peering Node - DONE
cjdns's network operates on a friend-of-a-friend model.
This means, that to connect to the network you need to find nodes, called peers,
which allow you to connect to the network.
To get into an existing network (e.g. Hyperboria),
you need to connect to someone who is already in the network.
To find a peering node, you could join [Hyperboria community][16],
or you can peer with public peers to get into the network right away.

[To do the public peering][17],
first get on the [#cjdns channel on the Efnet IRC Network][18][^B].
Once in the channel, type ? public and you'll get links to public peers.
I found this URL http://cjdns.ca/ provided a link to [public peers][20],
or this [list of public peers][26] in Hyperboria's GitHub,
or this [widely known public node][25].
Follow any link and get to the peer info or "creds",
which look something like this:

[^B]:
    [EFnet or Eris-Free][19] network is a major Internet Relay Chat (IRC) network,
    with more than 35,000 users.
    It is the modern-day descendant of the original IRC network.

From **[https://pad.meshwith.me/p/public](https://pad.meshwith.me/p/public)**

```json
// coyo
"45.33.82.56:50492": {
    "password": "dustgard+d6f06c921bc26e8ede35fb5a8d97692f58b6d241",
    "publicKey": "h8dzr60ylqk7dx47mlfk6tdu0gyuk0vtpckbn1lvp2hl6c764bj0.k",
    "ipv6": "fcf1:4069:e3c4:6e66:9460:b92b:b156:cb9f",
    "hostname": "li1045-56.members.linode.com",
    "location": "Dallas, TX, USA",
    "contact": "coyo@darkdna.net"
}
```

```json
// Derp's Public Peer, password guaranteed until October 03, 2016
"142.4.212.42:1441": {
    "contact": "derp@HypeIRC,EFnet",
    "location": "Beauharnois, Quebec, Canada",
    "hostname": "fusion.hyperboria.ca",
    "password":"201510034nnmj97n54nby3797xt227lr0538ty4",
    "publicKey":"9uf222z95bxd7sgvncdtzr2skgjp7vdr472f7u74pc0zxu0pjxl0.k"
}
```

```json
"176.31.171.15:8988": {
    "website": "http://meshnet.pl/node/alien",
    "phone": "+48 537-833-468",
    "jabber_xmpp": "thenaturator@dukgo.com, nullpointer@dukgo.com",
    "password": "meshnetpl2public000xyz",
    "publicKey": "3p1pj08w7tqnfd9p5gwrwpd8kpjbu5nmw2twkwbfullzlwt8jkg0.k"
}
```

```json
"176.9.105.201:4464": {
    "login":"public",
    "password":"ir88xwtel72fen3ch7aug603s26nu3a",
    "publicKey":"yrgb0xwfr9pz8swvnv6m9by8zw7v7uxxhl07qz318cjuvfgs1fc0.k",
    "contact":"webmaster@jazzanet.com"
    "location": "Germany"
}
```

From **[https://jointhe.hyperboria.network/](https://jointhe.hyperboria.network/)**

```json
"74.221.208.153:25521": {
  "password": "jljwnfutfpt1nz3yjsj0dscpf7",
  "publicKey": "8hgr62ylugxjyyhxkz254qtz60p781kbswmhhywtbb5rpzc5lxj0.k",
  "hostname": "seanode.meshwith.me",
  "contact": "peering@meshwith.me"
}
```

# Step X: Peering with Public Node - DONE
Now copy this information above concerning the public node
and paste it into the `cjdroute.conf` file generated earlier.
The peer information goes into the "connectTo" section under the "UDPInterface" section.
Note that under UDPInterface there are separate sections for IPv4 and IPv6 based peers.
This is a IPv6 peer.
Make sure you don't mix them up.

To initiate the connection **OUTbound**
you make updates to the `/opt/cjdns/cjdroute.conf` file.
Within `cjdroute.conf`, search for "UDPInterface" and you will see:

```json
    // Interfaces to connect to the switch core.
    "interfaces":
    {
        // The interface which connects over UDP/IP based VPN tunnel.
        "UDPInterface":
        [
            {
                // Bind to this port.
                "bind": "0.0.0.0:57291",

                // Nodes to connect to (IPv4 only).
                "connectTo":
                {
                    // Add connection credentials here to join the network
                    // If you have several, don't forget the separating commas
                    // They should look like:
                    // "ipv4 address:port": {
                    //     "login": "(optional) name your peer has for you"
                    //     "password": "password to connect with",
                    //     "publicKey": "remote node key.k",
                    //     "peerName": "(optional) human-readable name for peer"
                    // },
                    // Ask somebody who is already connected.
                }
            },
            {
                // Bind to this port.
                "bind": "[::]:57291",

                // Nodes to connect to (IPv6 only).
                "connectTo":
                {
                    // Add connection credentials here to join the network
                    // Ask somebody who is already connected.
                }
            }
        ]
```

In the "Nodes to connect to (IPv4 only)" section,
place your peering friends, in this case they are public nodes.
Using the  public node examples above, you get:

```json
// Interfaces to connect to the switch core.
    "interfaces":
    {
        // The interface which connects over UDP/IP based VPN tunnel.
        "UDPInterface":
        [
            {
                // Bind to this port.
                "bind": "0.0.0.0:57291",

                // Nodes to connect to (IPv4 only).
                "connectTo":
                {
                    // Add connection credentials here to join the network
                    // If you have several, don't forget the separating commas
                    // They should look like:
                    // "ipv4 address:port": {
                    //     "login": "(optional) name your peer has for you"
                    //     "password": "password to connect with",
                    //     "publicKey": "remote node key.k",
                    //     "peerName": "(optional) human-readable name for peer"
                    // },
                    // Ask somebody who is already connected.

                    // From https://pad.meshwith.me/p/public
                    // hostname: li1045-56.members.linode.com
                    // IPv4: 45.33.82.56:50492
                    // IPv6: fcf1:4069:e3c4:6e66:9460:b92b:b156:cb9f
                    "45.33.82.56:50492": {
                        "password": "dustgard+d6f06c921bc26e8ede35fb5a8d97692f58b6d241",
                        "publicKey": "h8dzr60ylqk7dx47mlfk6tdu0gyuk0vtpckbn1lvp2hl6c764bj0.k"
                    },

                    // From https://jointhe.hyperboria.network/
                    // hostname: seanode.meshwith.me
                    // IPv4: 74.221.208.153:25521
                    // IPv6: ???
                    "74.221.208.153:25521": {
                        "password": "jljwnfutfpt1nz3yjsj0dscpf7",
                        "publicKey": "8hgr62ylugxjyyhxkz254qtz60p781kbswmhhywtbb5rpzc5lxj0.k"
                    }
            },
            {
                // Bind to this port.
                "bind": "[::]:57291",

                // Nodes to connect to (IPv6 only).
                "connectTo":
                {
                    // Add connection credentials here to join the network
                    // Ask somebody who is already connected.
                }
            }
```

You can add as many connections as you want to the `connectTo` attribute,
just follow the JSON syntax.

With this, cjdns allows you to initiate a connection
outbound (from YOU --> FRIEND) but **not inbound (from FRIEND --> YOU)**
but traffic flows both ways once the connection is established.

To allow you friends to initiate connections **INbound**,
you will need to search for "authorizedPasswords"
and provide information to your friend from the following code block:

```json
"authorizedPasswords":
    [
        // A unique string which is known to the client and server.
        // Specify an optional user to identify the peer locally.
        // It is not used for authentication.
        {"password": "l5gfl2cpw3la9w2btyxtxrj6j3m4g29", "user": "default-login"}

        // More passwords should look like this.
        // {"password": "x4nk5bx053h7knp8hd7q9mxzc6ql4sg", "user": "my-second-peer"},
        // {"password": "09xj971qnbku49lcrrnh2ng6s2yq28p", "user": "my-third-peer"},
        // {"password": "d724vkeh28p4sbyrqq1gk72nfpjspq7", "user": "my-fourth-peer"},

        // Below is an example of your connection credentials
        // that you can give to other people so they can connect
        // to you using your default password (from above).
        // The login field here yourself to your peer and the peerName field
        // is the name the peer which will be displayed in peerStats
        // Adding a unique password for each peer is advisable
        // so that leaks can be isolated.
        /*
        "your.external.ip.goes.here:57291": {
            "login": "default-login",
            "password":"lvgfl5cpw3lkkw2bty2tlrj6j3m7g29",
            "publicKey":"tnr03bu2ms6i5dn3mhsx31kbs7gxlokrpk8gsgcdlcbksrzd2bq0.k",
            "peerName":"your-name-goes-here"
        },
        */
    ],
```

I'm not going to provide these public peers access to my machine.
I will show how to establish INbound peering in another section
when I peer with my own systems.

########################################
I'm not going to provide the public peers access to my machine,
but it I did,
give William Jevons (who is making the INbound connection) the following 4 items:

1. My external IPv4
1. The port found in my conf file here: // Bind to this port. "bind": "0.0.0.0:yourportnumberishere",
1. The unique password that you uncommented or created: "password": "thisisauniquestring_002"
1. My public key: "publicKey": "thisisauniqueKEY_001.k"
1. His username: "William Jevons"

My firends login credentials will look something like this (with your IPv4 and port):

```json
"1.2.3.4:56789": {
    "login": "William Jevons",
    "password": "thisisauniquestring_002",
    "publicKey": "thisIsJustForAnExampleDoNotUseThisInYourConfFile_1.k"
}
```
########################################

To find out more about peering, check out these sources:

* [What is Hyperboria?](https://github.com/hyperboria/docs/blob/master/faq/peering.md#why-should-i-prefer-the-friend-of-a-friend-model)
* [How to install cjdns](https://github.com/hyperboria/cjdns#how-to-install-cjdns)
* [Configuring cjdns](https://github.com/cjdelisle/cjdns/blob/master/doc/configure.md)
* [Connect your node to your friend's node](https://github.com/cjdelisle/cjdns#3-connect-your-node-to-your-friends-node)
* [Peers](https://github.com/hyperboria/peers)

# Step X: Starting Up cjdns - DONE
With this update to `/opt/cjdns/cjdroute.conf`,
your ready to start-up cjdns with the command[^C]:

[^C]:
    The command `sudo ./cjdroute < cjdroute.conf` [may not work because][30]
    the "`<`" redirection is performed by your shell,
    which does not have the permission of root.
    The redirection of the stdin, stdout, stderr is not performed by sudo.

```bash
cd /opt/cjdns

# get WARNING message with this and doesnt' see to  work
# or you could do the following (pi owns the process)
sudo cat cjdroute.conf | ./cjdroute

# or you could do the following (nobody owns the process)
sudo sh -c './cjdroute < cjdroute.conf'

# or another method (nobody owns the process)
sudo -s
./cjdroute < cjdroute.conf
```

If all goes well, `cjdroute` starts up a daemon in the background,
and lets you know.
You should see no ERROR or WARNING messages, but just DEBUG, INFO are acceptable.
When completed, you should see something like this at the end:

```
1443702359 DEBUG Configurator.c:635 Cjdns started in the background
```

If not, you probably have something wrong with the configuration file.
The above starts cjdns as the root user so it can configure your
system without concern for permissions.
To start cjdns as a non-root user, see the document "[Run cjdns as a non-root user][29]".

To stop cjdns, just do the following:

```bash
# stop cjdns
sudo killall cjdroute
```

# Step X: Check for Listening Services - DONE
Once you start running cjdns, you become a IPv6 host.
Linux may automatically reconfigure network services to use this new address.
Unless you specifically desire this, you'll need to suppress Linux from making these network changes.

```bash
# do a TCP connect scan on all ports
nmap -6 -n -r -v -p1-65535 -sT fe80::76da:38ff:fe56:3cd
Starting Nmap 6.47 ( http://nmap.org ) at 2016-03-13 15:34 UTC
Initiating Ping Scan at 15:34
Scanning fe80::76da:38ff:fe56:3cd [2 ports]
Strange error from connect (22):Invalid argument
Completed Ping Scan at 15:34, 0.01s elapsed (1 total hosts)
Nmap scan report for fe80::76da:38ff:fe56:3cd [host down]
Read data files from: /usr/bin/../share/nmap
Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn
Nmap done: 1 IP address (0 hosts up) scanned in 1.20 seconds

# do a TCP connect scan on all ports, don't perform host discovery (-Pn)
# and specify the network interface (%wlan0)
$ nmap -6 -n -r -v -p1-65535 -sT fe80::76da:38ff:fe56:3cd%wlan0
Starting Nmap 6.47 ( http://nmap.org ) at 2016-03-13 15:43 UTC
Initiating Ping Scan at 15:43
Scanning fe80::76da:38ff:fe56:3cd [2 ports]
Completed Ping Scan at 15:43, 0.00s elapsed (1 total hosts)
Initiating Connect Scan at 15:43
Scanning fe80::76da:38ff:fe56:3cd [65535 ports]
Discovered open port 22/tcp on fe80::76da:38ff:fe56:3cd
Completed Connect Scan at 15:43, 27.89s elapsed (65535 total ports)
Nmap scan report for fe80::76da:38ff:fe56:3cd
Host is up (0.0060s latency).
Not shown: 65534 closed ports
PORT   STATE SERVICE
22/tcp open  ssh

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 29.39 seconds
```

The first nmap scan didn't fully work and you get the message
"Strange error from connect (22):Invalid argument".
The second scan worked.
It shows this host is up,
has no services running on ports 1-65535, and has a firewall.
Note that there is one port open, port 22 for SSH.

#################
If you see anything open, fix it.
Edit `/etc/ssh/sshd_config` to read:

```bash
ListenAddress 192.168.1.1
```

[See instructions](https://github.com/hyperboria/cjdns#4-secure-your-system---check-for-listening-services)
#################

# Step X: Check Your Connectivity to Hyperboria
Given your running cjdns and peered with a public Hyperboria node,
let’s check if you have access to any of the websites ONLY available Hyperboria.
The websites `socialno.de`, `irc.cjdna.ca`, `forum.meshbits.io`, `hyperboria.name`, `rows.io`
are only reachable via Hyperboria.
Just ping to any of these websites, and see if you are getting a response.

ping6 socialno.de
or
ping6 irc.cjdns.ca
or
ping6 forum.meshbits.io

what about /opt/cjdns/tools/ping and pingAll

Ping is not the best tool to be used to test the availability of a remote network. Although ping can tell you that a network is reachable and send you response times, the lack of that information does not imply that the network is down.
The lack of a ping return is most likely (1) ping is disabled on router or (more likely) end point or (2) Network is congested or misconfigured.

Another check is to validate you have established connections to any peer nodes
in your cjdns configuration file `/opt/cjdns/cjdroute.conf`.

/opt/cjdns/tools/peerStat

http://meshbits.io/getting-started-with-meshnet-on-linux/

# Step X: Peering with You Own Nodes
Now you could also create your own network by creating one or more nodes,
just like the one your creating now on a Raspberry Pi, and peer with them.

# Admin Interface
[Admin Interface](https://github.com/hyperboria/cjdns#admin-interface)

# Step X: Administrative Stuff
* [Admin interface](https://github.com/cjdelisle/cjdns#admin-interface)
* https://www.npmjs.com/package/cjdns-admin
* [cjdns-admin (0.1.1)](https://docs.omniref.com/js/npm/cjdns-admin/0.1.1)

# Step X: Get in IRC
[Get in IRC](https://github.com/hyperboria/cjdns#6-get-in-irc)

# Step X: Secure Your System
* [Self-check your network services](https://github.com/cjdelisle/cjdns/blob/master/doc/network-services.md)

# Step X: Start Your cjdns Services
* [Start it up!](https://github.com/cjdelisle/cjdns#5-start-it-up)
* [Anatomy of a running cjdns](https://docs.meshwith.me/cjdns/anatomy.html)
* [More Hyerboria Docs](https://docs.meshwith.me/)

# Step X: Testing
* [Testing the network](https://github.com/hyperboria/docs/blob/master/quickstart.md#step-4-testing-the-network)

Most of you might have come across a service called Reddit and some of you might even be very active there. The source code for reddit is available for public. Similarly there is an service called UPPIT in Hyperboria which is a clone of Reddit that will be accessible only on Hyperboria network but not through the regular Internet.

If you try connecting to http://uppit.us through regular internet,
you cannot access the service, but once you started using cjdns & connected to Hyperboaria,
only then you can get access to uppit.us service.

# 3rd Party Tools for managing/working with cjdns
* [cjdns Tools](https://github.com/hyperboria/docs/blob/master/ctrls.md)

# Step X: Troubleshooting
* [Troubleshooting](https://github.com/hyperboria/docs/blob/master/quickstart.md#troubleshooting)

# Step X: Keep Peering Credentials Safe
* https://docs.meshwith.me/cjdns/operator-guidelines.html

# Step X: enable the service and start it up
The article
[Running cjdns on Raspbian Jessie](http://mesh.philly2600.net/?p=54)
show you how to use `systemctl` to run cjdns at start-up.

# Step X: Configure cjdns as a NAT Gateway
* [CJDNS NAT Gateway](https://github.com/cjdelisle/cjdns/blob/master/doc/nat-gateway.md)

# Step X: Hyperboria Map
* http://www.fc00.org/

# Step X: Discoverability
* [nodeinfo.json](https://github.com/hyperboria/docs/blob/master/cjdns/nodeinfo-json.md)
* [Adding your public node's credentials](https://github.com/hyperboria/peers)

# Step X: Clone the SD Card
* [Backup, Restore, Customize and Clone your Raspberry Pi SD Cards (tutorial)](http://sysmatt.blogspot.com/2014/08/backup-restore-customize-and-clone-your.html)
* [Duplicating Your Raspberry Pi’s SDHC Card](https://programmaticponderings.wordpress.com/2013/02/12/duplicating-your-raspberry-pis-sdhc-card/)
* [CLONE AN SD CARD ON LINUX, UBUNTU 12.04](http://rricketts.com/clone-an-sd-card-on-linux-ubuntu-12-04/)
* [Back-up a Raspberry Pi SD card using a Mac](https://smittytone.wordpress.com/2013/09/06/back-up-a-raspberry-pi-sd-card-using-a-mac/)
* [How to Clone Raspberry Pi SD Cards Using the Command Line in OS X](http://computers.tutsplus.com/articles/how-to-clone-raspberry-pi-sd-cards-using-the-command-line-in-os-x--mac-59911)

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
[15]:https://docs.meshwith.me/notes/do.html
[16]:https://github.com/cjdelisle/cjdns/blob/master/README.md#community
[17]:https://github.com/hyperboria/docs/blob/master/quickstart.md#step-3-find-a-public-peer
[18]:http://chat.efnet.org/irc.cgi?chan=%23cjdns
[19]:https://en.wikipedia.org/wiki/EFnet
[20]:https://pad.meshwith.me/p/public
[21]:https://en.wikipedia.org/wiki/End-to-end_encryption
[22]:https://en.wikipedia.org/wiki/Network_layer
[23]:https://github.com/hyperboria/cjdns/issues/6#issuecomment-162244016
[24]:https://en.wikipedia.org/wiki/Hyperborea
[25]:https://jointhe.hyperboria.network/
[26]:https://github.com/hyperboria/peers
[27]:https://en.wikipedia.org/wiki/Pseudonymity
[28]:https://github.com/hyperboria/docs/blob/master/faq/peering.md#why-should-i-prefer-the-friend-of-a-friend-model
[29]:https://github.com/hyperboria/cjdns/blob/master/doc/non-root-user.md
[30]:http://stackoverflow.com/questions/82256/how-do-i-use-sudo-to-redirect-output-to-a-location-i-dont-have-permission-to-wr
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
