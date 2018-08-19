---
title: "Magic: Ruby 1.8.5 + 1.9.1/Rails/Sinatra and Lighttpd"
description: "Magic: Ruby 1.8.5 + 1.9.1/Rails/Sinatra and Lighttpd"
slug: magic-ruby-185-191railssinatra-and-lighttpd
date: 2009-11-29 09:51:38
draft: false
summary: "Ladies and gentlemen, gather 'round! The Great Panini is going to perform an incredible illusion before your very eyes! You will tell your grandchildren of this day and they will not believe you! Take pictures!"
image: "0fc3e519-fa4d-464d-9e24-fe29bbcedec6.jpg"
---


[![](/images/3169705160_9db19161f0_t.jpg)](http://www.flickr.com/photos/on1stsite/3169705160/)
_Ladies and gentlemen, gather 'round! The Great Panini is going to perform an
incredible illusion before your very eyes! You will tell your grandchildren of
this day and they will not believe you! Take pictures!_

The Great Panini will start with a pre-steam machines era CentOS 4 server. He
will install two versions of Ruby and they will coexist peacefully! He will
then use the blazing fast Lighttpd server to proxy queries to various Ruby
frameworks and he will even make it look easy!

Hrm...Sorry.  
I am going to tell you how I quickly updated a couple servers with Ruby 1.9.1
and Lighttpd. And it will look easy because it is, in fact, easy.  
This article's aim is to be practical but I will explain as we go along.

The first thing I did was update CentOS to a more recent version. This could
take a while but it's always a good idea to keep a server software up-to-date
so I'm sure that your already are almost there:

```bash
yum update
```

In my case, after a couple hours (oops), the update was complete and I
rebooted the servers.

**Ruby 1.8.5**

That's the easy part because it's the version of Ruby that currently comes
with CentOS. Therefore you can install it using yum:

```bash
yum install ruby ruby-devel ruby-irb ruby-rdoc ruby-ri
```

**Ruby 1.9.1**

Download the package from ruby-lang.org:

```bash
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.1-p0.tar.bz2  
tar zxvf ruby-1.9.1-p0.tar.bz2  
cd ruby-1.9.1-p0
```

The trick, here, is to give all 1.9.1 binaries a different name. Fortunately,
_configure_ offers an option for that:

```bash
./configure --program-suffix=19
```

Build and install:

```bash
make && make install
```

**Rubygems**

Get rubygems from Rubyforge:

```bash
wget http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz  
tar zxvf rubygems-1.3.5.tgz  
cd rubygems-1.3.5
```

Note that we are now using our brand new 1.9.1 binaries:

```bash
ruby19 setup.rb
```

Now, make sure your gems are up to date:

```bash
gem19 update
```

Let's see. We want to use two frameworks: _Rails_ and _Sinatra_. Installing
them could not be simpler:

```bash
gem19 install rails  
gem19 install sinatra
```

We will use thin to run our programs:

```bash
gem19 install thin
```

Let's make sure that thin is run when the server boots up:

```bash
thin install
```

This will create _/etc/init.d/thin_ which we can then link to the appropriate
runlevels using _chkconfig_

We will, when creating Ruby applications, tell thin about the instances it
needs to run. This will be done by adding yml files to _/etc/thin/_

I am going, in this article, to create these applications in
_/home/yourdirectory/_. Of course, use your own directory.

**Rails**

Let's create a Rails application:

```bash
rails myrailsapp
```

In the application's _config/_ directory, let's create our thin yml file (
_thin_myrailsapp.yml_ )

```yaml
chdir: /home/yourdirectory/myrailsapp  
address: 127.0.0.1  
port: 3000  
servers: 4  
max_conns: 1024  
timeout: 30  
max_persistent_conns: 512  
user: www  
group: www  
environment: development  
pid: tmp/pids/thin.pid  
log: log/thin.log  
daemonize: true
```

_chdir_ tells thin where our document root is located. Rails serves documents
from _document root/public/_  
 _address_ is localhost because that's what will be used when proxying through
Lighttpd  
 _servers_ is '4' which means that four servers will be instantiated, starting
at , i.e. 3000, 3001, 3002, 3003  
 _User_ and _group_ : I am using the same user and group that Lighttpd runs as
for simplicity sake.

Let's tell Lighttpd about this new application. Edit
_/etc/lighttpd/lighttpd.conf_ , or wherever your configuration file is:

```lighttpd
$HTTP["host"] =~ "myrailsapp\.yourdomain\.com$" {  
        $HTTP["url"] =~ "^/((images|javascripts|stylesheets)/(.*)$)" {  
                server.document-root = /home/yourdirectory/myrailsapp/public"  
        }  
        proxy.balance = "fair"  
        proxy.server =  ("" =>  
                (  
                        ( "host" => "127.0.0.1", "port" => 3000 )  
                )  
        )  
}
```

I am using the "fair" load balancer because, as the default option, it tries
to be...fair, obviously, and isn't too greedy: it does not compute a hash for
each url.

Let's now tell thin about this application by simply creating a symbolic link
in _/etc/thin/_ :

```bash
ln -s /home/yourdirectory/myrailsapp/config/thin_myrailsapp.yml /etc/thin/
```

Restart Lighttpd and start thin:

```bash
/etc/init.d/lighttpd restart && /etc/init.d/thin start
```

I know...supposedly I should be able to simply type 'lighttpd reload' and it
will reload its configuration files but that does not always seem to work.

Now, the fun stuff:

Go to http://myrailsapp.yourdomain.com:3000 and you should be greeted by
Rail's welcome page.

Now, go to http://myrailsapp.yourdomain.com and you should see the same page,
except this time it was proxyied by Lighttpd.

**Sinatra**

Create your application; e.g. the ubiquitous "hi" application. Again in
_/home/yourdirectory/mysinatraapp_ , create _hi.rb_ :

```ruby
require 'rubygems'  
require 'sinatra'  
get '/' do  
    'Hello world! I love kittens.'  
end
```

Create a _config/_ subdirectory:

```bash
mkdir config && cd config
```

In the _config/_ directory, let's create our thin yml file (
_thin_mysinatraapp.yml_ )

```yaml
rackup: /home/yourdirectory/mysinatraapp/config/mysinatraapp.ru  
chdir: /home/yourdirectory/mysinatraapp  
address: 127.0.0.1  
port: 4567  
servers: 4  
max_conns: 1024  
timeout: 30  
max_persistent_conns: 512  
user: www  
group: www  
environment: development  
pid: /home/yourdirectory/mysinatraapp/thin.pid  
log: /home/yourdirectory/mysinatraapp/thin.log  
daemonize: true
```

Starting at port 4567 because, by convention, it's Sinatra's default port when
started standalone.

Notice the main difference? Sinatra will rely on rack for its setup, hence the
' _rackup_ ' keyword.  
Let's create that rack file ( _mysinatraapp.ru_ )

```ruby
require 'sinatra'  
    
Sinatra::Application.default_options.merge!(  
    :run => false,  
    :env => :development  
)  
    
require 'hi.rb'  
run Sinatra.application
```

Do not forget Lighttpd:

```lighttpd
$HTTP["host"] =~ "mysinatraapp\.yourdomain\.com$" {  
            proxy.balance = "fair"  
            proxy.server =  ("" =>  
                    (  
                            ( "host" => "127.0.0.1", "port" => 4567 )  
                            # room for more instances  
                    )  
            )  
}
```

Of course, if you know that some directories will be dedicated to static
content you can also check for these directory names and have Lighttpd serve
them statically, as shown in myrailsapp's example.

Restart Lighttpd and thin:

```bash
/etc/init.d/lighttpd restart && killall -HUP thin
```

Test it:

Go to http://mysinatraapp.yourdomain.com:4567 and you should see the message
returned by _hi.rb_.

Now, go to http://mysinatraapp.yourdomain.com and you should see the same
page, except, again. it was proxyied by Lighttpd.

**Conclusion**

As I wrote earlier, this is easy and actually fairly straightforward. It some
of this is not working for you, it is likely because I glossed over something
I really shoudln't have. Post a comment and describe your issue and I will
gladly help.

