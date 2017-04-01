
To start, checkout some of the sections with [HowTo: Set-Up the Raspberry Pi as a Headless Device](http://jeffskinnerbox.me/posts/2016/Apr/27/howto-set-up-the-raspberry-pi-as-a-headless-device/).

* [How to secure your Raspberry Pi](https://opensource.com/article/17/3/iot-security-raspberry-pi)
* [Useful Linux Security Tricks To Harden Your System](https://dzone.com/articles/useful-linux-security-tricks-to-harden-your-system?edition=283882&utm_source=weeklydigest&utm_medium=email&utm_campaign=wd2017-03-15)
* [IoT Security: Tips to Protect your Device from Bad Hackers](https://www.hackster.io/charifmahmoudi/iot-security-tips-to-protect-your-device-from-bad-hackers-768093?ref=platform&ref_id=425_trending___&offset=0)
* [“IOT SECURITY” IS AN EMPTY BUZZWORD](http://hackaday.com/2016/06/13/iot-security-is-an-empty-buzzword/)

* [WiFiManager](https://github.com/tzapu/WiFiManager)
* [Is Someone Stealing Your WiFi?](http://askbobrankin.com/is_someone_stealing_your_wifi.html)

* [The Internet Of Things Needs Firewalls Too](http://electronicdesign.com/communications/internet-things-needs-firewalls-too)

# Web TLS/SSL
* [How To Secure Your Rancher Web App with Let's Encrypt on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-secure-your-rancher-web-app-with-let-s-encrypt-on-ubuntu-16-04)

# Reverse SSH Tunnel – when you cannot SSH to your host
You may be in a restricted network situation (company, hotel, hospital)
where you have a "server" which you want to access from outside that network.
You cannot forward ports to access that machine,
but you can ssh to the outside (to your own server).
You'll need another server to which you setup a persistent ssh connection with a reverse tunnel.
Then if you need to access the machine you ssh into the other server,
and from there you ssh through the tunnel to the restriced machine.
(Make sure you have permission to do this from the administrators.
They generally don't like holes in the firewall/security.)

The down-side of SSH is that by itself it cannot maintain a persistent connection
— network issues may force the tunnel to stop responding, or even drop completely.
Autossh is a small front-end for SSH that can monitor the connection,
and restart the tunnel if it drops or stops responding.

* [Reverse SSH Tunnel – when you cannot SSH to your host](http://home.oraculo.pt/2017/03/21/reverse-ssh-tunnel/)
* [Keeping your SSH connections alive with autossh](https://www.linux.com/news/keeping-your-ssh-connections-alive-autossh)
* [SSH TUNNELLING FOR FUN AND PROFIT: AUTOSSH](https://www.everythingcli.org/ssh-tunnelling-for-fun-and-profit-autossh/)
* [Persistent reverse (NAT bypassing) SSH tunnel access with autossh](https://raymii.org/s/tutorials/Autossh_persistent_tunnels.html)
* [Creating a persistent ssh tunnel in Ubuntu](https://erik.torgesta.com/2013/12/creating-a-persistent-ssh-tunnel-in-ubuntu/)
* [Autossh Startup Script for Multiple Tunnels](https://surniaulula.com/2012/12/10/autossh-startup-script-for-multiple-tunnels/)

## Step X: Streaming Camera to the Internet - DONE
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



[110]:https://www.theodo.fr/blog/2016/06/expose-your-local-environment-to-the-world-with-ngrok/
[111]:https://www.sitepoint.com/accessing-localhost-from-anywhere/
[112]:https://en.wikipedia.org/wiki/Tunneling_protocol
[113]:https://ngrok.com/docs/2
[114]:https://dashboard.ngrok.com/get-started
[115]:https://en.wikipedia.org/wiki/Reverse_proxy

