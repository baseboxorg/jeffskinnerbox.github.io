* [3 Possible Ways for Real-Time Video Streaming Between Camera and Android Device](https://www.intorobotics.com/3-possible-ways-real-time-video-streaming-camera-android-device/)
* [Video Streaming Like Your Raspberry Pi Depended On It](https://hackaday.com/2017/09/12/video-streaming-like-your-raspberry-pi-depended-on-it/)
* [Python Live Video Streaming Example](http://www.chioka.in/python-live-video-streaming-example/)

* [TTL Serial Camera](https://learn.adafruit.com/ttl-serial-camera)
* [Accessing Camera using OpenCV](http://opencvlover.blogspot.com/2011/07/accesing-camera-using-opencv.html)




# Adding a Camera to the Raspberry Pi
[camera!](http://raspi.tv/wp-content/uploads/2016/05/PiZero1.3_700.jpg)
[camera!](http://cdn.slashgear.com/wp-content/uploads/2016/05/2016-05-15-16.32.19-800x420.jpg)
[Raspberry Pi Zero version 1.3][06] has a camera connector,
and I'll be installing the version 2.1 camera
(previous version was v1.3 5MP and 1080p).
This [camera is 8 Megapixel, 1080p, and Better in Low Light][45]
and in general a [better camera][57].
The Zero’s camera cable connector is a little smaller than the ones used on the other Raspberry Pi.
This [Second Generation Raspberry Pi Camera Module][46] has the following specs:

* Fixed Focus Lens
* Sony [Exmor][49] [IMX219][48] Sensor Capable of [4K30][47], [1080P60][50], [720P180][51], 8MP Still
* 3280 (H) x 2464 (V) Active Pixel Count
* Maximum of 1080P30 and 8MP Stills in Raspberry Pi Board
* 2A Power Supply Highly Recommended

To activate the camera features on the RPi Zero,
access the configuration settings for the RPi by running the command:

```bash
# configure the raspberry pi camera
sudo raspi-config
```

Then navigate to “camera” and select “enable”.
Select “Finish” and reboot.

The installation of the camera cable must be done carefully and
its proper installation is illustrated in this picture:

[camera-cable](http://raspi.tv/wp-content/uploads/2016/05/PiZero1.3_700.jpg)

You can find [detail documentation on camera usage online][52].
A summary for [taking still pictures][54] and [taking videos][53] is given below.

To take a picture with the camera, do the following:

```bash
# take picture and store in image.jpg
raspistill -o ~/tmp/image.jpg --width 1024 --height 768

# display picture for viewing
display ~/tmp/image.jpg
```

You can also capture video with the camera.
To capture a 5 seconds of video in [H.264/MPEG-4 Advanced Video Coding (AVC)][108] format:

```bash
# capture video in file video.h264
raspivid -o ~/tmp/video.h264 --timeout 5000 --width 1024 --height 768 --codec H264

# record a 10 second VGA clip at 90fps
raspivid -w 640 -h 480 -fps 90 -t 10000 -o ~/tmp/test90fps.h264

# play the videos
mplayer ~/tmp/video.h264
mplayer ~/tmp/test90fps.h264
```
Other possibilities for your camera are things like [time lapse photography][65] or
[`picamera`][55] which is a Python interface to the Raspberry Pi camera module
(source code [here][56]).
Or can do something more sophisticated like stream video to a web browser
via the Python package [`pistreaming`][58]
or with [`OpenCV`][59], or via [`motion`][60].

# ???
In the subsequent sections, I plan to show several methods for streaming video.
They will differ in there easy of use, in what tools re need to create them,
and how & where you access the resulting video stream.

## What is Video Streaming?
And there is a differences between streamed and static video media.
The key consideration when streaming media to a browser
is the fact that rather than playing a finite file,
we are relaying a file that is being created on the fly,
and has no pre-determined start or end.
This finite file sits on a server and can be delivered,
like most other files, to the browser
(ths is known as a [progressive download][126]).
Live [streamed media][127] lacks a finite start and end time, as in static file.
It is a stream of data that the server passes on down the line to the browser
and often uses [adaptive streaming][128].
Adaptive streaming works by detecting a user's bandwidth and CPU capacity in real time
and adjusting the quality of a video stream accordingly.
There a [multiple adaptive streaming formats][129] available.

## What Type of Streaming Do I Need?
An important requirement for my streaming camera needs
are that you can view it with ease,
viewed by multiple people concurrently,
and done so from anywhere with no restriction from networks or firewalls.
To me, this means that the video stream should be playable from a web browser.
Having to run a specific player, aka video decoder, is a complication I don't want.
So I want something that will work on any browser.
To get past the restrictions a network or firewall could impose,
I'll need to have [reverse proxy][115],
effectively putting the video stream on a web server outside the Raspberry Pi's network.

So this calls for a live video stream to an external web server.
There are a few modern streaming protocols for web browsers out there
but all the incompatible options is really annoying.
[Choosing a video format for stream to a website is a complicated topic][117]:

* [HTTP Live Streaming (HLS)][124] is Apple's choice.
It isn’t supported natively by any desktop browser except for Safari.
It is supported on mobile.
This means you will need either a Silverlight or Flash player to play the stream on your desktop,
which is great except Chrome no longer supports either of these things.
* [MPEG-DASH][123] is better though there is no native support in the desktop browsers
yet but there are JavaScript implementations of it that allow its use via MSE.
* [Fragmented MP4][122] is supported by Adobe and Microsoft, but requires browser plugins
* [HTML5 video][125] is the new standard way to embed a video in a web page.

Before HTML5, a video could only be played in a browser with a plug-in (like flash),
but supported only on HTML5 compatible browsers like Chrome and FoxFire.

## Streaming Video to Web Page
The [introductory article about the camera module][99]
in the Raspberry Pi blog shows a method to [stream video][104]
from the Raspberry Pi to another computer.
(See "How does video streaming work?", [Part 1][105], [Part 2][106], [Part 3][107].)
This method essentially works as follows:

* On the Pi the `raspivid` utility is used to [encode H.264 video][100] from the camera
* The video stream is piped to the [netcat (`nc`)][101] utility,
which pushes it out to the network address where the video player is.
* On the player computer `nc` receives the stream and pipes it into [`mplayer`][102] to play.

This is an efficient method of streaming video from the RPi to another computer,
but it has a few problems for my use:

* The Raspberry Pi needs to know the address of the computer that is playing the video
* The playing computer needs to have an advanced player that can play a raw H.264 video stream.
* Since this system relies on a direct connection between the Pi and the player,
it is impossible to have the player computer connect and/or disconnect from the stream,
the connection needs to be on at all times.
* And what if you want to support two, three, or N concurrent players?
This cannot be done with this method.

So I want to live video stream broadcast (not just point-to-point)
from my Raspberry Pi camera, to a web server where
**any HTML5 compatible browser** can play it
(see this site to test your browser for HTML5 compatibility - http://html5test.com/).
This has proven to be a taller order than I originally imagined.

# video Formats
* [Video Formats Explained](https://www.videomaker.com/article/c10/15362-video-formats-explained)
* https://imagenevp.com/top-10-video-formats/
* https://en.wikipedia.org/wiki/Video_file_format
* [The Complete List of Audio / Video File Formats for Developers](https://blog.filestack.com/thoughts-and-knowledge/complete-list-audio-video-file-formats/)

H.264
AVI (Audio Video Interleave)
FLV (Flash Video Format)
WMV (Windows Media Video)
MOV (Apple QuickTime Movie)
MP4 (Moving Pictures Expert Group 4)
MKV - https://www.howtogeek.com/200736/what-is-an-mkv-file-and-how-do-you-play-them/
    * https://www.quora.com/How-do-I-play-mkv-files-on-Raspbian

* [Video Files](https://fileinfo.com/filetypes/video)
* [What Is Video Format and Which Video Format to Choose?](https://filmora.wondershare.com/video-editing-tips/video-formats.html)

## What is a Codec?
Most of the video you'll come across is compressed,
usually to make them smaller in size and more manageable,
usually with some loss in video quality.
A codec compresses and decompresses data.
It interprets the video file and determines how to play it on your screen.
Your computer comes with many codecs pre-installed,
though you can install codec packs for wider support,
or a program like VLC which have lots of codec support built-in.

Some examples of codecs include:

* FFmpeg (which includes formats like MPEG-2, the format in which DVDs are stored, and MPEG-4, the format Apple uses for movies in the iTunes store)
* DivX, which works with a certain type of MPEG-4 file, and was often used to rip DVDs in the pre-HD era
* XviD, an open source version of DivX, popular among movie pirates
* x264, which compresses H.264 videos (Also known as MPEG-4 AVC), and is very popular for high definition videos

There are a lot of different codecs out there, and it can get really confusing with all the different versions of MPEG standards.

* [Comparison of video codecs](https://en.wikipedia.org/wiki/Comparison_of_video_codecs)
* [Moving Picture Experts Group - MPEG](https://en.wikipedia.org/wiki/Moving_Picture_Experts_Group)

## What Is a Container?
A container is, essentially, a bundle of files. Usually a container consists of a video codec and an audio codec, though it can also contain things like subtitles. Containers allow you to choose one codec for your video and one for your audio, which is nice—that way, you can choose to use the high-quality DTS audio, or compress your audio to something like MP3 for even more space savings. It just gives you a bit more control over how you record your videos or rip your movies. Popular containers include:

* AVI
* Matroska (which uses the extension MKV)
* MP4 (which has been popularized by Apple in the iTunes Store—note that this can also come with the M4V extension, but the container is the exact same)
* MOV (which was created by Apple)

The main difference between different containers is not only the codecs they support but what other features they support—like subtitles or chapters. These days, MKV is an extremely popular container, mainly because it supports nearly any video codec under the sun, as well as a ton of extra features (plus it's open source).

* [Comparison of video container formats](https://en.wikipedia.org/wiki/Comparison_of_video_container_formats)

# Converting Video Formts
* convert a video with ffmpeg
* HandBrake - https://handbrake.fr/downloads.php

# Video Frameworks
* Video4Linux2
* UV4L - User space Video4Linux - https://www.linux-projects.org/
    * How to install or upgrade UV4L on Raspbian Wheezy & Raspbian Jessie (for Raspberry Pi) - https://gist.github.com/rveitch/907a449fa6d4e12ca1d4d1ebf9b03a04
    * WebRTC extension - https://www.linux-projects.org/uv4l/webrtc-extension/

## Video Players
* hello_video - https://learn.adafruit.com/raspberry-pi-video-looper/hello-video
* mplayer - `sudo apt-get install mplayer2`
* omxplayer - https://elinux.org/Omxplayer
* vlc and cvlc - `sudo apt-get install vlc browser-plugin-vlc libavcodec-extra-53`
    * https://wiki.videolan.org/Documentation:Streaming_HowTo/Command_Line_Examples/
    * `vlc --longhelp --advanced` for a complete list of available options.
* Android using the RPi Camera Viewer (RPiC) app - http://frozen.ca/rpi-camera-viewer-for-android/
    *Using the UV4L driver to stream video from the raspberry pi camera to android phone - https://raspberrypi.stackexchange.com/questions/22372/using-the-uv4l-driver-to-stream-video-from-the-raspberry-pi-camera-to-android-ph

### omxplayer
omxplayer is a great general purpose video player that offloads video decoding
to the Pi's GPU so it can render 720p and even 1080p video on the Raspberry Pi 1 and Pi 2.
To use omxplayer you'll want to make sure your video is encoded with an H.264 codec and is in a file format like .avi, .mov, .mkv, .mp4, or .m4v.  If you have a video in a different format or that won't play you convert it into an H.264 video easily with some free tools.

# A Tour of Video Stream Techniques
* https://en.wikipedia.org/wiki/Netcat
* https://mike632t.wordpress.com/2014/11/04/video-streaming-using-netcat/
* https://www.linux-projects.org/uv4l/tutorials/
* UV4L - User space Video4Linux - https://www.linux-projects.org/uv4l/
* Is UV4L the best way to steam to the web? - https://www.raspberrypi.org/forums/viewtopic.php?t=169832

## Playing Video Continuously Locally
**H.264 Encoding / Using Player / Viewable on RPi / One Viewer**
The most basic type of video would be to play it locally
on the Raspberry Pi which has the Pi Camera.
This is a form of video streaming, but the most elementary type.

```bash
# stream H.264 encode video from the pi camera directly to a player
raspivid -t 0 -w 640 -h 360 -fps 30 -o - | mplayer -
```

## Streaming Raw H.264 From A Raspberry Pi into a Player
**H.264 Encoding / Using Player / Viewable on Local Network / One Viewer**

Here I will explains how to generate a raw H.264 stream on a Raspberry Pi (RPi)
and send that stream to other computers on a network
where it can be viewed.
The stream can be played on:

* Another Raspberry Pi using the standard hello_video demo program
* Android using the RPi Camera Viewer (RPiC) app

http://frozen.ca/streaming-raw-h-264-from-a-raspberry-pi/
http://frozen.ca/rpi-camera-viewer-for-android/
https://en.wikipedia.org/wiki/Netcat

### Step 1: Video Streamer
The RPi's Pi Camera tool `raspivid` will be use to create the video.
we'll use the following:

```bash
# stream H.264 encode video from the pi camera
raspivid -n -ih -t 0 -rot 0 -w 640 -h 360 -fps 15 -o -
```

Where the parameters and options mean:

* **-w 1280** - video image pixel width
* **-w 720** - video image pixel height
* **-fps 15** - frames per second
* **-n** - to not show the video on the Raspberry Pi display
* **-ih** - to insert H.264 headers into the stream
* **-t 0** - to keep streaming forever
* **-rot 0** - to not rotate the stream
* **-o –** - to send the stream to stdout

We will pipes the output of `raspivid` into the netcat program, `nc`,
which then sends the stream out over a specific TCP/IP port.
We can use the following for `nc`:

```bash
# netcat will listen to port 5001 for a connection
nc -v -k -4 -l 5001
```

netcat can only handle one stream at a time.
If you want to handle multiple network streams at the same time,
you need to replace netcat with `ncat`,
which is part of the nmap package (install via `sudo apt-get install -y nmap`)

Now just substitute `ncat` for `nc` in the above command
and multiple devices will be able to view the stream simultaneously.

The netcat parameters are:

* **-l 5001** - listen on local port 5001
* **-k** - to connect repeatedly
* **-v** - to produce verbose error messages
* **-4** - to use IPv4 addresses only

Putting this all together,
on your RPi capturing the video, use the following command:

```bash
# outbound stream of H.264 encode video from the pi camera to a port
raspivid -n -ih -t 0 -rot 0 -w 640 -h 360 -fps 15 -o - | ncat -v -k -4 -l 5001
```

### Step 2: Video Player
On another system within your network,
we need to take this stream of H.264 encode video
and pipe into into a video decoder.
`mplayer` can decode H264 video
and we'll use netcat again to connect with the source.

**NOTE:** If you have a firewall enabled
on the machine that is to receive the video stream,
you will also need to allow inbound UDP connections.
https://mike632t.wordpress.com/2014/11/04/video-streaming-using-netcat/

```bash
nc 192.168.1.200 5001 | mplayer - -fps 15

nc -l -u -p 5001 192.168.1.208 | mplayer -
```



* https://mike632t.wordpress.com/2014/11/04/video-streaming-using-netcat/
* http://frozen.ca/streaming-raw-h-264-from-a-raspberry-pi/
* https://www.raspberrypi.org/forums/viewtopic.php?t=178493
* http://www.raspberry-projects.com/pi/pi-hardware/raspberry-pi-camera/streaming-video-using-vlc-player
* http://www.raspberry-projects.com/pi/pi-hardware/raspberry-pi-camera/streaming-video-using-vlc-player
* https://raspberrypi.stackexchange.com/questions/27082/how-to-stream-raspivid-to-linux-and-osx-using-gstreamer-vlc-or-netcat

## Streaming Raw H.264 From A Raspberry Pi but now using v4l2-ctl and cvlc
* https://www.raspberrypi.org/forums/viewtopic.php?f=43&t=146597
* https://raspberrypi.stackexchange.com/questions/23182/how-to-stream-video-from-raspberry-pi-camera-and-watch-it-live
* https://web.archive.org/web/20151012014829/http://www.videolan.org:80/doc/streaming-howto/en/ch03.html

## uv4l on Raspberry Pi
**Using Browser / Local Network / Multiple Viewers**
how to stream a Raspicam to a web using a Raspberry Pi and the UV4L driver.

* http://blog.cudmore.io/post/2016/06/05/uv4l-on-Raspberry-Pi/
* http://www.instructables.com/id/Raspberry-Pi-Video-Streaming/

## MJPG Streaming
* https://www.raspberrypi.org/forums/viewtopic.php?t=45178

## stream Sent straight to web clients
* https://github.com/pimterry/raspivid-stream
* http://www.mjoldfield.com/atelier/2013/12/raspivid.html
* https://raspberrypi.stackexchange.com/questions/7446/how-can-i-stream-h-264-video-from-the-raspberry-pi-camera-module-via-a-web-serve
* http://blog.cudmore.io/post/2016/06/05/uv4l-on-Raspberry-Pi/

## Raspberry Pi as a Live Streaming Camera That Broadcasts to YouTube
* https://lifehacker.com/set-up-a-raspberry-pi-as-a-live-streaming-camera-that-b-1790317509














## Playing Video on Youtube
* [Introduction to live streaming on Youtube](https://support.google.com/youtube/answer/2474026?hl=en)
* https://www.digikey.com/en/maker/blogs/streaming-live-to-youtube-and-facebook-using-raspberry-pi-camera/969a7932d47d42a79ba72c81da4d9b66


# How to Stream Video Directly from Raspberry Pi Camera
VLC is an open source media player supported on a wide number of computing platforms,
including GNU/Linux, Windows, Mac OS X, BSD, iOS and Android.
VLC can play most multimedia files, discs, streams, allows playback from
devices, and is able to convert to or stream in various formats.

* [How to stream video from Raspberry Pi camera and watch it live](https://raspberrypi.stackexchange.com/questions/23182/how-to-stream-video-from-raspberry-pi-camera-and-watch-it-live)
* [The Raspberry Pi Camera Module](https://www.ics.com/blog/raspberry-pi-camera-module#.VJFhbyvF-b8)
* [VLC media player](https://github.com/videolan/vlc)
* [Documentation:Streaming HowTo New](https://wiki.videolan.org/Documentation:Streaming_HowTo_New/)
* [Documentation:Streaming HowTo/Command Line Examples](https://wiki.videolan.org/Documentation:Streaming_HowTo/Command_Line_Examples/)



## Video File on HTML5 Browser
In [modern browsers][131] (which loosely means a browser without workarounds
and conforming to the latest Web/HTML standards, e.g. a HTML5 compliant browser),
adding a video to your page is as easy as adding an image.
No longer do you need to deal with special plug-ins or require crazy markup,
you can do it with a single element.

For example,
obtain any `mp4` video file (like `All-is-Full-of-Love-by-Bjork.mp4`
created via `youtube-dl -k https://vimeo.com/43444347`) and
put the HTML code below in file called `html5-video-example-1.html`
in the same same directory as the `mp4` file.
Then fire up a browser pointing to the HTML file; something like
`google-chrome html5-video-example-01.html`.

```html
<!DOCTYPE html>
<html>
<head>
	<title>HTML5 Video Example-1</title>
</head>
<body>
    <h1> HTML Video Example-1</h1>
    <video src="/home/jeff/tmp/All-is-Full-of-Love-by-Bjork.mp4" controls>
    </video>
</body>
</html>
```

That's all you need to embed a simple video on a webpage
and show the basic controls so that a user can play,
pause, or otherwise control the video.
Of course, this can get more elaborate.
Check out the posting "[HTML5 Video][132]" for examples
containing subtitles, opening posters, etc. like this:

```html
<!DOCTYPE html>
<html>
<head>
	<title>HTML5 Video Example-2</title>
	<style type="text/css">
	       html, body {
	           color: #FFFFFF;
	           text-align: center;
	           background-color: #111;
	       }
	</style>
</head>
<body>
    <h1> HTML Video Example-2</h1>
    <video controls style="width:640px;height:360px;" poster="https://thenewboston.com/images/forum/logos/145efe2aab7ca9959397d6344180b658.png">
        <source src="https://ia800201.us.archive.org/12/items/BigBuckBunny_328/BigBuckBunny_512kb.mp4"
            type="video/mp4">
        <track src="/home/jeff/tmp/mov_bbb.vtt" label="english subtitles"
            kind="subtitles" srclang="en" default></track>
    </video>
</body>
</html>
```

## Streaming Video Using Raspberry Pi Zero
Despite the ease in which video files can be displayed within a HTML5 browser,
as shown in the previous section,
streaming to HTML5 in 2017 is still annoyingly hard.
I then came upone [PhotosLab HTML5 video streaming via websockets][133]
using a package called [JSMpeg][134].
[JSMpeg is a Video Player written in JavaScript][135].
It uses the broadcast industries [MPEG transport stream (MPEG-TS, MTS or TS)][136] transport streaming format.
It it claims to do low latency streaming (~50ms) via WebSocktes,
decode 720p Video at 30fps on an iPhone 5S, and works in any modern browser (Chrome, Firefox, Safari & Edge).
Dominic Szablewski, the creater of JSMpeg,
explains [here][137] why he resorting to what appears to be a browser hack makes sense.

The author of JSMpeg gives a [nice write up][01]
(and more [here][133] and [here][134]) on why the Pi Camera sometimes
has latency problems and how JSMpeg helps to resolve this by resorting to the
primitive features of MJPEG1 video format and JavaScript capabilities found in all browsers.

To top it off, Dominic provde an [implementation for the Raspberry Pi][138].
Procedures for this are in the following section.

### Step 0: Make Sure Camera is Working
With all the moving parts on this approach,
lets makes sure each component is working properly.
The first  and most fundamental component to check is the camera.
Lets see it the camera is working by using some of the Raspberry Pi's native camera tools:

```bash
# take picture and store in image.jpg
raspistill -o ~/tmp/image.jpg --width 1024 --height 768

# display picture for viewing
display ~/tmp/image.jpg

# capture 5 second video in file video.h264
raspivid -o ~/tmp/video.h264 --timeout 5000 --width 1024 --height 768 --codec H264

# play the video
mplayer ~/tmp/video.h264
```
### Step 1: Streaming Using pistreaming
First, lets try using a utility that the whole job for us.
`pistreaming` performs low latency streaming of the Pi's camera module to any reasonably modern web browser.
It make use of [JSMpeg][134], which is a Video Player written in JavaScript.
Other dependencies are the Python ws4py library, my picamera library (specifically version 1.7 or above), and FFmpeg

To begin, make sure you've got the dependent packages installed
and then clone the [`pistreaming` repository][58]:

```bash
# install required packages
sudo apt-get install libav-tools git python3-picamera python3-ws4py

# clone this repository
cd ~/src
git clone https://github.com/waveform80/pistreaming.git

# run the Python server script
cd pistreaming
python3 server.py
```

Now fire up your favorite web-browser and point it at the Raspberry Pi where your
running `pistreaming` using port `8082` (e.g. for me `google-chrome http://spycam-01:8082/`).
This configuration consumes about 85% of the CPU on the Raspberry Pi Zero.

>**NOTE:** While all this was easy enough to install on the Raspberry Pi Zero,
it initially showed a flickering image in the browser, never got an acceptable video.
I thought that if I used with more power than the RPi Zero (cpu was running at nearly 90%)
I could get better results.
Then I had problems booting up the RPi with the WiFi dongle installed and I happened to swap
out the WiFi dongle for a [Edimax EW-7811Un][02] (a dongle widely recommended for the RPi)
and both the boot and flicker problems went away.
I think the dongle was drawing two much power (WiFi dongle gets hot to the touch).


### Step 2: Install ffmpeg
[!ffmpeg](https://prupert.files.wordpress.com/2009/10/ffmpeg-logo.png)
[FFmpeg][95] claims to play pretty much anything that humans and machines have created;
supporting the most obscure ancient formats up to the cutting edge.
FFmpeg is able to decode, encode, transcode, mux, demux, stream, filter and play most anything.
Effectively, FFmpeg continuously streams a webcam's video to single `.jpg` file.
This toolkit contains:

* `**[ffmpeg][94]**` - is a command line tool for fast video and audio converter that can also grab from a live audio/video source.
* `**[ffserver][93]`** - is a streaming server for both audio and video.
* `**[ffplay][92]**` - is a command line simple and portable media player using the FFmpeg libraries and the SDL library.
* `**[ffprobe][91]**` - is a command line tool to gathers information from multimedia streams and prints it in human- and machine-readable fashion.

Unfortunately, Debian Jessie and later [no longer include the ffmpeg package][140].
To install it and make sure we have the latest and greatest ffmpeg,
I choose to [install from source code][139].
The procedure for this is below
(Get some coffee, this will take over two hours on a Raspberry Pi Zero.):

```bash
# install all the packages you need
sudo apt-get install yasm nasm build-essential automake autoconf libtool pkg-config libcurl4-openssl-dev intltool libxml2-dev libgtk2.0-dev libnotify-dev libglib2.0-dev libevent-dev checkinstall

# clone the ffmpeg package or download the latest snapshot
cd ~/src
git clone git://git.videolan.org/ffmpeg.git

# compile ffmpeg
cd ffmpeg
./configure --prefix=/usr
time make -j 8

# use RELEASE in checkinstall's version
# (NOTE: to work, I needed to create manually the directory /usr/share/ffmpeg)
cat RELEASE
sudo checkinstall

# install the deb file you made for ffmpeg
sudo dpkg --install ffmpeg_*.deb
```

### Step 3: Install node, npm, and Web Server
You need to install Node.js and npm, if not done already.
Node is used to stream the video, via a websocket, to a HTML5 browser.

Just to make sure I have maximum control over my `node.js` version,
like versioning for `ffmpeg`, I'm going to
head to the [Node.js download page][142] and grab the latest version.
For Linux, you can also install Node via the package manager,
for example [installing on Node.js on Ubuntu 16.04][143].
The install option I prefer is to use [Node Version Manager, `nvm`][144],
which give you on-demand access to the newest versions of Node.js,
but will also allow you to target previous releases that your app may depend on.
If you work with a lot of different Node.js utilities and projects,
you know sometimes you need to switch to other versions of Node.js.
That's where you can use `nvm` to download, install, and use different versions of Node.js.

```bash
# remove any previously installed version of node.js
sudo apt-get remove nodejs-legacy npm

# install required packages
sudo apt-get update
sudo apt-get install build-essential libssl-dev

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash

# make sure to restart your terminal window
# verify theat nvm is installed which should output 'nvm' if the installation was successful
# NOTE: 'which nvm' will not work, since nvm is a sourced shell function, not an executable binary
command -v nvm
nvm --version

# to find out the versions of Node.js that are available for installation
nvm ls-remote
```
When you install Node.js using `nvm`,
the executable is called `node`.
You can see the version currently being used by the shell by typing `node -v`.

```bash
# you can install latest stable version of node
nvm install stable

# what version of node is currently being used
node -v

# list the multiple node.js versions installed
nvm ls

# you can install a specific version of node
nvm install 6.0.0

# to make one of the versions your default
# this version will be automatically selected when a new session spawns
nvm alias default 6.0.0

# can also switch to your default be using an alias
nvm use default

# to switch to and use another node.js version
nvm use 4.2.6
```

Verify your installation, which should also include the Node Package Manager, `npm`.

```bash
# where is node.js located
$ which node
/usr/bin/node

# what version of node.js are your using
$ node --version
v4.2.6

# location and version of node package manager
$ which npm
/usr/local/bin/npm
$ npm --version
4.1.1
```
For this streaming video solution using JSMpeg,
you'll also need to install Node.js `http-server`.
This web server will be use serve the static files
(`view-stream.html`, `jsmpeg.min.js`)
from which you can view the video in our browser.
If you wanted to, any other web server would work as well (nginx, apache, etc.
but `http-server` is very lightweight and simple to use.

```bash
# install a node web server
npm install -g http-server
```

### Step 4: Install JSMpeg
Install the JSMpeg GitHub repository on the Raspberry Pi:

```bash
# clone the jsmpeg repository
cd ~/src
git clone https://github.com/phoboslab/jsmpeg.git

# install node.js websocket library needed by jsmpeg
cd jsmpeg
npm install ws
```

### Step 5: Start the Websocket Relay
We'll now start things up and send our Raspberry Pi video to a web browser.
First, you must start the Websocket relay.
To do this, you must provide a password and a port for the incoming HTTP video stream from the camera.
You also provide a Websocket port that can connect to with a browser to see the video.

Within **one terminal window** on the Raspberry Pi, start up the Websocket relay:

```bash
# start the websocket relay
cd ~/src/jsmpeg
$ node websocket-relay.js password 8081 8082
Listening for incomming MPEG-TS Stream on http://127.0.0.1:8081/<secret>
Awaiting WebSocket connections on ws://127.0.0.1:8082/
```
Within a **second terminal window**, start your `http-server`
so we can serve the `view-stream.html` to a browser:

```bash
# start the web server so you can connect with the websocket
cd ~/src/jsmpeg
$ http-server
Starting up http-server, serving ./
Available on:
  http://127.0.0.1:8080
  http://192.168.1.27:8080
Hit CTRL-C to stop the server
```

Now within a **third terminal window**,
start `ffmpeg` to capture the Raspberry Pi video
and send it to the Websocket relay.
Provide the password and port from the above step in your destination URL:

```bash
# to access the camera board on /dev/video0 run
sudo modprobe bcm2835-v4l2

# start ffmpeg to capture video and send it to the websocket relay
ffmpeg -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 -f mpegts -codec:v mpeg1video -s 640x480 -b:v 1000k -bf 0 http://localhost:8081/password
```

> **NOTE:** You can avoid running the `modprobe` by
putting `modprobe bcm2835-v4l2` in `/etc/rc.local` so it runs on every boot automatically.

### Step 6: View Video in Browser
Now, from anywhere on the _same network as the Raspberry Pi_
(so still not fulfilling all my requirements stated above),
fire up a browser to view the streaming video:

```bash
# view the streaming video
google-chrome http://spycam-01:8080/view-stream.html
```

Like the `pistreaming` utility, all of this appear to work on the Raspberry Pi Zero,
but there was considerable latency, the camera frame rate was 20 FPS,
and the CPU utilization was slightly above 90%.
I suspect this was due to the fact that the camera streaming (`ffmpeg`),
the WebSocket Relay (`websocket-relay.js`),
and the web server to view the video (`http-server`)
were all on the under powered Zero.

## Streaming Video But Distributing the Load
My next task is to move some the work being done by the able, but weak Raspberry Pi Zero,
to other more powerful processors.
Ultimately, these other  processors will be entirely off the network where the RPi Zero resides.
The `ffmpeg` process must run on the Raspberry Pi Zero,
since it must talk to the camera device driver,
but the other processes do not.

### Step 1: Move WebSocket Relay and Web Server
My plan is to us my beefer Linux box, `desktop`,
and placed both the WebSocket Relay (`websocket-relay.js`),
and the web server to view the video (`http-server`).

So in my case,
I created a clone of JSMpeg on `desktop` in directory `~/src/zetta-demo/tools`.
`desktop`'s IP address is `192.168.1.200`.

```bash
# install node.js websocket library needed by jsmpeg
cd ~/src/zetta-demo
npm install ws

# clone the jsmpeg repository
cd ~/src/zetta-demo/tools
git clone https://github.com/phoboslab/jsmpeg.git
```

### Step 2: Startup WebSocket Relay and Web Server
Like we did in the earlier,
we'll get the relay and server running so they can support FFmpeg running on the RPi Zero.
On `desktop` and within **one terminal window**, do the following:

```bash
# goto where you keep the websocket relay
cd ~/src/zetta-demo/tools/jspeg

# start the websocket relay
$ node websocket-relay.js password 8081 8082
Listening for incomming MPEG-TS Stream on http://127.0.0.1:8081/<secret>
Awaiting WebSocket connections on ws://127.0.0.1:8082/
```

Still on `desktop`, within a **second terminal window**:

```bash
# goto where  you keep the websocket relay
cd ~/src/zetta-demo/tools/jspeg

# start the web server so you can connect with the websocket
$ http-server
Starting up http-server, serving ./
Available on:
  http://127.0.0.1:8080
  http://192.168.1.200:8080
  http://192.168.1.13:8080
Hit CTRL-C to stop the server
```

Now on the Raspberry Pi Zero, within a **third terminal window**,
I ran the following:

```bash
# start ffmpeg to capture video and send it to the websocket relay
ffmpeg -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 -f mpegts -codec:v mpeg1video -s 640x480 -b:v 1000k -bf 0 http://desktop:8081/password
```

### Step 3: View Video in Browser
Now, from anywhere on the _same network as the Raspberry Pi_
(**but in principle**, my requirements can be meet since `desktop`
doesn't have to be on the same LAN as the Raspberry Pi Zero),
fire up a browser to view the streaming video:

```bash
# view the streaming video
google-chrome http://desktop:8080/view-stream.html
```

So now I'm once again stream the camera to a local web page (aka on the same LAN),
but the distributed archtectue allows for the web page to be anywhere.
All of this appear to work well, but again,
there was considerable latency, the camera frame rate was 20 FPS,
and the CPU utilization was slightly above 85%.

Given that FFmpeg is now deprecated and replaced by [`avconv`][03]
(despite some beliving in [FFmpeg superiority][04]),
I thought I would give it a try:

```bash
# start avconv to capture video and send it to the websocket relay
avconv -f rawvideo -framerate 25 -video_size 640x480 -i /dev/video0 -f mpegts -codec:v mpeg1video -s 640x480 -b:v 1000k -bf 0 http://desktop:8081/password

# view the streaming video
google-chrome http://desktop:8080/view-stream.html
```

Using `avconv` was slightly more demanding of CPU on the Raspberry Pi Zero
but the latency was noticeable better.

### Step 4: Streaming from a File
While the purpose of all this is to stream live video,
as you can see here,
you can easily do the same from a file.
This also demonstrates that you can include not only the video but sound too.

```bash
# video form file, with sound, but some static for unkown reason
ffmpeg -re -i All-is-Full-of-Love-by-Bjork.ts -codec copy -f mpegts -codec:v mpeg1video -s 640x480 -b:v 1000k -bf 0 http://desktop:8081/password

# view the streaming video
google-chrome http://desktop:8080/view-stream.html
```

####################################

* [Stream a file with original playing rate](http://superuser.com/questions/508560/ffmpeg-stream-a-file-with-original-playing-rate)
* [RTP streaming with ffmpeg](http://lucabe72.blogspot.com/2010/04/rtp-streaming-with-ffmpeg.html)
* [Using CVLC for streaming using RTP protocol under Linux](https://inogeni.com/knowledgebase/using-cvlc-for-streaming-using-rtp-protocol-under-linux/)
* [How can I stream h264 files with FFmpeg over rtmp without reencoding?](http://forum.videohelp.com/threads/377436-How-can-I-stream-h264-files-with-FFmpeg-over-rtmp-without-reencoding)
* [An ffmpeg and SDL Tutorial](http://dranger.com/ffmpeg/ffmpeg.html)
* [A quick guide to using FFmpeg to convert media files](https://opensource.com/article/17/6/ffmpeg-convert-media-file-formats?sc_cid=70160000000gz65AAA)
* [ffmpeg documentation](https://www.ffmpeg.org/documentation.html)

####################################



## Streaming Camera to a Public Web Page
* [Secure Simple Remote Access for Camera Viewing](https://www.hackster.io/beame-io/secure-simple-remote-access-for-camera-viewing-64832e?utm_source=Hackster.io+newsletter&utm_campaign=b3faba5059-EMAIL_CAMPAIGN_2017_05_03&utm_medium=email&utm_term=0_6ff81e3e5b-b3faba5059-140225889&mc_cid=b3faba5059&mc_eid=9036129d51)




## Motion JPEG
Some IP webcams do this by delivering [Motion JPEG or MJPEG][98] images.
MJPEG just streams individual JPEG pictures, one after another.
(In fact, some people have created streaming video solution
using this concept of [streaming JPEG pictures][130].)
Most [modern browsers][103] (think HTML5) can play MJPEG streams natively.
The down side of MJPEG streams is that they are not as efficient as [H.264][116],
which greatly improves quality and reduces size
by encoding only the differences from one frame to the next.
I'm willing to put up with the inefficiency to get the flexibility of browser support.

This brings to what I choose to implement,
[`mjpg-streamer`][96], a small open source MJPEG streaming server
that has been ported to the Raspberry Pi.
`mjpg-streamer` has a HTTP server streaming plugin,
which starts a web server that that you can connect your browser to watch the video.
This is all we need if the objective is to stream the viedo on you local LAN.
If you want to watch the video from anywhere,
you'll need to give your Raspberry Pi a static address
and open a port and forward from your home router to the RPi,
and expose the RPi the wild world of the Internet.
I prefer not to do this, and how to work around this will be shown in a subsequent step.
For now, we'll focus on how to get video streaming to a browser on your local LAN.





### Stream Video from a Public Site via WebSocket
http://www.earthcam.com/usa/newyork/timessquare/?cam=tsrobo1
http://weheart.digital/build-simple-live-streaming-solution/

### mjpg-streamer
[!mjpg-streamer](https://www.hqt.ro/wp-content/uploads/mjpg-streamer-fi1.png)
[`mjpg-streamer`][96] (its predecessor was `uvc_streamer`)
is a command line tool to stream JPEG files over an IP-based network
from a webcam to various types of viewers such as Chrome, Firefox, Cambozola, VLC, mplayer,
and other software capable of receiving MJPG streams.
It was originally written for embedded devices (e.g. OpenWrt) with very limited resources.
MJPG-streamer maybe the simplest way to stream a webcam.

The general consensus is that `mjpg-streamer` is faster and uses less CPU than most streamers,
so this may be ideal for your remote control projects in which real-time video feed is crucial for navigation
or light-weight hardware like the Raspberry Pi Zero.
Some webcams will deliver [Motion JPEG or MJPEG][98] images.
Mjpg-streamer is very efficient with these webcams,
as it just reads the images and streams them to the web.

The code block below will build a `mjpeg-streamer` from source
with added support for the Raspberry Pi camera via the `input_raspicam` plugin.
The build procedures and code are [on Github][96]
along with [documentation for `input_rapicam`][97], the Raspberry Pi plugin.

```bash
# make sure required tools and libraries are loaded
sudo apt-get install cmake libjpeg8-dev

# download, build, and install mjpg-streamer
cd ~/src
git clone https://github.com/jacksonliam/mjpg-streamer.git
cd mjpg-streamer/mjpg-streamer-experimental
make
sudo make install
```

With `mjpg-streamer` built for the Raspberry Pi,
you can now execute it and view the live video within a browser
(works great with Google Chrome and Firefox but not so much with Safari):

```bash
# change directories to where the plugins are located or provide path in environment
LD_LIBRARY_PATH=/home/pi/src/mjpg-streamer/mjpg-streamer-experimental ; mjpg_streamer -i "input_raspicam.so -rot 90 -ex night -ifx none awb auto" -o "output_http.so -w www -p 8090"

# streaming video in browser
google-chrome http://127.0.0.1:8090/?action=stream
```

The meaning of the parameters used with the `input_raspicam` plugin can be found [here][97].

By the way, `mjpg-streamer` can also be used on Ubuntu,
just need to use another plugin.
An example is given here:

```bash
# change directories to where the plugins are located or provide path in environment
LD_LIBRARY_PATH=/home/jeff/src/mjpg-streamer/mjpg-streamer-experimental ; mjpg_streamer -i "input_uvc.so -f 15 -r 1280x720" -o "output_http.so -w www -p 8090"

LD_LIBRARY_PATH=/home/jeff/src/mjpg-streamer/mjpg-streamer-experimental ; mjpg_streamer -i "input_uvc.so -q 85 -f 15 -r 1280x960" -o "output_http.so -w www -p 8090"

# streaming video in browser
google-chrome http://127.0.0.1:8090/?action=stream
```

################################################################
* [HOW TO RUN A PAGEKITE SERVER TO EXPOSE YOUR RASPBERRY PI](http://hackaday.com/2016/09/21/how-to-run-a-pagekite-server-to-expose-your-raspberry-pi/)
* [EXPOSE YOUR RASPBERRY PI ON ANY NETWORK](http://hackaday.com/2016/09/20/expose-your-raspberry-pi/)
* [PageKite](https://pagekite.net/)
* [Open Source PageKite](https://pagekite.net/wiki/OpenSource/)
* [NeoRouter](http://www.neorouter.com/products-nrfree)
################################################################

## Step X: Streaming Camera to the Internet
So far, using the Raspberry Pi camera module,
I have streamed video on my local network
but I wish to do this across the Internet.
Your Raspberry Pi will be transformed into a video surveillance camera
that you can place anywhere you can get WiFi with Internet access
and see the live streaming on a browser anywhere in the world.
You can [make your `localhost` (aka `127.0.0.1`) accessible from anywhere in the world][111]
via a [secure tunnel][112] service, or more specifically, [reverse proxy][115].
This provides you a publicly accessible URL, that watch for calls on that URL,
and then forwards those calls to your localhost server.
You'll need to install some software
from a fee for service provider like [`ngrok`][110] or build your own.
Luckly, ngrok has a free option.
So ngrok is a simple utility that will take my local web server extablished by mjpg-streamer
(aka video streaming server) and makes it available on the web.

Now sign up to the ngrok public servier at `https://dashboard.ngrok.com/user/signup`.
download ngrok, follow the [get strated page][114],
and check out the [ngrok documentation][113] for additional features.
The installation of `ngrok` is outlined below:

```bash
# download ngrok from https://ngrok.com/download
# no need for ngrok-server since you'll be using the public site
unzip ~/Download/ngrok.zip
sudo mv ~/Download/ngrok /usr/local/bin

# print version number of ngrok
ngrok version

# go to https://dashboard.ngrok.com/get-started and get your authtoken
ngrok authtoken dffjgyiorggkjt4435403_ggghhgl89B3k9ddlgiggg

# create your first secure tunnel
# open the web interface at http://localhost:4040 to inspect and replay requests
ngrok http 80
```

Now fire up the camera and use `ngrok` to stream the camera's live video to a
to the URL provided by `ngrok`:

```bash
# start streaming the video on the raspberry pi zero
LD_LIBRARY_PATH=/home/pi/src/mjpg-streamer/mjpg-streamer-experimental ; mjpg_streamer -i "input_raspicam.so -rot 90 -ex night -ifx none awb auto" -o "output_http.so -w www -p 8090"

# forward the video to the internet via ngrok
ngrok http 8090

# now using the url provide by ngrok, see the video in your broswer
google-chrome http://be4fac06.ngrok.io/?action=stream
```

## Step X: Potential Alternates for Streaming Camera
I did a considerable amount of research to identify `mjepg-streamer` as my solution.
It does appear to be the right choose, given all my constraint / requirements.
On the other hand, changing anyone of my assumtions could make it a poor choose.
Some of the alternatives that I investigate are documented here.

### webrtc, janus, gstreamer
[!webrtc](https://webrtc.org/assets/images/webrtc-logo-horiz-retro-750x140.png)
[WebRTC][71] is an open source project that provides browsers and mobile applications
with Real-Time Communications (RTC) capabilities
for audio, video, and data in Web and native apps via simple APIs.
The vision of WebRTC is a world where your phone, TV and computer
could all communicate on a common platform where it is
easy to add video chat and peer-to-peer data sharing to your web application.
WebRTC is available now in Google Chrome, Opera, and Firefox.
A good place to see how simple video can be is to open
`[apprtc.appspot.com](https://apprtc.appspot.com/)`
or see the [WebRTC samples][74]
in Chrome, Opera or Firefox on a video enable computer.
The [WebRTC project "Getting Started" page][72]
and [Getting Started with WebRTC][73] are excellent places to start.

[!janus](https://janus.conf.meetecho.com/janus-logo.png)
WebRTC has been conceived as a peer-to-peer solution:
that is, while signalling goes through a web server/application,
the media flow is peer-to-peer.
Nothing needed in the middle and only two participants.
Even in a simple peer-to-peer scenario,
one of the two involved parties (or maybe even both) doesn’t need to be a browser,
and may very well be a non-browser application.
So what if the application is "dumb" and doesn't know WebRTC?
Such an application will required a WebRTC Gateway:
one side talks WebRTC, while the other still WebRTC or something entirely different.
(See the post "[What is a WebRTC Gateway anyway?][78]").
A WebRTC Gateway is particularly useful for the many legacy infrastructures out there,
that may benefit from a WebRTC-enabled kind of access.
Also, the gateway could function to multicast, bridge, split, or otherwise process the streaming content
to create experiences you could otherwise have via a peer-to-peer solution (e.g. conferencing).
A popular a general purpose WebRTC gateway is [Janus][75].
In principle, you could use it to stream video from a Raspberry Pi directly to any browser
(doesn't have to be Google Chrome, Opera, or Firefox).
More importantly, you could create a more powerful user experince.
(See the presentation "[Janus: a general purpose WebRTC gateway][79]".)

[!gstreamer](https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Gstreamer-logo.svg/530px-Gstreamer-logo.svg.png)
[GStreamer][76] is a framework for creating streaming media applications.
The GStreamer framework is designed to make it easy to write applications
that handle audio or video or both.
It isn't restricted to audio and video,
and can process any kind of data flow.
Its main advantages are that the pluggable components can be mixed and matched
into arbitrary pipelines so that it's possible to write a
full-fledged video or audio editing application.
You can also use the pipelining capabilities of GStreamer
to take the video output from a Raspberry Pi camera module
and encode the video in H.264 format before passing it on to Janus.
GStreamer is a pipeline-based multimedia framework that links together
a wide variety of media processing systems to complete complex workflows.
For instance, GStreamer can be used to build a system that reads files in one format,
processes them, and exports them in another.
The formats and processes can be changed in a plug and play fashion.
(See this [diagram of the pipeline processing][77] for an example.)
This processing can be done on the [shell command line][82] or via
[Python bingdings][80] or [C bindings][81].
The article "[Gstreamer basic real time streaming tutorial][83]"
is a good introductory tutorial for GStreamer.

```bash
# streams desktop camera
gst-launch-1.0 -v v4l2src device=/dev/video0 ! xvimagesink
gst-launch-1.0 -v v4l2src ! xvimagesink
gst-launch-1.0 v4l2src ! xvimagesink

# view a video test pattern and screen with snow
gst-launch-1.0 videotestsrc ! autovideosink

# just screen with snow
gst-launch-1.0 videotestsrc pattern=snow ! autovideosink
```

* [VIDEO STREAMING LIKE YOUR RASPBERRY PI DEPENDED ON IT](https://hackaday.com/2017/09/12/video-streaming-like-your-raspberry-pi-depended-on-it/)
* [Gstreamer basic real time streaming tutorial](http://www.einarsundgren.se/gstreamer-basic-real-time-streaming-tutorial/)
* Smooth playback of adaptive video streams on Raspberry Pi with gst-mmal - https://gstreamer.freedesktop.org/data/events/gstreamer-conference/2016/John%20Sadler%20-%20Smooth%20video%20on%20Raspberry%20Pi%20with%20gst-mmal%20(Lightning%20Talk).pdf

### motion
[!motion](http://www.lavrsen.dk/foswiki/pub/Motion/WebPreferences/motion-trans.gif)
[`motion`][109] is a program that monitors the video signal from one or more cameras
and is able to detect if a significant part of the picture has changed.
Or in other words, it can detect motion.
Motion has many features can be a bit overwhelming
but the articles "[How to Operate Linux Spycams With Motion][118]" and
"[How to Set Up Motion Detection Webcam in Ubuntu][119]" will get you going.

* [TURN THAT PI ZERO INTO A STREAMING CAMERA, STEP-BY-STEP](https://hackaday.com/tag/wi-fi-camera/)
* [Raspberry Pi Security System Part 1: The camera](https://hackmypi.com/PiCamPart1.php)
* [motionEye is a web-based frontend for motion](https://github.com/ccrisan/motioneye)
* [motionEyeOS](https://github.com/ccrisan/motioneyeos/wiki)

### Camera Human Recognition
* [Building a Motion Activated Security Camera with the Raspberry Pi Zero](http://hackaday.com/2017/02/06/motion-detecting-camera-recognizes-humans-using-the-cloud/)
* [Smarten up your Pi Zero Web Camera with Image Analysis and Amazon Web Services (Part 1)](https://utbrudd.bouvet.no/2017/01/10/smarten-up-your-pi-zero-web-camera-with-image-analysis-and-amazon-web-services-part-1/)

# Step X: Live Stream to YouTube
* [Live Stream to YouTube With a Raspberry Pi](http://www.makeuseof.com/tag/live-stream-youtube-raspberry-pi/)
* [Youtube: Introduction to live streaming](https://support.google.com/youtube/answer/2474026?hl=en)
* [Raspberry Pi IP Camera YouTube Live Video Streaming Server](http://videos.cctvcamerapros.com/raspberry-pi/ip-camera-raspberry-pi-youtube-live-video-streaming-server.html)

## WebSockets
Nice writeup - http://www.neotys.com/blog/testing-tips-for-todays-tech-html5-websockets-rtmp-adaptive-bitrate-streaming/

## Step X: Real Time Streaming Protocol (RTMP)
RTMP was originally developed for streaming audio, video, and data over the Internet, between a server and a Flash player. It was created by Macromedia (now part of Adobe) and was later released as an open specification that’s commonly used for Flash and Flex/Air applications. The protocol supports AMF, SWF, FLV, and F4V file formats.

Today, most people agree that the video support included within HTML5 will reduce the need for these file formats. However, because there is so much video out there, and much of it is not HTML5-compliant yet, these traditional formats still carry a lot of weight.

Like WebSockets, RTMP creates persistent connections between a server and a client application written in Flash or Flex/Air. The technology is used to reduce the overhead involved in establishing and tearing down connections for low-latency or highly-interactive apps. Also like WebSockets, performance testing for RTMP is typically focused around the optimizing data that’s pushed from the server to the client.

* http://www.neotys.com/blog/testing-tips-for-todays-tech-html5-websockets-rtmp-adaptive-bitrate-streaming/
* [Android Streaming Live Camera Video to Web Page](http://www.androidhive.info/2014/06/android-streaming-live-camera-video-to-web-page/)

# First Person View (FPV)
Drones typically use old school analog video transmission
for longer-range frist person viewing (FPV).
These analog video signals are lossy and one-way (or one-to-many).
WiFi video is not what you want to send video from your quadcopter back to your FPV goggles.
WiFi is designed for 100% correct, two-way transmission of data between just two radios.
When you’re near the edge of your radios’ range,
you're first priority is getting any image in a timely fashion.
WiFi works hard to assure you get high quality images,
but while WiFi is retransmitting packets and your video is buffering, your quadcopter could be crashing.
You don’t need every video frame to be perfect.
On top of this, it’s just a lot easier to optimize both ends of a one-way transmission system
than it is to build antennas that must receive and transmit symmetrically.

[Befinitiv] wrote wifibroadcast to give his WiFi FPV video system some of the virtues of analog broadcast.

In particular, two Raspberry Pis combined with WiFi radios that can be put into monitor mode enable him to custom tailor the packets that get sent, allowing his rig to sidestep WiFi’s acknowledgment scheme, add in a custom retransmission routine that helps limit lost packets, and even allow multiple receivers to listen in to the same signal so that a diversity reception scheme could be implemented. - http://hackaday.com/2015/06/13/wifibroadcast-makes-wifi-fpv-video-more-like-analog/


* [Wifibroadcast – Analog-like transmission of live video data](https://befinitiv.wordpress.com/wifibroadcast-analog-like-transmission-of-live-video-data/)
Wifibroadcast is a project aimed at the live transmission of HD video (and other) data using wifi radios. One prominent use case is to transmit camera images for a first person view (FPV) of remote controlled aircrafts.
In contrast to a normal wifi connection wifibroadcast tries to mimic the advantageous properties of an analog link (like graceful signal degradation, unidirectional data flow, no association between devices).
Note: Before using wifibroadcast you have to check if the regulatories of your country allow such a use of wifi hardware.
* [(True) Unidirectional Wifi broadcasting of video data for FPV](https://befinitiv.wordpress.com/2015/01/25/true-unidirectional-wifi-broadcasting-of-video-data-for-fpv/)
* [EZ-WifiBroadcast](https://github.com/bortek/EZ-WifiBroadcast/wiki)
* https://dev.px4.io/en/wifibroadcast.html
* https://github.com/svpcom/wifibroadcast

* [FPV for dummies. All you need to know about FPV Racing Drones](https://coastlinerobotics.com/blogs/fpv-racing-drones-tutorials/60037699-fpv-for-dummies-all-you-need-to-know-about-fpv-racing-drones)
* [Drones and wireless video](http://www.datarespons.com/drones-wireless-video/)

# Auto-Connect to Open WiFi Network
[!open-wifi](http://true-random.com/homepage/projects/wifi/free_wifi.jpg)
I would like this project to auto-connect to any open WiFi network automatically;
Without knowing the SSID beforehand or involving any human intervention.

To have the RPi Zero search and connect to ANY Open WiFi,
modifiy the `/etc/network/interfaces`:

```bash
# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto lo
iface lo inet loopback

iface eth0 inet manual

# establish connection to home wifi and other known networks
auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```


See the following `/etc/wpa_supplicant/wpa_supplicant.conf`
to connect to any open / unsecured wifi in range:

```bash
# country code environment variable, required for RPi 3
country=US

# path to the ctrl_interface socket and the user group
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev

# allow wpa_supplicant to overwrite configuration file whenever configuration is changed
update_config=1

# 1 = wpa_supplicant initiates scanning and AP selection ; 0 = driver takes care of scanning
ap_scan=1

# wifi network settings for home network
network={
    id_str="home"              # needs to match keyword you used in the interfaces file
    psk="my-password"          # pre-shared key used in WPA-PSK mode ; 8 to 63 character ASCII passphrase
    ssid="74LL5"               # SSID either as an ASCII string with double quotation or as hex string
    mode=0                     # 0 = managed, 1 = ad-hoc, 2 = access point
    scan_ssid=0                # = 1 scan for hidden SSID ; = 0 scans for visible SSID
    proto=WPA RSN              # list of supported protocals; WPA = WPA ; RSN = WPA2 (also WPA2 is alias for RSN)
    key_mgmt=WPA-PSK WPA-EAP   # list of authenticated key management protocols (WPA-PSK, WPA-EAP, ...)
    pairwise=CCMP              # accepted pairwise (unicast) ciphers for WPA (CCMP, TKIP, ...)
    auth_alg=OPEN              # authentication algorithms (OPEN, SHARED, LEAP, ...)
    priority=5                 # priority of selecting this network (larger numbers are higher priority)
}

wifi network settings for jetpack
network={
    id_str="jetpack"           # needs to match keyword you used in the interfaces file
    psk="my-password"          # pre-shared key used in WPA-PSK mode ; 8 to 63 character ASCII passphrase
    ssid="Verizon-MiFi6620L-7EE6"      # SSID either as an ASCII string with double quotation or as hex string
    mode=0                     # 0 = managed, 1 = ad-hoc, 2 = access point
    scan_ssid=0                # = 1 scan for hidden SSID ; = 0 scans for visible SSID
    proto=WPA RSN              # list of supported protocals; WPA = WPA ; RSN = WPA2 (also WPA2 is alias for RSN)
    key_mgmt=WPA-PSK WPA-EAP   # list of authenticated key management protocols (WPA-PSK, WPA-EAP, ...)
    pairwise=CCMP              # accepted pairwise (unicast) ciphers for WPA (CCMP, TKIP, ...)
    auth_alg=OPEN              # authentication algorithms (OPEN, SHARED, LEAP, ...)
    priority=3                 # priority of selecting this network (larger numbers are higher priority)
}

# connect to any open / unsecured wifi in range (must broadcast an SSID)
network={
    id_str="open_wifi"         # needs to match keyword you used in the interfaces file
    ssid=""                    # SSID isn't important, any will do
    mode=0                     # 0 = managed, 1 = ad-hoc, 2 = access point
    key_mgmt=NONE              # network must be open with no security
    priority=-999              # priority of selecting this network (small number means network of last resort)
}
```

Now bring interface down/up and check status.
Execute `sudo ifconfig wlan0 down && sudo ifconfig wlan0 up && sudo wpa_cli -i wlan0 status`
and look for `wpa_state=COMPLETED`.

# Auto-Connect to Public WiFi Network
* [How to get free wifi on public networks](https://medium.freecodecamp.com/free-wifi-on-public-networks-daf716cebc80#.hesy8hhz6)
    * [FreeWifi](https://github.com/kylemcdonald/FreeWifi)
    * [SpoofMAC](https://github.com/feross/SpoofMAC)

## Domain Name Server (DNS)
* [Introduction to the Domain Name System (DNS)](https://opensource.com/article/17/4/introduction-domain-name-system-dns)
* [Build your own DNS name server on Linux](https://opensource.com/article/17/4/build-your-own-name-server)
* [dnsd: DNS encoder, decoder, and server](https://github.com/ansuz/modern-dnsd)

## Telemetry over Opportunistic WiFi Links
* [How DNS Tunneling Works](http://inside-out.xyz/technology/how-dns-tunneling-works.html)
* [DNS Tunneling: Getting The Data Out Over Other Peoples’ WiFi](http://hackaday.com/2016/08/07/getting-the-data-out-over-other-peoples-wifi/)
* [TOWL - Telemetry over Opportunistic WiFi Links](http://www.phreakmonkey.com/2016/08/towl-telemetry-over-opportunistic-wifi.html)
* [Nameserver Transfer Protocol (NSTX)](http://thomer.com/howtos/nstx.html)
* [iodine](http://code.kryo.se/iodine/)
* [dnscat2 – DNS Tunnel Tool](http://www.darknet.org.uk/2016/01/dnscat2-dns-tunnel-tool/)
* [Tunneling Data and Commands Over DNS to Bypass Firewalls](https://zeltser.com/c2-dns-tunneling/)
* [PowerShell DNS Command & Control with dnscat2-powershell](http://www.blackhillsinfosec.com/?p=5578)

## Augment Reality
* [AR.js: Efficient Augmented Reality for the Web](https://uploadvr.com/ar-js-efficient-augmented-reality-for-the-web/)
    * [Efficient Augmented Reality for the Web - 60fps on mobile!](https://github.com/jeromeetienne/ar.js)



[01]:https://github.com/waveform80/pistreaming#background
[02]:https://www.amazon.com/gp/product/B003MTTJOY
[03]:http://www.autodidacts.io/convert-media-files-like-a-geek-a-guide-to-video-transcoding-with-avconv-ffmpeg/
[04]:https://github.com/rg3/youtube-dl/issues/8622
[05]:
[06]:https://www.raspberrypi.org/blog/zero-grows-camera-connector/

[45]:http://petapixel.com/2016/04/25/raspberry-pi-camera-gets-first-ever-upgrade-now-8mp/
[46]:https://www.raspberrypi.org/blog/new-8-megapixel-camera-board-sale-25/
[48]:http://www.sony.net/Products/SC-HP/new_pro/april_2014/imx219_e.html
[49]:http://www.sony.net/Products/SC-HP/IS/sensor1/technology/exmor-r.html
[50]:https://en.wikipedia.org/wiki/1080p
[51]:https://en.wikipedia.org/wiki/720p
[52]:https://www.modmypi.com/download/raspicamdocs.odt
[53]:http://www.modmypi.com/blog/raspberry-pi-camera-board-raspivid-command-list
[54]:http://www.modmypi.com/blog/raspberry-pi-camera-board-raspistill-command-list
[55]:http://picamera.readthedocs.io/en/release-1.12/
[56]:https://github.com/waveform80/picamera
[57]:https://www.raspberrypi.org/magpi-issues/MagPi45.pdf
[58]:https://github.com/waveform80/pistreaming
[59]:http://www.pyimagesearch.com/2015/03/30/accessing-the-raspberry-pi-camera-with-opencv-and-python/
[60]:https://www.linux.com/learn/how-operate-linux-spycams-motion
[61]:https://learn.adafruit.com/li-ion-and-lipoly-batteries
[62]:https://www.adafruit.com/products/259
[63]:http://www.oreilly.com/openbook/linag2/book/ch11.html
[64]:http://hintshop.ludvig.co.nz/show/persistent-names-usb-serial-devices/
[65]:http://www.mikestreety.co.uk/blog/raspberry-pi-timelapse
[66]:http://www.computerhope.com/unix/screen.htm
[67]:http://bglug.ca/articles/nat_and_ip_masquerade.pdf
[68]:https://www.adafruit.com/products/3157
[69]:https://www.amazon.com/Micro-USB-OTG-Adapter-Cable/dp/B00D8YZ2SA
[70]:https://www.amazon.com/gp/product/B015GZOHKW/ref=oh_aui_detailpage_o05_s01?ie=UTF8&psc=1
[71]:https://webrtc.org/
[72]:https://webrtc.org/start/
[73]:https://www.html5rocks.com/en/tutorials/webrtc/basics/
[74]:https://webrtc.github.io/samples/
[75]:https://janus.conf.meetecho.com/docs/index.html
[76]:https://gstreamer.freedesktop.org/
[77]:http://developers-club.com/posts/236805/
[78]:https://webrtchacks.com/webrtc-gw/
[79]:https://archive.fosdem.org/2016/schedule/event/janus/attachments/slides/967/export/events/attachments/janus/slides/967/fosdem2016_janus_presentation.pdf
[80]:http://www.jonobacon.org/2006/08/28/getting-started-with-gstreamer-with-python/
[81]:https://arashafiei.files.wordpress.com/2012/12/gst-doc.pdf
[82]:http://wiki.oz9aec.net/index.php/Gstreamer_cheat_sheet
[83]:http://www.einarsundgren.se/gstreamer-basic-real-time-streaming-tutorial/

[91]:https://ffmpeg.org/ffprobe.html
[92]:https://ffmpeg.org/ffplay.html
[93]:https://ffmpeg.org/ffserver.html
[94]:https://ffmpeg.org/ffmpeg.html
[95]:https://ffmpeg.org/documentation.html
[96]:https://github.com/jacksonliam/mjpg-streamer
[97]:https://github.com/foosel/OctoPrint/wiki/MJPG-Streamer-configuration
[98]:https://en.wikipedia.org/wiki/Motion_JPEG
[99]:https://www.raspberrypi.org/blog/camera-board-available-for-sale/
[100]:http://www.h264info.com/h264.html
[101]:https://linux.die.net/man/1/nc
[102]:http://www.mplayerhq.hu/design7/info.html
[103]:http://farukat.es/journal/2011/02/528-modern-browser
[104]:https://www.jwplayer.com/blog/what-is-video-streaming/
[105]:http://mingfeiy.com/progressive-download-video-streaming
[106]:http://mingfeiy.com/traditional-streaming-video-streaming
[107]:http://mingfeiy.com/adaptive-streaming-video-streaming
[108]:https://en.wikipedia.org/wiki/H.264/MPEG-4_AVC
[109]:http://www.lavrsen.dk/foswiki/bin/view/Motion/WebHome
[110]:https://www.theodo.fr/blog/2016/06/expose-your-local-environment-to-the-world-with-ngrok/
[111]:https://www.sitepoint.com/accessing-localhost-from-anywhere/
[112]:https://en.wikipedia.org/wiki/Tunneling_protocol
[113]:https://ngrok.com/docs/2
[114]:https://dashboard.ngrok.com/get-started
[115]:https://en.wikipedia.org/wiki/Reverse_proxy
[116]:http://www.onlinevideo.net/2011/03/the-h-264-basics/
[117]:http://www.onlinevideo.net/2011/09/what-video-formats-should-you-stream-heres-how-to-decide/
[118]:https://www.linux.com/learn/how-operate-linux-spycams-motion
[119]:https://www.maketecheasier.com/setup-motion-detection-webcam-ubuntu/
[120]:http://www.mrhobbytronics.com/raspberry-pi-zero-reset-switch/
[121]:http://iot-projects.com/index.php?id=raspberry-pi-shutdown-button
[122]:http://www.pcmag.com/encyclopedia/term/65186/fragmented-mp4
[123]:https://en.wikipedia.org/wiki/Dynamic_Adaptive_Streaming_over_HTTP
[124]:https://en.wikipedia.org/wiki/HTTP_Live_Streaming
[125]:https://en.wikipedia.org/wiki/HTML5_video
[126]:https://en.wikipedia.org/wiki/Progressive_download
[127]:https://en.wikipedia.org/wiki/Streaming_media
[128]:https://en.wikipedia.org/wiki/Adaptive_bitrate_streaming
[129]:https://en.wikipedia.org/wiki/Adaptive_bitrate_streaming#Implementations
[130]:http://thejackalofjavascript.com/rpi-live-streaming/
[131]:https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/
[132]:https://www.html5rocks.com/en/tutorials/video/basics/
[133]:http://phoboslab.org/log/2013/09/html5-live-video-streaming-via-websockets
[134]:http://jsmpeg.com/
[135]:https://github.com/phoboslab/jsmpeg
[136]:https://en.wikipedia.org/wiki/MPEG_transport_stream
[137]:https://vimeo.com/144499042
[138]:https://github.com/phoboslab/jsmpeg#example-setup-for-streaming-raspberry-pi-live-webcam
[139]:http://superuser.com/questions/286675/how-to-install-ffmpeg-on-debian
[140]:http://unix.stackexchange.com/questions/242399/why-was-ffmpeg-removed-from-debian
[141]:
[142]:https://nodejs.org/en/download/
[143]:https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04
[144]:https://github.com/creationix/nvm
[145]:
[146]:
[147]:
[148]:
[149]:
[150]:
[151]:
