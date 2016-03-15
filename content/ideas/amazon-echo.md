# Amazon Echo
* [Ask Hackaday: Is Amazon Echo the Future of Home Automation?](http://hackaday.com/2015/04/14/ask-hackaday-is-amazon-echo-the-future-of-home-automation/)
* [Control Nest Devices with Amazon Echo](http://hackaday.com/2015/07/25/control-nest-devices-with-amazon-echo/)
* [Amazon’s AI Escapes its Hardware Prison](http://hackaday.com/2015/08/04/amazons-ai-escapes-its-hardware-prison/)
* [Amazon Echo: Automate tasks with a talking Raspberry Pi](http://liliputing.com/2015/07/amazon-echo-automate-tasks-with-a-talking-raspberry-pi.html)

# Amazon Alexa Voice Services
* [Let Alexa Control Your Life; Guide to Voice-Enable Everything](http://hackaday.com/2015/12/26/let-alexa-control-your-life-guide-to-voice-enable-everything/)
* [Alexa Skills Kit (ASK)](https://developer.amazon.com/public)
*[Alexa Voice Service (AVS)](https://developer.amazon.com/public/solutions/alexa/alexa-voice-service)
* [Alexa Lambda Linux (ALL) Reference Design](https://github.com/goruck/all)
* [New Alexa Skills Kit Template: Build a Trivia Skill in under an Hour](https://developer.amazon.com/public/community/post/TxDJWS16KUPVKO/New-Alexa-Skills-Kit-Template-Build-a-Trivia-Skill-in-under-an-Hour?mkt_tok=3RkMMJWWfF9wsRokvqjLZKXonjHpfsX66e4vWKK2lMI%2F0ER3fOvrPUfGjI4CSsNnI%2BSLDwEYGJlv6SgFSrfFMapt17gOUhk%3D)
* [Introduction to Voice Design with Amazon's Alexa](https://www.udemy.com/amazonalexa/?mkt_tok=3RkMMJWWfF9wsRokvqjLZKXonjHpfsX66e4vWKK2lMI%2F0ER3fOvrPUfGjI4CSsNnI%2BSLDwEYGJlv6SgFSrfFMapt17gOUhk%3D)

# Role-Your-Own Echo
* [Voice Command with No Echo](http://hackaday.com/2015/08/30/voice-command-with-no-echo/)
* [Speech Recognition with Arduino and BitVoicer Server](https://www.hackster.io/msb4180/speech-recognition-with-arduino-and-bitvoicer-server-460477?ref=newsletter&utm_source=Hackster.io+newsletter&utm_campaign=251e92bd71-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-251e92bd71-140225889)
* [myva-Home (Voice controlled home automation)](https://www.hackster.io/smerkousdavid/myva-home-voice-controlled-home-automation-f4cfe3?utm_source=Hackster.io+newsletter&utm_campaign=73ff92e8f5-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-73ff92e8f5-140225889)
* [Build a Raspberry Pi-Powered DIY Amazon Echo](http://lifehacker.com/build-a-raspberry-pi-powered-diy-amazon-echo-1762678229)

# Mycroft
* [Awesome Stuff: A Voice-Operated Household Assistant](https://www.techdirt.com/blog/innovation/articles/20150829/07551832101/awesome-stuff-voice-operated-household-assistant.shtml)
* [Mycroft: An Open Source Artificial Intelligence For Everyone](https://www.kickstarter.com/projects/aiforeveryone/mycroft-an-open-source-artificial-intelligence-for?ref=card)
* [Mycroft: A.I. for everyone](https://mycroft.ai/)

# AT&T Speech API
<a href="https://developer.att.com/">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="AT&T Developer Web Site" alt="AT&T Developer Logo" src="/images/att-developer-logo.png" width="100" height="100" />
</a>
This code was inspired by the [Jasper Project][53]
and [Amazon's Echo][58].
Jasper, an open-source, crowd developed, [Siri-like][54] virtual assistant for Raspberry Pi.
The concept is to have an always-on system constantly waiting for
voice commands that you can hack together to use in your home.
The Jasper Project anticipates contribution form carry out
any kind of automated task you can think of using voice commands,
such as reading you news headlines, sending commands for home automation, etc.

In it's current implementation, Jasper uses a Linux based text-to-speech and speech-to-text package.
It has been [recommended to use a web-based API instead][55],
specifically the [AT&T Speech API][56].
This API is being used by [Jibbigo][57], a smart phone language translation app.
The API is well documented, requires your registration for an API key, but free for limited use.
The main limitation with this free Speech API is its rate limit,
but it's very difficult to run up to the limit for most applications.
You're limited to 1 request per second and your audio file must be less than a minute in length.

Here I'm going to exercise the AT&T Speech API outside of Jasper just to demonstrate its use.
With a little imagination, you should see how it can turn a Raspberry Pi into an
interesting Internet-enabled speech application using this API.



[53]:http://jasperproject.github.io/
[54]:http://www.apple.com/ios/siri/
[55]:http://changingjasper.blogspot.com/2014/06/making-jasper-use-at-speech-api.html
[56]:http://developer.att.com/apis/speech
[57]:http://jibbigo.com/
[58]:http://hackaday.com/2015/08/04/amazons-ai-escapes-its-hardware-prison/
