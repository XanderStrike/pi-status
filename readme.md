pi-status
=========

![Example Image](http://i.imgur.com/lnIFojN.png)

Simple Sinatra based status page for the Raspberry Pi.

####Features

A super simple sinatra application that serves a single page with a [swanky background](http://www.raspberrypi.org/phpBB3/viewtopic.php?f=62&t=1178) and a few nice tidbits of information.

Information displayed:

* Uptime
* Users online
* External IP
* CPU usage and temperature
* RAM used/free/total
* SWAP used/free/total
* Used/free/total of rootfs

####Install

This is known to work in both Raspbian and Raspbmc. Note that it _probably won't_ work on anything other than a Raspberry Pi.

CPU usage requires [sysstat](http://sebastien.godard.pagesperso-orange.fr/):

    $ sudo apt-get install sysstat

Install Ruby, I'm partial to RVM:

    $ \curl -L https://get.rvm.io | bash -s stable --ruby

Install Sinatra:

    $ gem install sinatra

Configure your server in `server.rb` and launch, you will need to run it as root (`rvmsudo`) if you're using a port less than 1024:

    $ ruby server.rb

You're done!

####Notes

There are many other web based system monitors for the Pi out there already, most not requiring anything as heavy as Ruby. I only decided to go with Sinatra because I'm already using RoR on my Pi to host a few other personal projects, and I much more familiar with Ruby. This could be useful for anyone who's already got a Ruby environment on their Pi, but if you don't you'd probably be better off looking elsewhere. As this is a personal project, I don't suspect anyone will be contributing, but if you'd like to just shoot me a pull request.

**License**: [MIT](http://opensource.org/licenses/MIT)