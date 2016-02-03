* [Node Knockout 2013: Supercharge Your Node.js App With PubNub](https://www.pubnub.com/blog/2013-10-11-node-knockout-2013-supercharge-your-app-with-pubnub/)
* [Connecting it All Together – PubNub and Node-RED](http://www.internetoflego.com/connecting-it-all-together-pubnub-and-node-red/)
* [Setting up an IoT framework/dashboard with NodeRed, Mosca/Mosquitto and Freeboard.io dashboard](https://primalcortex.wordpress.com/2015/02/25/setting-up-an-iot-frameworkdashboard-with-nodered-moscamosquitto-and-freeboard-io-dashboard/)

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

With Node-RED, the processing of messages is visualised
as a graphical flow between “nodes” representing input,
output or processing by Node-RED.
A message is generated at an input node and is passed to any node that node’s out is connected to.
Built on top of the Node.js platform,
it is able to also handle connections to databases such as MongoDB,
protocols such as TCP, UDP, HTTP and WebSockets
and services like IRC or Twitter and has nodes that represent input or output to all of them.
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

# Node.js
[Why The Hell Would I Use Node.js? A Case-by-Case Tutorial](http://www.toptal.com/nodejs/why-the-hell-would-i-use-node-js)

# Getting Started
The content here is lift for these sources:

* [The Node-RED Getting Started page](http://nodered.org/docs/getting-started/)
* [Raspberry Pi Hosting Node-Red](https://learn.adafruit.com/raspberry-pi-hosting-node-red/what-is-node-red)
* [Node-RED Wiki](https://github.com/node-red/node-red/wiki)
* [Raspberry Pi 2 Node-Red setup](https://swabbster.wordpress.com/2015/04/16/raspberry-pi2-node-red-setup/)

## Installing Node-RED
The easiest way to install Node-RED is to use node’s package manager, npm.
Installing it as a global module adds the command node-red to your system path:

```bash
sudo apt-get update
sudo apt-get install nodejs npm
sudo npm install -g --unsafe-perm node-red
```

See [Node-RED Upgrade Documentation][04] for the purpose of the `--unsafe-perm` parameter.

You'll also need to manually create a symlink `/usr/bin/node`.

```bash
sudo ln -s /usr/bin/nodejs /usr/bin/node
```

>>WHY THE SYMLINK: There is a naming conflict with the node package (Amateur Packet Radio Node Program),
and the nodejs binary has been renamed from node to nodejs.
You'll need to symlink /usr/bin/node to /usr/bin/nodejs or you could uninstall
the Amateur Packet Radio Node Program to avoid that conflict.

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

# Dashboards
Node-RED lacks a control and display panel from where can drive your application
or see it status.
The are many dashboad tools available to fill this void,
but two will get special mention here

## Freeboard
[Freeboard][27], from [Bug Labs][28], advertises itself as a turn-key HTML-based "engine" for dashboards,
and a open source real-time dashboard builder for IOT and other web mashups.
Freeboard can runs entirely in the browser as a single-page static web app without the need for a server.
The code on the [Freeboard Github][29] is the client-side version of what you see
when you use the Freeboard hosted service at http://freeboard.io.

Freeboard can be run entirely from a local hard drive.
You download/clone the repository and open `index.html`.
While freeboard runs as a stand-alone app out of the box,
you can augment and control it from javascript with a simple API.
All API calls are made on the freeboard singleton object.
To get Freeboard to run locally, do the following:

```bash
# clone the Freeboard repository
cd ~/src
git clone https://github.com/Freeboard/freeboard.git

# now point your browser to Freeboard's index file
google-chrome file:///home/jeff/src/freeboard/index.html
```

For Node-RED integration, you don't need the above
(Freeboard is bundled within the package).
Just install the `node-red-contrib-freeboard` plugin

```bash
sudo npm install -g node-red-contrib-freeboard
```

The Freeboard will be posted at `http://localhost:1880/freeboard/`.

## Dashing
Another dashboard is the Ruby on Rails-based tool [Dashing][30].
Dashing provides everything you need to create dynamic dashboard interfaces,
including a large set of pre-made widgets
(installed when you create a project
and [user submitted Dashing widgets][31] you can install manually)
to easily present data in a graphical format.
You can customize these widgets via web standards (HTML, SCSS, and CoffeeScript)
and develop your own if there is nothing that meets your needs.
To use Dashing, you don't need to know Ruby or Rails.

A widget is defined using three files:
a small amount of html specifying data bindings for the delivered data,
style information in a SASS scss file,
and event handling code in coffeescript.
Once a widget is defined, instances can be created by editing the dashboard's ERB file.
You just create a HTML `div` with a data-view attribute matching a widget's class name
and a data-id that is used to route data to the widget.
Data can be pushed to the widgets by submitting an HTTP POST to /widgets/<data-id>
from an external job or application, or can be pulled using Dashing's job support.
[The web site][30] describes how to get data into your widgets in more detail.

Install dashing using gem from the command line.
But before you can do this, you must sure you have Ruby 1.9+ installed:

```bash
gem install dashing
```

Generate a new dashboard project with dashing

```bash
dashing new sweet_dashboard_project
```

Change your directory to `sweet_dashboard_project` and bundle gems

```bash
cd sweet_dashboard_project
bundle
```

Start the dashing server and point your browser at `localhost:3030`:

```bash
dashing start
google-chrome http://localhost:3030
```

Every new Dashing project comes with sample widgets &
sample dashboards for you to explore.
The directory is setup as follows:

* Assets — All your images, fonts, and js/coffeescript libraries. Uses Sprockets
* Dashboards — One `.erb` file for each dashboard that contains the layout for the widgets.
* Jobs — Your ruby jobs for fetching data (e.g for calling third party APIs like twitter).
* Lib — Optional ruby files to help out your jobs.
* Public — Static files that you want to serve. A good place for a favicon or a custom 404 page.
* Widgets — All the html/css/coffee for individual widgets.

Run dashing from command line to find out what command line tools are available to you.

To install [additional widgets from 3^^rd^^ parties][31],
you the `dash install` command followed by the gist id of the widget.
For example, the asana tasks gist is https://gist.github.com/willjohnson/6334811 or gist 6334811.
To install the widget, we run:

See http://fmrldev.blogspot.com/2014/04/raspberry-pi-information-radiator_29.html

>NOTE: Dashing-js is a Node.js port of the Ruby version of Dashing,
and has a node already established within Node-RED.
The port is not as well documented as the Ruby version,
and frankly, doesn't appear to have much support behind it.

## Initial State
[Initial State - Stream data from your devices to beautiful visualizations in your web browser](https://www.initialstate.com/)

* Waylay - http://www.waylay.io/
* http://waylayio.github.io/integration/2015/10/24/webscripts.html
* [Getting Started With Adafruit IO](https://www.jeremymorgan.com/internet-of-things/how-to-adafruit-io/?utm_source=feedburner&utm_medium=email&utm_campaign=Feed%3A+JeremyMorganTutorials+%28Jeremy%27s+Tutorials%29)



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
[27]:http://freeboard.io/
[28]:http://buglabs.net/
[29]:https://github.com/Freeboard/freeboard
[30]:http://dashing.io/
[31]:https://github.com/Shopify/dashing/wiki/Additional-Widgets
[32]:
[33]:
[34]:
[35]:
[36]:
[37]:
[38]:
[39]:
[39]:
