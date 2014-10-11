I find myself with a multitude of ancillary information,
much of it related to this blog,
but no place to adequately organize and store it.
Creating a page or post on the blog will be over kill.
May of the topic are interrelated and should be searchable and cross-linked.

What I need is a [personal wiki][01].
There seems to be many of them but I have found [TiddlyWiki][02]
offering the most inviting solution.
I particularly like the fact that you can use it with just a browser
(must be at least somewhat [HTML5 complatable][03], like [Chrome][04]).
All you need is a browser and you maintain the wiki via a locally stored HTML file.
The file is loaded with [JavaScript][05] to support the editing of the wiki.

My initial thought was just to add the wiki's HTML file to my blog
as a page addressable from the header menu.
This approach would make the wiki editable by anyone, something I didn't want.
TiddlyWiki does support the rendering of a static HTML file, which is what I want,
but this solution make for a cold and lifeless wiki with no interactivity and searching capabilities.

TiddlyWiki does support an alternative where the pages
are delivered via a server using [Node.js][06][^A].
This provides the interactivity I want, but I can password protect its editing.
This [web post][] provides some good insights and motivation for the use of Node.js.
In addition, individual tiddlers are stored in separate files,
instead of a single HTML file, so you can organise them as you wish accross mutiple wiki.
Also, it gives me an excuse to learn more about Node.js!

[^A]:
    [Node.js is a platform][08] built on Chrome's JavaScript runtime for event-driven, non-blocking I/O model.
    Unlike JavaScript applications running in a web browser,
    Node.js runs JavaScript by leveraging [V8][07],
    Google’s fast JavaScript engine designed for Chrome.
    This allows Node.js to create a runtime environment that pushes JavaScript
    from the server to the client quickly.
    V8 translates JavaScript into native machine language,
    instead of working overtime to interpret it as bytecode, giving Node.js its speed. 
    This speed, combined with asynchronous programming,
    are the twin powerhouses that make Node.js so responsive.

## Installation
Install Node.js via `apt-get`.
Because of a conflict with another package (amateur radio node package,
the executable from the Ubuntu repositories is called `nodejs` instead of `node`. 
Node.js package manager and other programs will want to call it "node",
so you'll need to set up a symbolic link between `nodejs` and `node`.

```bash
# install the Node.js engine and its package manager
sudo apt-get install nodejs npm

# create symbolic link
sudo ln -s /usr/bin/nodejs /usr/bin/node
```

You can install TiddlyWiki via

```bash
# install TiddlyWiki, the '-g' option installs it globally
sudo npm install -g tiddlywiki

# check its version
tiddlywiki --version

```

When a new version of TiddlyWiki is released, you can upgrade it with this command:

```bash
# upgrade TiddlyWiki
sudo npm update -g tiddlywiki
```

## Creating a Wiki
At this point, you should be ready to create a test wiki.

* change directory to where you want the wiki to be stored
* `tiddlywiki mynewwiki --init server` will create a folder called `mynewwiki` for a new wiki that includes server-related components
* `tiddlywiki mynewwiki --server` to start TiddlyWiki server
* With your browser, visit `http://127.0.0.1:8080/`
* Try editing and creating tiddlers.  The Tiddles will be maintained in individual files in the `tiddlers` directory.

Check the [TiddlyWiki website documentation][02] to find out more about the capabilities of TiddlyWiki.

## Creation of Wiki for Blog
Create the wiki via

* cd into blogging and execute `tiddlywiki wiki --init server`.
* modify `pelicanconf.py` to include

```python
# A list of tuples (Title, URL) for additional menu items to appear
# at the beginning of the main menu.
MENUITEMS = (('About Me', '/pages/about-me.html'),
            ('Wiki', 'http://127.0.0.1:8080/'),
            ('Open Notebook', '/pages/open-notebook.html'),)
```

* `tiddlywiki wiki --server` to start TiddlyWiki server

## Hosting TiddlyWiki
TiddlyWiki recommends some methods for
[hosting your TiddlyWiki on the web](http://tiddlywiki.com/#TiddlyWiki%20in%20the%20Sky%20for%20TiddlyWeb).

Github pages host only static html pages.
No server side technology is supported.
So node.js applications won't run on github pages.

* [Hosting compatible with Node](https://github.com/joyent/node/wiki/Node-Hosting)
* [Setup a personal TiddlyWiki on OpenShift](http://ericmiao.github.io/blog/2014/04/05/setup-personal-tiddlywiki-on-openshift/)
* [Heroku + Node.js + MongoLab](http://embeddedfun.blogspot.com/2011/11/heroku-nodejs-mongolab.html)
* [Getting Started on Heroku](https://devcenter.heroku.com/start)
* [Introduction to Heroku - YouTube](https://www.youtube.com/watch?v=VuydqVmRvrs)
* [What is Heroku? Explained through Analogy - YouTube](https://www.youtube.com/watch?v=J9dWpxLdeko)

## Quickly Building a Prototype
This show you a simple way to get your project setup so that you can talk to it and control it via the interwebs. 
* [Anatomy of a web application using node.js, ExpressJS, MongoDB & Backbone.js](http://www.amazon.com/gp/product/B00HRME7NA/ref=kinw_myk_ro_title)
* [µCast #16: Pi + Express + Bootstrap + Angular FTW!](http://blog.microcasts.tv/2014/04/14/pi_express_bootstrap_angular/)
* [µCast #17: Control Hardware Remotely With Socket.IO](http://blog.microcasts.tv/2014/06/21/using-socket-io-to-control-the-raspberry-pi-remotely/)
* []()



[01]:http://en.wikipedia.org/wiki/Personal_wiki
[02]:http://tiddlywiki.com/
[03]:http://html5test.com/
[04]:https://www.google.com/intl/en/chrome/browser/#brand=CHMB&utm_campaign=en&utm_source=en-ha-na-us-sk&utm_medium=ha
[05]:http://www.w3schools.com/js/
[06]:http://nodejs.org/
[07]:http://en.wikipedia.org/wiki/V8_(JavaScript_engine)
[08]:http://readwrite.com/2013/11/07/what-you-need-to-know-about-nodejs#feed=%2Fhack&awesm=~oD2cgDlOnKEfSp
[09]:http://www.appdynamics.com/blog/nodejs/what-is-node-js-and-why-should-i-care-an-operations-guy-searches-for-answers/
[10]:
[11]:
[12]:
[13]:
[14]:
[15]:
[16]:
[17]:
[18]:
[19]:
[20]:
