pi-status
=========

![Example Image](http://i.imgur.com/lnIFojN.png)

Simple Sinatra based status page for the Raspberry Pi.

Features
--------

A super simple sinatra application that serves a single page with a [swanky background](http://www.raspberrypi.org/phpBB3/viewtopic.php?f=62&t=1178) and a few nice tidbits of information.

Information:

* Uptime
* Users online
* External IP
* CPU usage
* RAM used/free/total
* SWAP used/free/total
* Used/free/total of rootfs

Installing
----------

This is known to work in both Raspbian and Raspbmc.

CPU usage requires [sysstat](http://sebastien.godard.pagesperso-orange.fr/):

    $ sudo apt-get install sysstat

Install Ruby, I'm partial to RVM:

    $ \curl -L https://get.rvm.io | bash -s stable --ruby

Install Sinatra:

    $ gem install sinatra

Configure your server in `server.rb` and launch, you will need to run it as root (`rvmsudo`) if you're using a port less than 1024:

    $ ruby server.rb

You're done!
