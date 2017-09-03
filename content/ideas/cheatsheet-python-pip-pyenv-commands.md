
* [A Modern Python Development Toolchain](http://www.chriskrycho.com/2015/a-modern-python-development-toolchain.html)
* [Python Virtual Environments - a Primer](https://realpython.com/blog/python/python-virtual-environments-a-primer/)
* [What is the relationship between virtualenv and pyenv?](http://stackoverflow.com/questions/29950300/what-is-the-relationship-between-virtualenv-and-pyenv)
* [Managing Multiple Python Versions with pyenv](http://akbaribrahim.com/managing-multiple-python-versions-with-pyenv/)
* [Easy Twisted Development With Virtualenv And Pyenv](https://derwolfe.net/2014/10/19/twisted-pyenv-virtualenv/)
* Python Working Environment for Beginners: [Part 1](https://www.thoughtworks.com/insights/blog/python-working-environment-beginners-part-1)
[Part 2](https://www.thoughtworks.com/insights/blog/python-working-environment-beginners-part-2)
* [Working with Python's 3rd Party Libraries the Right Way](https://ewilazarus.github.io/working-with-pythons-3rd-party-libraries-the-right-way.html)


* [USING PYENV WITH VIRTUALENV AND PIP CHEAT SHEET](https://fijiaaron.wordpress.com/2015/06/18/using-pyenv-with-virtualenv-and-pip-cheat-sheet/)
* [pyenv Tutorial](https://amaral.northwestern.edu/resources/guides/pyenv-tutorial)


* [pyvenv vs venv vs python-virtualenv vs virtualenv and python 3](http://askubuntu.com/questions/603935/pyvenv-vs-venv-vs-python-virtualenv-vs-virtualenv-and-python-3)
* [Using a virtual environment with Python 3.4](https://robinwinslow.uk/2013/12/26/python-3-4-virtual-environment/)
* [Setting up virtualenvwrapper with pyenv using pyenv-virtualenvwrapper](https://blog.shichao.io/2014/10/01/setup_virtualenvwrapper_with_pyenv_using_pyenv_virtualenvwrapper.html)






**The Goal** - Create isolated development environments that target different python interpreters and require different dependencies.

**The Problem** - When using python to develop a project, it is very easy to accidentally install packages that can be found by your system python. This is a problem because it makes it difficult to isolate dependencies on a per project basis. A better approach is to create isolated environments in which dependencies can be installed.

**The Solution** - Virtual environments (and a few other tools) can rescue us from this situation.
From the [official documents][05]:
"A virtual environment (also called a venv) is a Python environment such that the Python interpreter, libraries and scripts installed into it are isolated from those installed in other virtual environments, and (by default) any libraries installed in a “system” Python, i.e. one which is installed as part of your operating system."



[pyenv][03] is a 3rd party tool for switching between multiple versions of Python (e.g. change the global Python version between Python 2 and 3).
Pyenv manages the installation and removal of python interpreters. Instead of needing to manually manipulate your \$PATH to switch to a different interpreter, pyenv allows you to specify which python you would like to use.

pyvenv - a built-in command line tool for creating “virtual environments”. It helps separate packages dependence between projects. Ships with Python from 3.4.

[pyenv-virtualenv][04] allows you to create a virtualenv that will use a specific interpreter.

venv - a built-in API module for creating "virtual environments". Added since Python 3.3.

Python Wheels http://pythonwheels.com/

[virtualenv][01]
is a tool that creates isolated python environments. When using a virtualenv, pip installs dependencies into a location that is only visible to the virtualenv. Virtualenv allows you to test out different versions of libraries without worring about accidentally upgrading a dependency that would affect another project.
With python 2, one needed to install the virtualenv application to be able to use it, in python3 it is baked in to the standard installation. This method m suggests you use doesn’t require you to install virtualenv yourself - https://derwolfe.net/2014/10/19/twisted-pyenv-virtualenv/

[pip documentation](https://pip.pypa.io/en/latest/)

The combination of `pip`, `pyenv`, and virtual environments makes for a very simple,
straightforward process to manage Python environments:

* Install Python versions with `pyenv`.
* Install Python packages with `pip`.
* Set up virtual environments with `pyenv-virtualenv`.

If you stick to those basic rules, Python shouldn’t be any trouble.



# Python 2 or 3?
When choosing a Python interpreter,
the first question is: “Should I choose Python 2 or Python 3”?

1. Most production applications today use Python 2.7,
but will [only receive necessary security updates until 2020][08].
1. Python 3 is ready for the production deployment of applications today,
and it encapsulates both Python 3 and Python 2.

So use Python 3 for new Python applications,
but familiarizing yourself with Python 2.7
and make sure your application can run under Python 2.7 if you can.
It is possible to [write code that works on Python 2.6, 2.7, and Python 3][09].

But you will find differences between the build envirnemtns between Python 2 and 3.
bla bla bla bla

# Managing Python Interpretor
[pyenv][03] lets you easily switch between multiple versions of Python.
Pyenv manages the installation and removal of python interpreters.
Instead of needing to manually manipulate your `$PATH` to switch to a different interpreter,
`pyenv` allows you to specify which python you would like to use.

`pyenv` lets you specify which Python version to use globally (`pyenv global <name>`)
and which version to use in a given directory structure (`pyenv local <name>`).
So if you prefer to use Python 3 in general,
but need to use Python 2 on one project,
you can just navigate to the root of that project and set it:

```bash
$ pyenv global 3.4.3
$ cd path/to/my/project
$ pyenv local 2.7.9
```

This will create a simple plain text file, `.python-version`, whose contents will be just 2.7.9.
For everything under `path/to/my/project`, typing `python` will launch Python 2.7.9,
while typing it outside that folder will launch Python 3.4.3.
(If you want, you can just create the `.python-version`
file yourself manually and give it the name of a version.)
You learn more on how `pyenv` works [here][10].

* [USING PYENV WITH VIRTUALENV AND PIP CHEAT SHEET](https://fijiaaron.wordpress.com/2015/06/18/using-pyenv-with-virtualenv-and-pip-cheat-sheet/)
* [pyenv Tutorial](https://amaral.northwestern.edu/resources/guides/pyenv-tutorial)

# Managing Python Packages
There are four basic approaches to managing Python packages:

* installing them manually
* using a system-level package manager like homebrew, yum, or aptitude
* using easy_install
* using pip

The vast majority of the time, the right choice is using pip
(See "[Why use pip over easy_install?][06]").

# pip
You should use `pip` and not `easy_install`.
This is because `pip`

* Packages are downloaded before installation.
Partially-completed installation doesn’t occur as a result.
* Care is taken to present useful output on the console.
the reasons for actions are kept track of.
* If a package is being installed, pip keeps track of why that
package was required.
* Error messages should be useful.

```bash
# installing a package globally for all users
sudo pip install <package>

# installing a package only local user
pip install --user <package>

# upgrade a package
pip install -upgrade <package>

# remove a package
pip uninstall <package>

# search PyPi for package
$ pip search esptool pywhereis
esptool (1.3)    - A utility to communicate with the ROM bootloader in
                   Espressif ESP8266.
pywhereis (0.3)  - Unix whereis-like python script and package to find the
                   source file of python object (package, module, function,
                   class ...).
  INSTALLED: 0.3 (latest)
```

* The `--upgrade` option tells `pip` to upgrade a package if already installed.
* The `--user` option tells `pip` to install the program to a subdirectory
of your user directory (`~/.local`) to avoid modifying libraries used by your operating sytem.

# Virtual Environments
Python has its own way of downloading, storing, and resolving packages (or modules).
Python makes decisions made about package storage and resolution,
which can lead to some problems on which packages are are pulled into your code.

At its core, the main purpose of Python virtual environments
is to create an isolated environment for Python projects.
This means that each project can have its own dependencies,
regardless of what dependencies every other project has.

http://python-guide-pt-br.readthedocs.io/en/latest/dev/virtualenvs/

[virtualenvwrapper][02]
venv

# Python 2
bla bla bla bla

## Setting Up Python 2
Ubuntu 16.04 ships with both Python 3 and Python 2 pre-installed.
To see what specific versions you have:

```bash
# check the version of pyhton 2
$ python2 --version
Python 2.7.12

# check the version of pyhton 3
$ python3 --version
Python 3.5.2
```

## Virtual Environment for Python 2
You can set up as many Python programming virtual environments as you want.
Each environment is basically a directory on your computer
that has a few scripts in it to make it act as an environment.

# Python 3
Python 3 is the most current version of the language and is considered to be the future of Python.
bla bla bla bla

## Setting Up Python 3
Ubuntu 16.04 ships with both Python 3 and Python 2 pre-installed.
To make sure that our versions are up-to-date, let’s update and upgrade the system

```bash
# update linux
sudo apt-get update
sudo apt-get upgrade

# check the version of Python 3 that is installed
$ python3 -V
Python 3.5.2

# to manage software packages for python 3, let’s install pip
sudo apt-get install -y python3-pip

# to ensure a robust programming environment
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
```

## Virtual Environment for Python 3
You can set up as many Python programming virtual environments as you want.
Each environment is basically a directory on your computer
that has a few scripts in it to make it act as an environment.
We need to first install the `venv` module,
part of the standard Python 3 library,
so that we can invoke the `pyvenv` command which will create virtual environments.

```bash
# install python 3 virtual env tool
sudo apt-get install python3-venv
```

With this installed, we are ready to create environments.
Let’s choose which directory we would like to put our Python programming environments in,
create the virtual environment,

```bash
# enter your working directory
cd ~/tmp

# create your virtual environment called my_env
pyvenv my_env

# see what has been created
$ ls my_env
bin  include  lib  lib64  pyvenv.cfg  share
```

Together, these files work to make sure that your projects
are isolated from the broader context of your local machine,
so that system files and project files don’t mix.
This is good practice for version control and to ensure that each of your projects
has access to the particular packages that it needs (including `wheels`).

To use this environment, you need to activate it,
which you can do by typing the following command that calls the activate script:

```bash
# activate your virtual environment
source ~/tmp/my_env/bin/activate
```

To leave the environment,
simply type the command `deactivate` and you will return to your original directory.

Your Linux terminal prompt will now be prefixed with the name of your environment,
in this case it is called `my_env`.
This prefix lets us know that the environment `my_env` is currently active,
meaning that when we create programs here they will use
only this particular environment’s settings and packages.

**Note:** Within the virtual environment,
you can use the command python instead of python3,
and pip instead of pip3 if you would prefer.
If you use Python 3 on your machine outside of an environment,
you will need to use the python3 and pip3 commands exclusively.

########## finish the stuff below #################

Now let install the very latest version of Python in our virtual environment,
that is [3.6.1 as of March 3, 2017][07].

virtualenv --python=python3.6.1



```bash
# check the python version used inside the virtual environment
$ cd ~/tmp/test_env/my_env
$ python --version
Python 3.5.2

# check the python version outside inside the virtual environment
```





# Sources
* [The Hitchhiker’s Guide to Python!](http://python-guide-pt-br.readthedocs.io/en/latest/)
* [How To Install Python 3 and Set Up a Local Programming Environment on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-python-3-and-set-up-a-local-programming-environment-on-ubuntu-16-04)
* [Managing Multiple Python Versions with pyenv](http://akbaribrahim.com/managing-multiple-python-versions-with-pyenv/)



[01]:https://pypi.python.org/pypi/virtualenv
[02]:https://bitbucket.org/dhellmann/virtualenvwrapper
[03]:https://github.com/pyenv/pyenv
[04]:https://github.com/pyenv/pyenv-virtualenv
[05]:https://docs.python.org/3/library/venv.html#venv-def
[06]:https://stackoverflow.com/questions/3220404/why-use-pip-over-easy-install
[07]:https://www.python.org/downloads/release/python-361/
[08]:https://www.python.org/dev/peps/pep-0373
[09]:https://docs.python.org/3/howto/pyporting.html
[10]:http://akbaribrahim.com/managing-multiple-python-versions-with-pyenv/
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
