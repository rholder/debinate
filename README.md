##What is this?
Debinate let's you roll your very own Python projects with a bunch of weird
dependencies into little standalone Debian packages you can install into `/opt`.
It's not meant to be a highly customizable packager with every option available
under the sun but instead to just hit the low-hanging fruit of packaging Python
applications to ease installation.

##Installation

 * Install [fpm](https://github.com/jordansissel/fpm), the greatest package builder ever created.
 * Drop the latest version of `debinate` into your $PATH, set it executable, and make sure you own `/opt`:

```bash
sudo curl -o /usr/local/bin/debinate https://raw.github.com/rholder/debinate/master/debinate && \
sudo chmod +x /usr/local/bin/debinate && \
sudo chown $USER:$USER /opt
```

##Use
Create a `setup.py` for your project that isn't too crazy. If you can install
it via a `pip install ./` then you're probably good to go. Here's one to get
you started that has a bunch of stuff in it:
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

##License
Debinate is released under version 2.0 of the
[Apache License](http://www.apache.org/licenses/LICENSE-2.0).
