In the city I live,
they offer

## Webhook
[!webhook_logo]:http://blog.formstack.com/wp-content/uploads/2010/08/webhooks_logo-150x150.png
A webhook is a method of augmenting or altering the behavior of a web page,
or web application, with custom [callbacks][01].
So a webhooks are "[user-defined HTTP callbacks][03]" or "[real-time service][02]".
They are usually triggered by some event, like a comment being posted to a blog.
When that event occurs, the source site makes an HTTP request to the URI configured for the webhook.
Users can configure them to cause events on one site to invoke behavior on another.

## Rest-API
[!rest_api_logo]:http://static1.squarespace.com/static/5269a9bce4b07233cf8781fe/544eb6abe4b053b088f7237a/55770f60e4b09224e9c7619a/1433866080885/rest-api.png
A common theme within IoT is the use of the TCP/IP and HTTP protocols using
APIs adopting the Roy Fielding's [REST architectural style][16] (so-called “RESTful” APIs).
Nonetheless, a key constraint that Fielding proposed is not always adopted.
This feature is known as [Hypermedia as the Engine of Application State (HATEOAS)][17]
or hypermedia APIs for short.

## IFTTT
[!ifttt_logo]:http://marketingland.com/wp-content/ml-loads/2012/09/ifttt-logo.jpg
IFTTT.com (short for “If This Then That”)
is a popular service which lets you trigger actions
based on certain events that occur around the Internet.
It creates a chain of simple conditional statements ("if", "then", "else",
([called "if recipes" and "do recipes" by IFTTT][10]),
which trigger other web services ([called "channels" by IFTTT][11])
such as Gmail, Facebook, Instagram, and Pinterest.
You can think of IFTTT as a way to [automate your online life][04].
IFTTT does its best to make  this easy to do, including a
"[dashboard][11]" where you can encode and control all your services.
For the web-programmers, you can think of IFTTT as a utility for non-programmers,
giving them simple to use APIs and Webhooks.
So th services offered by IFTTT, while useful,
are limited to predefined services for the non-programming community
who are attempting to automate their online / digital life.

An obvious thing for IFTTT to do would be to expand its focus
and support a more general approach.
There is now an official channel for IFTTT that supports webhooks,
called [Maker Channel][05].
(One of the [open source precursor][07] to this IFTTT channel is discussed in this [article][06]
and you'll find the code on [Github][08].)
The Maker Channel is in effect, IFTTT's answer to the DIY communitity for IoT,
as illustrated via its presenace on [hackster.io][09].
(IFTTT does have some more speciallized channels for IoT.
[See the channels for "Connected Home", "Connected Car", and "Fitness and Wearables"][13])

As neat is it is, in my view,
IFTTT has questionable privacy and security.
The bottom line is that nothing is free in this world.
If you want do this service base "this then that" one way or the other,
you are going to sacrifice your privacy.
It can observe you beyond limits.
You've given access to all your data including your up to
date location, your posts, your calender, your dropbox, your evernote, your mail ... and you name it.
IFTTT may say that it's not using any of your data,
but you can't be that sure about hackers.

## Pushover
An alternative to Pushover is [Instapush](https://instapush.im/).
<a href="https://pushover.net/">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="Pushover Logo" alt="Pushover Logo" src="/images/pushover-logo.png" width="75" height="75" />
</a>
[Pushover][22] is a service to receive instant [push notifications][36]
on your phone, web browser, or tablet from a variety of sources.
You purchase and install a client app on your iPhone, Android device, or Desktop.
On the server side, Pushover provide an HTTP API for queuing messages to deliver
to devices addressable by User or Group Keys.
On the device side, the clients receive those push notifications,
show them to the user, and store them for off-line viewing.
With some scripting, you can integrate Pushover notifications into your
application, website, server process, network monitor, or anything else.
Messages are currently limited to 512 characters,
including a title of up to 100 characters.

## Parsing eMail
IFTTT has many channels for handling email,
[most specifically for Gmail][12]
but there other [tools to help connect with any email service][14].
Never the less, none of these channels appear to parse the email message
and extract the specific information your looking to keep.
To do this, Python has some packages that could be used.
Specifically, the [`email`][15] and [`feedparser`][18] packages.
[This article][19] show how `feedparser` used,
a package intended for parsing syndicated feeds.
Instead, I choose to use the `email` Python package instead.

See /home/jeff/src/email_parser/extract_email.py

[Very simple Python script to dump all emails in an IMAP folder to files](https://gist.github.com/robulouski/7442321)

[Extract emails from Gmail with Python via IMAP](http://www.voidynullness.net/blog/2013/07/25/gmail-email-with-python-via-imap/)
[Video: Python Read Email](https://www.youtube.com/watch?v=FqHjP0377Ks)

```bash
sudo pip install email
```

# Gmail API
The [Gmail API][20] is a RESTful API that can be used to access Gmail mailboxes and send mail.
All you need to use the Gmail API is the [client library][21]
for your choice of language and an [app that can authenticate][23] as a Gmail user.

[01]:https://en.wikipedia.org/wiki/Callback_(computer_programming)
[02]:http://culttt.com/2014/01/22/webhooks/
[03]:http://timothyfitz.com/2009/02/09/what-webhooks-are-and-why-you-should-care/
[04]:http://www.pcworld.com/article/2044579/how-to-use-ifttt-to-automate-your-online-life.html
[05]:https://ifttt.com/maker
[06]:https://www.marcus-povey.co.uk/2012/11/07/using-webhooks-with-ifttt-com/
[07]:https://captnemo.in/ifttt-webhook/
[08]:https://github.com/mapkyca/ifttt-webhook
[09]:https://www.hackster.io/ifttt/projects
[10]:https://ifttt.com/wtf
[11]:http://www.pocket-lint.com/news/130082-ifttt-explained-how-does-it-work-and-what-are-the-new-do-apps
[12]:http://lifehacker.com/the-best-gmail-ifttt-recipes-576181920?disableinsets=on&utm_expid=66866090-49.VYy4WCNHSyuP6EmjnM93MQ.2
[13]:https://ifttt.com/channels
[14]:https://github.com/newslynx/ifttt
[15]:https://docs.python.org/2/library/email.html
[16]:http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm
[17]:http://restcookbook.com/Basics/hateoas/
[18]:http://pythonhosted.org/feedparser/introduction.html
[19]:http://mitchtech.net/connect-raspberry-pi-to-gmail-facebook-twitter-more/
[20]:https://developers.google.com/gmail/api/
[21]:https://developers.google.com/gmail/api/downloads
[22]:https://pushover.net/
[23]:https://developers.google.com/gmail/api/auth/about-auth
[36]:http://en.wikipedia.org/wiki/Push_technology
