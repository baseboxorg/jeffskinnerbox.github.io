Google has declared a new strategy, calling it "[AI First][28]".
In this spirit, Google wants to put AI into the maker toolkit,
and to kick this off,
they have created the [do-it-yourself artificial intelligence, or AIY program][10].

# Google AIY Vision Kit
* [AIY PROJECTS: VISION KIT: BUILD YOUR OWN INTELLIGENT CAMERA](https://www.raspberrypi.org/magpi/aiy-projects-vision-kit/)
* [Google AIY Vision Kit - Order from Micro Center](http://www.microcenter.com/product/501552/AIY_Vision_Kit)
* [Google offers Raspberry Pi owners this new AI vision kit to spot cats, people, emotions](http://www.zdnet.com/article/google-offers-raspberry-pi-owners-this-new-ai-vision-kit-to-spot-cats-people-emotions/)

# Google AIY Voice Kit

## Google Assistant
![google-assistant-logo](https://upload.wikimedia.org/wikipedia/commons/5/5a/Google_Assistant_logo.png)
[Google Home][12] enables users to speak voice commands to interact with [Google Assistant][13].
Google Assistant is an intelligent personal assistant.
Google Home is Google's response to Amazon's Echo,
and the Google Assistant is its alternative to Amazon's Alexa.
Google Assistant launched on Google Home and [Google Pixel smartphones][18]
but not (as of this writing) offered on Andriod or other smartphones.
[Google has confirmed it will begin rolling out an Assistant][19]
the week of 26 February 2017 for Android 7.0 Nougat and 6.0 Marshmallow phones.
[To check if your phone has Google Assistant][23], say "Ok Google", "Hey, Google",
or press-and-hold the home button
([but has some problems for Samsung users like myself][21]).

Alexa's abilities, in large part, is based on the skills that you or someone else program into it,
and if the skills are not present, your likely to get the "I don't understand the question" response.
Google Assistant on the other hand has the Google search engine at its disposal,
and therefore, you can ask Assistant almost anything,
and it will understand your words in context and serve up relevant results in a conversational manner.
Google Assistant also has it equivalent to Amazon's Alexa Skills, call [Conversation Actions][24].
Which is better, Amazon Echo with Alexa vs. Google Home with Assistant,
is a subject of much debate (see [here][14], [here][17], [here][25], [here][26], and [here][23]).

One of the nicer things about Google Assistant
is that it is [designed to be conversational][20].
That is, you ask a question and then ask several follow-up questions,
and Google Assistant will be able to keep track of the conversation, determine context,
and audibly respond with the right information.
You do need to preface each with the "OK Google" or "Hey, Google" wake-up.
Like Echo Alexa (see [Alexa dialog history][16]),
Google also allows you to peek at all the data Home sends back and forth
(go to [`myactivity.google.com`][15]).

With Google Assistant on you smartphone,
find stuff while you're traveling,
make phone calls or text messages or email,
open phone apps, and [more][20].


* [Google AIY: Artificial Intelligence Yourself](http://hackaday.com/2017/05/04/google-aiy-artificial-intelligence-yourself/)
* [How to Build Your Own Google AIY without the Kit](http://hackaday.com/2017/05/30/diy-google-aiy/)
* [Headless Voice Activated Google Assistant on Raspberry Pi](https://www.hackster.io/shiva-siddharth/headless-voice-activated-google-assistant-on-raspberry-pi-8343f7?utm_source=Hackster.io+newsletter&utm_campaign=01e267dfa3-EMAIL_CAMPAIGN_2017_05_03&utm_medium=email&utm_term=0_6ff81e3e5b-01e267dfa3-140225889&mc_cid=01e267dfa3&mc_eid=9036129d51)
* [Sudo Google Assistant](http://hackaday.com/2017/05/16/sudo-google-assistant/)
* [ReSpeaker 2 Mics Pi HAT for Alexa Voice Service, Google Assistant](https://www.seeedstudio.com/ReSpeaker-2-Mics-Pi-HAT-p-2874.html?utm_source=mailchimp&utm_medium=edm&utm_campaign=new_0606)

## Step 1: Voice Kit Physical Assemble - DONE
Follow the [AIY Projects][03] website's instructions for
physically assembling the [Google Assistant Voice Kit][01] or
you can [checkout this video][07] for some detail help.

## Step 2: Install Operating System - DONE
Next we have to install the operating system image for this hardware kit.
Google provides a [pre-configured SD Card image][04] for the kit
(named `aiyprojects-2017-09-11.img` in my case),
but I want to install this solution on my own image.
Google does provide a [guide to add Google Assistant to a standalone Raspberry Pi 3][02]
where provide your own speaker / microphone / button.
What I wish to do is a blend of the two approaches:
I want to use the hardware kit but install the software from the "bring your own hardware" solution.

Close examination of the [AIY Voice Kit Github repository][06],
[Create a Voice Kit with your Raspberry Pi][08],
the [Overview of the Google Assistant Library for Python][02],
the [AIY Voice Kit How-To | Part 2: Google Assistant SDK][05]
and [AIY Voice Kit How-To | Part 3: Cloud Speech API][09] videos
all gives you the insight you need to know.
The key instructions to follow can be found [here][11].

On my first try, I did attempt to us my own image but not all the features worked.
I assume something was on the Google provided image that I didn't pickup.
So instead I used Google's Voice Kit image, got the kit working,
and then added my additional packages on top of that.

I want to do all this via a headless configuration,
so I did the following to the Google's Voice Kit image first before booting it:

1. Mount the SD Card on my computer.
1. Edited the Network Interfaces and WPA Supplicant file so they include my home network information.
1. Edit the `hostname` file to include my desired host name.
1. Enables SSH so I could terminal session into the device on first boot up.
1. Unmounted the SD Card, installed it on the Raspberry Pi and then booted the RPi.
1. `ssh -X` into your Raspberry Pi and follow the procedures below.

To find the IP address of you Raspberry Pi,
ping sweep before and after the device is placed on the network
and you'll see the new address appear.
You can use this script to do this:

```bash
# ping sweep without nmap
# waits for all pings to complete and returns ip with mac address
(prefix="192.168.1" && for i in `seq 254`; do (sleep 0.5 && ping -c1 -w1 $prefix.$i &> /dev/null && arp -n | awk ' /'$prefix'.'$i' / { print $1 "\t" $3 } ') & done; wait)
```

Once you SSH login into the RPi,
run this command to assure you can SSH in on future login attempts:

```bash
# enable ssh for future logins
sudo raspi-config nonint do_ssh 0
```

## Step 3: Test Voice Kit Software - DONE
The [Voice Kit github software][06]
contains the required drivers to use with the special speaker and microphone hardware,
along with some testing and install tools.
This software should already be installed on the image you downloaded.

The documented process for checking out the Voice Kit involes the graphics UI
but I'll be doing everything all the steps via the commandline.
The [video][05] show how the graphical UI install goes
and I'll be following that pattern for the commandline install.
Use `find /home/pi -name <file-name>` to locate any of the tools used here.

Now lets check if the above setup was properly done.
Run the following scripts:

```bash
# run the audio test
/home/pi/AIY-voice-kit-python/checkpoints/check_audio.py
```

## Step 4: Configure a Google Developer Project - DONE
Next we setup a Google Developer Project which
will give us access to the Google Assistant API.
Using your Google Assistant device,
open up an Internet browser and go to the [Cloud Console][22]
and follow these [instructions][27].

From the project credentials screen
(`https://console.cloud.google.com/apis/credentials?project=marine-alchemy-186203` in my case),
I downloaded the JSON file containing the client secret
I place it in `/home/pi/assistant.json`.

## Step 5: Turn It On for the First Time - DONE
For the device to begin acting as your Google Assistant, much like Google Home,
there is a demo app.
We'll do some convoluted steps here to pattern our commandline activity
like the graphical UI approach documented for the Voice Kit.

```bash
# run the dev_terminal
/home/pi/bin/AIY-voice-kit-shell.sh

# once the terminal starts, run this
src/assistant_library_demo.py
```

At this point, a Chromium browser will popup.
You need to grant the Voice Kit access to your Google Assistant service.
Just add your login, password, and provide access.

With the access provide, your assistant is operational.
The assistant library app has hotword detection built-in
and is used to initialize your device for the first time.
To start a conversation with the Google Assistant,
say "Okay, Google" or "Hey Google".

When you are done, press Ctrl-C to end the application.
You still be in the dev_terminal at this point and you'll
need to enter `exit` to terminate the dev_terminal.

## Step 6: Testing The Button - DONE
The button on top of the Voice Kit can also be talk with Google Assistant.
Test this out with the following:

```bash
# run the dev_terminal
/home/pi/bin/AIY-voice-kit-shell.sh

# run the button command test
src/assistant_grpc_demo.py
```

Now press the button and ask a question.

## Step 7: Setup the Cloud Speech API - DONE
The Cloud Speech API allows you to control device,
such as the LED button on the Voice Kit, via voice control.
There is a fee for this, after the first 60 minutes of use.
Instructions on setting this up can be found [here][09],
but I didn't bother.
I'll come back to this when the day comes I wish to voice control something via Google.
In any event, the setup is virtually the same as the Step 4 above
and you can execute the script below to test it out.

```bash
# run the dev_terminal
/home/pi/bin/AIY-voice-kit-shell.sh

# run the button command test
src/cloud_speech_demo.py
```
## Step X: Adjust the Playback and Recording Volume

alsamixer

https://developers.google.com/assistant/sdk/develop/grpc/hardware/audio

## Step X: Run Examples
https://developers.google.com/assistant/sdk/develop/python/run-sample

## Step X:Customize Interacts with the Assistant
https://developers.google.com/assistant/sdk/develop/python/next-steps

## Step X:
client id = 139747328702-2e9ds7bfisdjmu2f0o5qe3hkimnel1sl.apps.googleusercontent.com
client secret = 0Rq9gpxlVy9frYQDtUeuwiw-



[01]:https://aiyprojects.withgoogle.com/voice
[02]:https://developers.google.com/assistant/sdk/develop/python/
[03]:https://aiyprojects.withgoogle.com/
[04]:https://aiyprojects.withgoogle.com/voice#assembly-guide-1-get-the-voice-kit-sd-image
[05]:https://www.youtube.com/watch?v=T94TWUnrZkU
[06]:https://github.com/google/aiyprojects-raspbian
[07]:https://www.youtube.com/watch?v=HER_885yVDM
[08]:https://www.raspberrypi.org/magpi-issues/Essentials_AIY_Projects_Voice_v1.pdf
[09]:https://www.youtube.com/watch?v=kCfkHkl00gg
[10]:https://aiyprojects.withgoogle.com/
[11]:https://github.com/google/aiyprojects-raspbian/blob/master/HACKING.md
[12]:https://madeby.google.com/home/
[13]:https://assistant.google.com/
[14]:http://www.pocket-lint.com/review/139617-google-home-review-a-better-voice-assistant-than-amazon-echo
[15]:https://myactivity.google.com/myactivity
[16]:https://www.amazon.com/gp/help/customer/display.html?nodeId=201602040
[17]:https://www.cnet.com/news/google-home-vs-amazon-echo/
[18]:http://www.pocket-lint.com/review/139038-google-pixel-review-android-at-its-best
[19]:http://www.pocket-lint.com/news/140393-google-assistant-is-coming-to-a-nougat-or-marshmallow-handset-near-you
[20]:http://www.pocket-lint.com/news/137722-what-is-google-assistant-how-does-it-work-and-which-devices-offer-it
[21]:http://trendblog.net/okay-google-not-working-fix/
[22]:https://console.cloud.google.com/home/dashboard
[23]:https://assistant.google.com/platforms/phones/
[24]:https://developers.google.com/actions/develop/conversation
[25]:https://www.forbes.com/sites/jaymcgregor/2016/12/30/amazons-alexa-vs-google-assistant-24-questions-1-winner/#6e43541c2316
[26]:http://1reddrop.com/2017/02/26/amazon-alexa-hits-10000-skills-why-better-google-assistant/
[27]:https://aiyprojects.withgoogle.com/voice#users-guide-1-1--connect-to-google-cloud-platform
[28]:https://www.androidauthority.com/google-ai-first-812335/
[29]:
[30]:

