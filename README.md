[![Build Status](http://img.shields.io/travis/rholder/debinate.svg)](https://travis-ci.org/rholder/debinate) [![Latest Version](http://img.shields.io/badge/latest-0.6.0-brightgreen.svg)](https://github.com/rholder/debinate/releases/tag/v0.6.0) [![License](http://img.shields.io/badge/license-apache%202-brightgreen.svg)](https://github.com/rholder/debinate/blob/master/LICENSE)

##What is this?
Debinate started out as a way to let you roll your very own Python projects with
a bunch of weird dependencies into little standalone Debian packages you can
install into `/opt`. It has since gained the ability to turn any directory into
a Debian package with the addition of the `build` command.

It's not meant to be a highly customizable packager with every option available
under the sun but instead to just hit the low-hanging fruit of packaging
applications to ease installation.

##Installation

### Linux
Drop the latest version of `debinate` into your $PATH, set it executable, and
make sure you own `/opt` if you plan to use the Python `package` command:
```bash
sudo curl -o /usr/local/bin/debinate -L https://github.com/rholder/debinate/releases/download/v0.6.0/debinate && \
sudo chmod +x /usr/local/bin/debinate && \
sudo chown $USER:$USER /opt
```
If you're on a Debian/Ubuntu-based system, there's a `.deb` package available [here](https://github.com/rholder/debinate/releases/latest/).

### OSX
As of debinate 0.4.0, experimental support for OSX was added. Use [homebrew](http://brew.sh/) to install the following GNU tools:
```
brew install coreutils findutils gnu-tar
```
Then drop the latest version of `debinate` into your $PATH, set it executable, and
make sure you own `/opt` if you plan to use the Python `package` command:
```bash
sudo curl -o /usr/local/bin/debinate -L https://github.com/rholder/debinate/releases/download/v0.6.0/debinate && \
sudo chmod +x /usr/local/bin/debinate && \
sudo chown $USER:staff /opt
```
I would consider it experimental because projects with Python dependencies that are compiled will only work on OSX. However, if your project uses only pure Python dependencies, then you'll likely be fine building on OSX and running on Debian/Ubuntu. Also of note, on OSX you can still turn any directory full of stuff into a Debian package with the `build` command.

##Usage
```
Debinate 0.6.0 - roll up your project into a Debian package

Python:

  debinate init     - create and initialize a debinate project structure in .debinate
  debinate prepare  - wipe target and build folders, regenerate their contents (optional, called by package if necessary)
  debinate package  - creates a .deb from your project, calls prepare if necessary
  debinate clear    - delete everything in target and build, leaving cache folder intact
  debinate clean    - delete everything in target, build, and cache folders

Advanced:

  debinate build    - build a .deb from a directory
   -r, --root         root directory, e.g. ./root with ./root/usr/local/bin/thing inside
   -n, --name         project name (optional, default: current directory)
   -v, --version      project version (optional, default: 1.0.0)
   -d, --debian-dir   directory that contains debian package files, like control (optional)
   -o, --output       output .deb file location (optional, default: "./name-version.deb")

Examples:

  # everything you need to package up Python stuff
  debinate init
  debinate package
  debinate clean

  # minimal default to build a .deb from the given root directory
  debinate build -r ./build/root

  # kitchen sink, specify all the things!
  debinate build --root ./build/root --name potato --version 1.3.2 --debian-dir ./debian --output ./potato-123.deb
```

##Python
For Python, create a `setup.py` for your project that isn't too crazy. If you
can install it via a `pip install ./` then you're probably good to go. Here's
one to get you started that has a bunch of stuff in it:
```
#!/usr/bin/env python
import sys

from setuptools import setup

requires = ['argparse==1.2.1',
            'numpy==1.8.0',
            'pandas==0.12.0',
            'python-dateutil==2.2',
            'pytz==2013.8',
            'six==1.4.1',
            'wsgiref==0.1.2',
            'MySQL-python==1.2.4']

py_modules = ['my_cool_project_module']

packages = []

setup_options = dict(
    name='my_cool_project',
    version='1.0.0',
    description='My Cool Project',
    author='Cool Developer',
    author_email='',
    install_requires=requires,
    py_modules=py_modules,
    packages=packages
)

setup(**setup_options)
```

Initialize the .debinate project structure from the top level of your project:
```
debinate init
```
This will create some empty boilerplate that you can customize.

Package up your project:
```
debinate package
```

If you don't like what was built, you can clean out the build directories and
start over with:
```
debinate clean
```

See examples for uses of the `build` command.

##License
Debinate is released under version 2.0 of the
[Apache License](http://www.apache.org/licenses/LICENSE-2.0).
