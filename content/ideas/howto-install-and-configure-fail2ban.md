Recently I examined my desktop computer's `sshd` log file `/var/log/auth.log`
([log samples from sshd][01]) looking for failed login attempts
I saw a list of well over 100 attempts, from mainly one IP (125.88.177.90 - Guangdong, China),
trying to login via SSH as root or bin user.

```bash
# attacks on just port 22
$ cat /var/log/auth.log | grep 'sshd.*Failed' | grep 'port 22' | wc
    171    2814   18950

# attacks on any port
$ cat /var/log/auth.log | grep 'sshd.*Failed' | wc
  11066  182457 1229596
```

I also noticed that the attacher is attempting to use multiple originating ports in an effort
to subvert delays required between multiple logins (see this [article][02]).
I decided it was time to pay a little bit more attention to security!

The article "[Keeping SSH Access Secure][41]" provides some good suggestions.
One method, not referenced in this article, is how you could
rate-limit `iptables` rules to address this issue (from this [source][03]:

```bash
# block connections if the login fails 10 times in 1 hour on port 22
iptables -I INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
iptables -I INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 3600 --hitcount 10 -j DROP
```

This blocks connections if the login fails ten times in one hour on port 22.

Another easy answer would be to limit `ssh` access from wlan interface only.
This works if you have no plans to `ssh` into your device from the Internet,
effectively cuts out the attacks from the Internet.
But of course, if your neighbors nerdy 13 year old wants to mess with your WiFi,
you still could have some attacks.

So its just a matter of time before the attack is on another port, or user account, or network interface,
therefore using [Fail2Ban][04] or something similar may be in order.
`fail2ban` reads the `sshd` log entries (and other log files)
and bans the originating address when there are too many failures.
Generally Fail2Ban is then used to update firewall rules to reject
the IP addresses for a specified amount of time, although any arbitrary other action
(e.g. sending an email) could also be configured.
Out of the box Fail2Ban comes with filters for various services (apache, courier, ssh, etc).

While Fail2Ban does provide additional protection, the use of two factor authentication
(see "[HowToxxx][]")
or public/private key authentication mechanisms
(see "[HowToxxx][]")
provide the best protection overall.

# Step 0: Getting to Know iptables
* http://www.thegeekstuff.com/2011/01/iptables-fundamentals/
* https://help.ubuntu.com/community/IptablesHowTo
* https://www.garron.me/en/linux/iptables-manual.html
* http://www.karlrupp.net/en/computer/nat_tutorial
* http://www.slashroot.in/linux-iptables-firewall-tutorial-getting-started-basics

# Step 1: Install Fail2Ban
We will be installing a daemon called `fail2ban` that scans log files
and automatically bans suspicious IP address with `iptables`.
Install `fail2ban` with the following command:

```bash
sudo apt-get install fail2ban

sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

You can use `fail2ban` with any service that makes log files like Apache, FTP, etc.
The configuration for different services can be found in `/etc/fail2ban/jail.conf`.
The default configuration only monitors SSH and bans the suspicious IP
after 6 unsuccessful attempts for 600 seconds.
You can change this settings by adding appropriate lines in `/etc/fail2ban/jail.local`.
For example, I want to permamently ban the suspicious IP address after only 2 attempts.
Apart from that, I want to ban access for this IP on all ports,
so I changed default banaction to iptables-allports.
So, part of my `jail.local` file looks like this:

```bash
[ssh]
banaction = iptables-allports
bantime = -1
maxretry = 2
```

However, you'll soon realized that all IP bans disappear from `iptables` after reboot.
To deal with this issue,
added the following line to my `/etc/fail2ban/action.d/iptables-allports.conf`
file to the `actionstart`:

```bash
cat /etc/fail2ban/ip.list-<name> | while read IP; do iptables -I fail2ban-<name> 1 -s $IP -j DROP; done
```
and following line to the `actionban`

```bash
echo '<ip>/24' >> /etc/fail2ban/ip.list-<name>
```

These commands log the banned IP addresses to the `/etc/fail2ban/ip.list` file,
and after restart, the contest of this file is added to the `iptables`.
IP address are stored in `ip.list` file with suffix `/24`.
In that way `iptables` will block the whole range from xxx.xxx.xxx.0 to xxx.xxx.xxx.255.

When you did the necessary updates of the config files, make sure to restart service:

```bash
sudo service fail2ban restart
```

and check current bans with:

```bash
sudo iptables -L -n --line
```

# Step 2: Configure Fail2Ban

* [Install and configure fail2ban](http://iot-projects.com/index.php?id=make-your-raspberry-pi-more-secure)
* [Install and Config Fail2Ban in Debian 7 Wheezy](http://www.pontikis.net/blog/fail2ban-install-config-debian-wheezy)
* [How Fail2Ban Works to Protect Services on a Linux Server](https://www.digitalocean.com/community/tutorials/how-fail2ban-works-to-protect-services-on-a-linux-server)
* [How To Protect SSH with Fail2Ban on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-ubuntu-14-04)
* [How to protect SSH with fail2ban](https://kyup.com/tutorials/protect-ssh-fail2ban/)
* [Preventing Brute Force Attacks With Fail2ban On Debian Etch](https://www.howtoforge.com/fail2ban_debian_etch)
* [Using Fail2ban to Secure Your Server](https://www.linode.com/docs/security/using-fail2ban-for-security)
* [Fail2ban is not blocking IPs trying to access my server via ssh](http://unix.stackexchange.com/questions/204383/fail2ban-is-not-blocking-ips-trying-to-access-my-server-via-ssh/204393#204393)



[01]:http://ossec-docs.readthedocs.org/en/latest/log_samples/auth/sshd.html
[02]:http://security.stackexchange.com/questions/67602/closely-spaced-failed-logins-in-auth-log
[03]:https://www.debian-administration.org/article/187/Using_iptables_to_rate-limit_incoming_connections
[04]:
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:
