
[Node-RED][03] is a new [industry created open-source tool][02],
created by the [IBM Emerging Technology team][01],
that lets you build applications by simply wiring pieces together.
These pieces can be hardware devices, web APIs, or online services.

Node-RED is about making sense out of the Internet of Things.
It’s about understanding how devices relate to each other and how they interact.
Node-RED is built on top of Node.js
and takes advantage of the huge node module ecosystem
to provide a tool that is capable of integrating many different systems.
Its lightweight nature makes it ideal to run at the edge of the network,
such as on the Raspberry Pi, and other hack-friendly platforms.

With Node-RED, the processing of messages is visualised as a graphical flow between “nodes” representing input,
output or processing by Node-RED.
A message is generated at an input node and is passed to any node that node’s out is connected to.
Built on top of the Node.js platform, it is able to also handle connections to databases such as MongoDB,
protocols such as TCP, UDP, HTTP and WebSockets and services like IRC or Twitter and has nodes that represent input or output to all of them.
It also has nodes which allow you to change values in a message,
process a messages with JavaScript, fill out a template, delay a message being passed on,
select a path for a message to take, map numeric ranges or even do sentiment analysis on text.
There’s also some handy file storage nodes and, to aid debugging,
a message injector node and a debug output node.

Node-RED frees up development time,
eliminating the need to do repetitive programming tasks
and instead enabling you to focus the high level problem.

There is also a hosted Node-RED called [FRED][18].
Doesn't appear to do anything other than remove the burden of manging you own
Node.js and Node-RED environment.
It does have a [Node-RED Programming Guide][17]
which appears to provide better introductory documentation.

# Getting Started
The content here is lift for these sources:

* [The Node-RED Getting Started page](http://nodered.org/docs/getting-started/)
* [Raspberry Pi Hosting Node-Red](https://learn.adafruit.com/raspberry-pi-hosting-node-red/what-is-node-red)
* [Node-RED Wiki](https://github.com/node-red/node-red/wiki)

## Installing Node-RED
The easiest way to install Node-RED is to use node’s package manager, npm.
Installing it as a global module adds the command node-red to your system path:

```bash
sudo npm install -g --unsafe-perm node-red
```

See [Node-RED Upgrade Documentation][04] for the purpose of the `--unsafe-perm` parameter.

To get the latest upgrade you can use
`sudo npm update -g --unsafe-perm node-red`,
but it is best to re-install Node-RED as follows:

```bash
sudo npm cache clean
sudo npm install -g --unsafe-perm node-red
```

To get the bleeding edge Node-RED code from GitHub,
Check out [Node-RED's Install documentation][06].

For installing on Raspberry Pi.
Check out [Node-RED's documentation][07] and [Adafruit's Tutorial][08].

# Running Node-RED
Check out [Node-RED Getting Started page][04] for full instructions on getting started.
Basic steps once its install is the following:

1. `node-red`
1. Open `http://localhost:1880` in a browser

Where Node-RED command line is:

```
Usage: node-red [-v] [-?] [--settings settings.js] [--userDir DIR] [flows.json]

Options:
  -s, --settings FILE  use specified settings file
  -u, --userDir  DIR   use specified user directory
  -v                   enable verbose output
  -?, --help           show usage
```

By default, Node-RED stores your data in the directory `$HOME/.node-red`.
To override what directory to use, the `--userDir` command-line option can be used.

If you find it necessary to pass arguments to the underlying node.js process,
see the [Node-RED Running documentation][09].

## Adding Nodes
Node-RED comes with a core set of useful nodes,
but there are a growing number of additional nodes available for installing.
You can search for available nodes in the [Node-RED library][10] or on the [npm repository][11].
Some of the nodes also have dependencies on external libraries
and without these being installed will not function correctly.

To install an npm-packaged node,
you can either install it locally within your user data directory
(by default, `$HOME/.node-red`):

```bash
cd $HOME/.node-red
npm install <npm-package-name>
```

or globally alongside Node-RED:

```bash
sudo npm install -g <npm-package-name>
```

It is also possible to install nodes by copying their `.js` and `.html` files
into a nodes directory within your user data directory.
If these nodes have any npm dependencies,
they must be also be installed within the user data directory.

In all cases, you will need to restart Node-RED for it to pick-up the new nodes.

Some good nodes to add are:

```bash
sudo npm install -g node-red-node-ping          # Pings a machine and returns the trip time in mS.  Returns boolean false if no response received within 5 seconds, or if the host is unresolveable.
sudo npm install -g node-red-node-mongodb
```

## Importing Flows
You can imported flows straight into the editor by pasting the JSON
representing the flow into the Import dialog
(`Ctrl-i` or via the dropdown menu within Node-RED).

## Exporting Flows
Use `Ctrl-a` to select all the flows on the tab and `Ctrl-e`  to popup the flow.
From there, you can do copy the flow to your clipboard.

# Example
[OwnTracks is a phone app][12] allows you to keep track of your own location via your cell phones GPS.
You can do such things as build your private location diary or share it with others.
[OwnTrack's documentation][13] says that its open-source and uses MQTT to publish its information.

To test things out, I first attempted tp use [hosted mode][15] and
signed up to [OwnTracks public MQTT Broker][14].
I couldn't get this configured and it showed no interest in the OwnTracks user community,
so I turned to [AWS's CloudMQTT][19] to establish a private MQTT broker.
From a security stand point, it couild be best to create
your own private MQTT broker and [OwnTracks shows you how][16].

There are several MQTT brokers available,
such as the popular [Mosquitto MQTT Broker][24]
(nice [Rasberry Pi implementation of Mosquitto][26] as a private broker),
but there is also the MQTT Broker [Mosca][21],
which runs on Node.js and so is platform agnostic.
[Mosquitto][25], [Mosca][23] and [CloudMQTT][22] all support MQTT over websockets,
which allows use of webclient dashboards in a straight forward way.
MQTT over websockets allowes every browser to be a MQTT client.
You can push messages to your browser when an event occurs or publish messages to your device.

So what is Freeboard.io? - http://freeboard.io/ What about Dashing? - http://dashing.io/

To get MQTTCloud working with OwnTracks, I found a [helpful OwnTracks Community artical][20].

The GPS capture device I selected is the iOS/Android app OwnTracks, an open-source "location diary" that continually publishes a message with location information at a periodic interval (for example, every 5 seconds or 10 meters moved). OwnTracks is perfect for this solution because of the simplicity and ease of configuration: just configure the publish topic, point to a messaging broker and your location information starts getting published. Here's an example:

Programming for Hosted - http://owntracks.org/booklet/tech/proghosted/
OwnTracks Community - https://community.owntracks.org/topic/23/node-red
Check out - http://flows.nodered.org/flow/1aab1d44e387da96b3fe



[01]:https://www-304.ibm.com/connections/blogs/et/entry/node-red?lang=en_us
[02]:https://developer.ibm.com/open/node-red/
[03]:http://nodered.org/
[04]:http://nodered.org/docs/getting-started/upgrading.html
[05]:http://nodered.org/docs/getting-started/
[06]:http://nodered.org/docs/getting-started/installation.html
[07]:http://nodered.org/docs/hardware/raspberrypi.html#starting-node-red
[08]:https://learn.adafruit.com/raspberry-pi-hosting-node-red?view=all#what-is-node-red
[09]:http://nodered.org/docs/getting-started/running.html
[10]:http://flows.nodered.org/
[11]:https://www.npmjs.com/browse/keyword/node-red
[12]:https://play.google.com/store/apps/details?id=org.owntracks.android
[13]:http://owntracks.org/booklet/
[14]:https://hosted.owntracks.org
[15]:http://owntracks.org/booklet/features/hosted/
[16]:http://owntracks.org/booklet/guide/broker/
[17]:http://noderedguide.com/
[18]:https://fred.sensetecnic.com/
[19]:https://www.cloudmqtt.com/
[20]:https://community.owntracks.org/topic/23/node-red
[21]:http://www.mosca.io/
[22]:https://www.cloudmqtt.com/docs-websocket.html
[23]:https://github.com/mcollina/mosca/wiki/MQTT-over-Websockets
[24]:http://mosquitto.org/
[25]:http://jpmens.net/2014/07/03/the-mosquitto-mqtt-broker-gets-websockets-support/
[26]:http://owntracks.org/booklet/guide/broker/
[27]:
[28]:
[29]:
[30]:
