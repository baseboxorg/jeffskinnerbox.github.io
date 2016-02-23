
* [How To Configure SSH Key-Based Authentication on a Linux Server](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server)
* [HowTo: Setup SSH Keys on a Linux / Unix System](http://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-linux-unix/)
* [How to configure ssh server in Linux](http://computernetworkingnotes.com/network-administrations/ssh.html)
* [SSH Tutorial for Linux](http://support.suso.com/supki/SSH_Tutorial_for_Linux)
* [Deploying SSH Keys for Passwordless Authentication](http://www.edcint.co.nz/misc/sshkeys.html)
* [Troubleshooting SSH Connections](http://www.unixlore.net/articles/troubleshooting-ssh-connections.html)
* [Five Minutes to a More Secure SSH](http://www.unixlore.net/articles/five-minutes-to-more-secure-ssh.html)
* [Five Minutes to an Even More Secure SSH](http://www.unixlore.net/articles/five-minutes-to-even-more-secure-ssh.html)
* [SSH, The Secure Shell: The Definitive Guide](http://docstore.mik.ua/orelly/networking_2ndEd/ssh/index.htm)
* [Troubleshooting SSH Connections](https://www.racf.bnl.gov/docs/authentication/ssh/sshtroubleshooting)
* [Troubleshooting X11 Sessions](https://www.racf.bnl.gov/docs/authentication/ssh/x11troubleshooting)
* [SSH/OpenSSH/Keys](https://help.ubuntu.com/community/SSH/OpenSSH/Keys)
* [How To Set Up Sudo and SSH Keys on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/video-how-to-set-up-sudo-and-ssh-keys-on-ubuntu-14-04)
* [How to set up SSH keys](https://kyup.com/tutorials/set-ssh-keys/)

Public key authentication is more secure than password authentication.
This is particularly important if the computer is visible on the internet.
With public key authentication, the authenticating entity has a public key and a private key.
Each key is a large number with special mathematical properties.
The private key is kept on the computer you log in from,
while the public key is stored on the `.ssh/authorized_keys` file on all the computers you want to log in to.
When you log in to a computer,
the SSH server uses the public key to "lock" messages in a way that can only be
"unlocked" by your private key.
This means that even the most resourceful attacker can't snoop on,
or interfere with, your session.
As an extra security measure, most SSH programs store the private key in apassphrase-protected format,
so that if your computer is stolen or broken in to,
you should have enough time to disable your old public key
before they break the passphrase and start using your key.
Wikipedia has a more detailed explanation of how keys work.

Public key authentication is a much better solution than passwords for most people. In fact, if you don't mind leaving a private key unprotected on your hard disk, you can even use keys to do secure automatic log-ins - as part of a network backup, for example.

# Logging on the Client
Use the “-v” parameter to ssh will provide some output as to what is wrong.
In fact, you can maximize the debugging messages with “-vvv”.
So, you can see what’s going on, you can do something like this:

```bash
ssh -vvv remoteuser@remotecomputer
```

# Trouble Shooting
There are many things that can stop SSH from working.
Generally problems with SSH connections fall into two groups - network related and server related.

ERROR
:   ssh: connect to host ServerX port 22: No route to host
SOLUTION
:   The server exists in DNS and either there is no routing for it or its turned off
    or disconnected from the network.
    Turn it on, connect it etc.
