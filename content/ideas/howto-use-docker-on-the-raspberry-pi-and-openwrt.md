
* [Docker OpenWRT Image](https://wiki.openwrt.org/doc/howto/docker_openwrt_image)
* [Building OpenWRT With Docker](https://noah.meyerhans.us/blog/2015/03/19/building-openwrt-with-docker/)

* [Using Docker on the Raspberry Pi](http://www.instructables.com/id/Using-Docker-on-the-Raspberry-Pi/?ALLSTEPS)
* [Experimenting with Docker on a Raspberry Pi](https://opensource.com/life/15/9/experimenting-docker-raspberry-pi)
* [Docker On A Raspberry Pi](http://blog.xebia.com/docker-on-a-raspberry-pi/)
* [Get Docker up and running on the RaspberryPi (ARMv6) in four steps](https://github.com/umiddelb/armhf/wiki/Get-Docker-up-and-running-on-the-RaspberryPi-(ARMv6)-in-four-steps-(Wheezy))
* [Docker on Raspberry Pi](https://stefanscherer.github.io/docker-on-raspberry-pi/)
* [Run docker on raspberry pi and openwrt](https://zhihuicao.wordpress.com/2015/10/17/run-docker-on-raspberry-pi-and-openwrt/)
* [Using Docker to run Node.js on a Raspberry Pi](https://opensource.com/life/15/9/experimenting-docker-raspberry-pi)

# Docker ToolBox
* [Docker ToolBox](https://www.docker.com/products/docker-toolbox)
* [Run containers through a simple, yet powerful graphical user interface](https://kitematic.com/)

# HypriotOS
* [Getting started with Docker on your Raspberry Pi · Docker Pirates ARMed with explosive stuff](http://blog.hypriot.com/getting-started-with-docker-on-your-arm-device/)
* [Run Docker on a Raspberry Pi 3 with onboard WiFi](http://blog.hypriot.com/post/run-docker-rpi3-with-wifi/)
* [Get your all-in-one Docker playground now: HypriotOS reloaded!](http://blog.hypriot.com/post/get-your-all-in-one-docker-playground-now-hypriotos-reloaded/)
* [Introducing Hypriot Cluster Lab: Docker clustering as easy as it gets](http://blog.hypriot.com/post/introducing-hypriot-cluster-lab-docker-clustering-as-easy-as-it-gets/)
* [How to setup a Docker Swarm cluster with Raspberry Pi's](http://blog.hypriot.com/post/how-to-setup-rpi-docker-swarm/)

* [Install Open vSwitch on Raspberry Pi](https://sdntestbed.wordpress.com/2015/07/03/install-open-vswitch-on-raspberry-pi/)


While creating my my mesh network,
I needed to create several identical mesh device
on the Raspberry Pi / Raspbian and  [GL-MT300N][12] / OpenWRT platforms.
I wanted to simplify the task of both initially establishing the devices and
simplify their subsequent updates.
I'm looking for a container to store the entire runtime environment:
an application, plus all its dependencies, libraries and other binaries,
and configuration files needed to run it, bundled into one package
and easily install them into my hardware devices.

<a href="https://www.docker.com/what-docker">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="Docker containers wrap up a piece of software in a complete filesystem that contains everything it needs to run: code, runtime, system tools, system libraries – anything you can install on a server. This guarantees that it will always run the same, regardless of the environment it is running in." alt="docker-logo" src="{filename}/images/docker-logo.png" width="400" height="331" />
</a>
[Docker][01] allows you to do just this by
packaging an application, with all of its dependencies,
into a standardized unit for software deployment.
With Docker, you can build any application in any language using any toolchain.
“Dockerized” applications are completely portable and can run anywhere.
A dockerized application contains the application,
its environment, dependencies and even the Operating System.

So with a dockerized application,
you can develop and test the application your
target envornments of Raspberry Pi or OpenWrt.
When it works, you can deploy it to the multiple Raspberry Pi or OpenWrt platforms.
We can do this without any pain or worries about corruption
of the underlying operating system and tools that may already exit on those target devices.
And last but not least, you can easily undo your tryouts.

In addition, there are a bunch of ready-to-use docker-images
already establish for the Raspberry Pi and OpenWRT.
For example, to run dockerized applications on the Raspberry Pi,
you are depending on the base images, which in this case, supports the ARM-architecture.
On this, you can load additiona docker-images,
which may load other applications.

<a href="https://linuxcontainers.org/">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="linuxcontainers.org is the umbrella project behind LXC, LXD, LXCFS and CGManager.  The goal is to offer a distro and vendor neutral environment for the development of Linux container technologies.  Containers which offer an environment as close to possible as the one you'd get from a VM but without the overhead that comes with running a separate kernel and simulating all the hardware." alt="LinuxContainers.org-logo" src="{filename}/images/linuxcontainers-logo.png" width="318" height="293" />
</a>
Docker is one of several popular container management packages, for example
Google's [Kubernetes][02] and
[Amazon EC2 Container Service][18].
Container technology is not new and been built in to Linux in the form of [LXC][06].
In fact, some Linux distributions have cropped up which have been
designed [specifically for running containers][07].
Some examples
include CoreOS [Rocket][10],
Red Hat's [Project Atomic][09],
Canonical's [Snappy Ubuntu][08].

# Get Started with Docker Engine
Docker's documentation contains a good [introduction installing and using the Docker Engine][11].

# Docker Hub
The [Docker Hub][03] is a cloud-based registry service for
building and distributing your docker-images.
It provides a centralized resource for docker image discovery,
distribution and change management, user and team collaboration,
and workflow automation.
You can get an overview of Docker Hub [here][04]
on [Docker's documentation site][05].

# HypriotOS
Prior to 2015, Docker was not easily available for ARM-based devices
but the folks at [Hypriot][13] have made [Docker on the RPi][14] easy.
Hypriot built and released their own OS image, HypriotOS,
to run the Docker Engine on th RPi.
They support most of the Docker tools besides the Docker Engine,
including of [Docker Compose][15], [Docker Swarm][16], and [Docker Machine][17].
A user can download this pre-compiled Raspbian based SD Card image,
which includes a Linux kernel with all Docker related kernel options included.
Just download, extract, flash to a SD Card, and boot your Raspberry Pi.
Within minutes you have Docker up and running and you can instantly start using it.



[01]:https://www.docker.com/
[02]:http://kubernetes.io/
[03]:https://hub.docker.com/
[04]:https://docs.docker.com/docker-hub/overview/
[05]:https://docs.docker.com/
[06]:https://linuxcontainers.org/
[07]:http://www.cio.com/article/2918400/data-center/do-you-need-a-container-specific-linux-distribution.html
[08]:https://developer.ubuntu.com/en/snappy/
[09]:http://www.projectatomic.io/
[10]:https://coreos.com/blog/rocket/
[11]:https://docs.docker.com/linux/
[12]:http://www.gl-inet.com/mt300n/
[13]:http://blog.hypriot.com/
[14]:http://blog.hypriot.com/post/get-your-all-in-one-docker-playground-now-hypriotos-reloaded/
[15]:https://docs.docker.com/compose/
[16]:https://docs.docker.com/swarm/
[17]:https://docs.docker.com/machine/
[18]:https://aws.amazon.com/ecs/
[19]:
[20]:
[21]:
[22]:
[23]:
[24]:
[25]:
[26]:
[27]:
[28]:
[29]:
[30]:
