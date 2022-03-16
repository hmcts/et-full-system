# Employment Tribunal Full System - For Development / Testing Use Only

This project groups together all the components of the employment tribunal
system for development and test purposes and to perform end to end tests on them 
whilst developing the jadu replacement system.

This allows the test suite to test the entire system to live in this code base - as docker-compose can setup the entire system for you.

Of course, you can do it yourself without docker compose and this is getting easier and easier now we have switched to
all services running behind a single nginx server and using passenger to deal with the rails apps.
If you do want to go down this route, you are on your own for now !!  But, take a look at the diagram below and the files
in the docker/test_server folder - the docker-compose.yml and you can see the
different services and how they are setup to talk to one another - you need to achieve the same thing but running everything on localhost.

The above could be done using 'foreman' (which is partly done in bin/foreman) to bring everything together and if someone 
has the time to do this - or if someone requires that it is done and therefore justifying the time - 
then please reach out to me (Gary Taylor) - or just do it and share it !!

A diagram speaks a thousand words - so hopefully the diagram below will show what I mean.  This is how the docker environment
is setup.  Again, a similar environment using something like 'foreman' could also be setup with some careful configuration.

Also note that the 'test server' are intended to be as close to production as is possible from a config and general architecture point of view, not
performance / scaling.  Hence they run in 'production' environment, but configured to use a test SMTP (mailhog) and AWS/S3 server (minio).

The test SMTP server allows the test suite (via REST) or the developer (via a web page / web server - details further down vvvvv) to see what emails the
application(s) would have sent if they were really being sent to users.

The test AWS/S3 server allows normal S3 requests to take place - i.e. adding files to buckets, deleting them etc.. and these files being made available via
a URL which is accessible within the docker network (or outside if you setup port forwarding).  This means we can test without running up bills or even having
to enter any S3 credential which quite rightly, developers do not really want to do as it may run up bills on their card.
Note that this uses a server called 'minio' which is available for just about any platform.
Minio has a web interface at http://s3.et.127.0.0.1.nip.io:3100 (unless you have changed the domain or port - then adjust as necessary)

Also, in preparation for azure migration, we now have an azure blob server running.  To run the server in azure mode, set
the environment variable CLOUD_PROVIDER=azure

## External Dependencies

### Docker Compose

Minimum version: 1.21.0

### Docker

Minimum version:  18.05.0-ce

## Quick Start

If you just want to get going, here is a quick way to prove that it all works.

```

git clone --recursive git@github.com:ministryofjustice/et-full-system.git

```

Then

```
cd et-full-system
```

If you want a different branch than develop (the default) then do this :-

```
git checkout <your_branch>
git submodule update

```

then, irrespective of branch :-

```

./bin/dev/test_server up

```

and wait for a message like this from docker (it takes a while - it has 4 applications to build so you will 
see 4 sets of gemsets building, migrations running etc..)

```
Passenger core running in multi-application mode

```

then in another terminal window in the same directory

```

./bin/dev/test_framework up -d
./bin/dev/test_exec bundle
./bin/dev/test_exec cucumber

```

If you want to do anything in a slightly different way, read on - otherwise if tests pass then its working !!

## Diagram Showing Test Servers and Test Framework Systems

![diagram 1](docs/diagram_showing_systems.png)

## Use Of 'Passenger' Gem

This project now uses the nginx web server and the 'passenger' gem. This allows the outside world (i.e. us !) to see just a single server
and not have to worry about setting port numbers etc.. for the 4 different services (api, et1, et3 and admin) and 2 support services (a local s3 server and a development mail server).  It is also
a closer setup to production where everything is behind 'nginx'

It is configured to use the same domain's whether you are working inside the docker network or on your local machine.

Whilst this does not matter 95% of the time, when dealing with pre signed URL's for Amazon S3 stuff - it is signed using
the hostname - so if you were using 's3.et.127.0.0.1' outside of docker and 's3.et' inside of docker - you would get
issues with the signature not matching amongst other problems.

# Cloning

This project is an umbrella project using git submodules (https://git-scm.com/docs/git-submodule).  This is for convenience so that all developers have the
same structure, meaning that docker-compose files etc.. can be setup to span across projects.


So, to clone - do 

```

git clone git@github.com:hmcts/et-full-system.git


# Initial Setting Up

The system is very configurable so it can be run on whichever ports you want etc..

# General Development / Testing Notes

## Testing

There are lots of things with regard to automated testing to consider - please read [this document](docs/automated_testing.md) for more details

## CI

When the tests run in the CI, screenshots and html logs can be sent to s3 instead of remaining local.  This allows
for a clickable link in the report which shows the html or screenshot.

To configure this, the following environment variables are to be set

SCREENSHOT_S3_ACCESS_KEY_ID=<correct access key id>
SCREENSHOT_S3_SECRET_ACCESS_KEY=<correct secret access key>
SCREENSHOT_S3_BUCKET=<bucket>
SCREENSHOT_S3_REGION=<region>
SCREENSHOT_S3_KEY_PREFIX=<any prefix - maybe build number>


### ACAS Testing

The system will not connect to the external ACAS service as we have no control over it and we would not want builds failing
because their server is down.  So, a fake ACAS server is provided which is pre programmed to respond with all 4 of the different response types depending on the first
part of the certificate number requested.  The numbers after the slashes etc.. do not matter

These are as follows (note, the 'R' can also be 'NE' or 'MU')

R000200/18/68 - Returns a 'No Match'

R000201/18/68 - Returns an 'Invalid Certificate Format'

R000500/18/68 - Returns an 'Internal Error'

R000100/18/68 - Returns a valid certificate

Other numbers with containing 000xxx where xxx is neither 200, 201 or 500 will also return a valid certificate

### Email Testing

The system uses mailhog mounted at mail.et.127.0.0.1.nip.io:3100 normally.  Visit this in your browser and you will see all
emails sent by the tests (and manual use of the applications).  Mailhog also has an API that you can use within your tests to
test that emails have been sent, checking the content etc...

## Development

If you want to develop parts of the system and use this framework for convenience - please read [this document](docs/development.md)

# Using The Framework

There are scripts in bin/dev to do docker-compose stuff.  Generally these are just shortcuts and accept the
same commands as the docker-compose command line.  So where you see 'up' and 'down' - that is a clue that it is just docker-compose
and you will be able to use other docker-compose command line switches such as '-d' (for detached so you dont view the output all the time).

Whilst we don't want to force you to use docker if you don't want to, right now, it is the only supported way of running this stuff
together.  But, remember these apps are just rails apps and are very configurable using environment variables etc.. so it won't be 
too hard to get it running using other means.

## Firing Up The Test Server

If you just want the defaults and port 3100 is available, simply skip the optional sections below


### (Optional) - Configuring environment variables

If, you are happy with the server running on port 3100 and the domain being 'et.127.0.0.1.nip.io' (so you dont need
to change your hosts file - see below) then you don't need to do anything with environment variables.

The key environment variables are :-

SERVER_DOMAIN - Defaults to 'et.127.0.0.1.nip.io' (correct for default server)
SERVER_PORT - Defaults to '3100' (correct for default server)
SMTP_PORT - The mail server by default exposes port 1025 to your localhost in case you need it.  If this port is already used you may need to change this.
CLOUD_PROVIDER - Defaults to amazon if not set.  Can be amazon OR azure only

These environment variables are the same for both the server and the test suite (if automated test are
 required to be run) and should match.


This means that your default server should be available at http://et.127.0.0.1.nip.io:3100

### Starting The Server

If you are not changing any environment variables - simply run

```

./bin/dev/test_server up

```

Or, if you want to use the shorter domain (make sure you have modified your hosts file as above) :-

```

SERVER_DOMAIN=et ./bin/test_server up

``` 

Or, if you want a different port

```

SERVER_PORT=3200 ./bin/test_server up

```

or a combination of the above - you get the idea :-)

### Stopping The Server

If ctrl-c doesn't kill the server and associated processes you may occasionally need to do :-

```

./bin/dev/test_server down

```


## Running Tests

You can run tests either from a docker instance or from your local machine. 

However, now that we have the 'single server' approach where all the services are behind a single nginx server, it has
made it much easier to run the tests locally and there is less need to run them from inside docker.

But, the docker stuff hasn't been removed so it is there if you want it.

First, start up the test servers (see  'Firing Up The Test Server' above for more details) like this 

```

./bin/dev/test_server up

```

and wait for everything to settle and you will see the 'Passenger core running in multi-application mode' message near the end

### Running Tests Locally

If you just want to run the tests with the default browser (chromedriver) - once you have done a 'bundle install' you 
can just run cucumber as normal - no external services to run etc...

Note that if you have a non default port or domain when running your server (see the optional sections in 'Firing Up The Server' above),
then you will need to use the same environment variables when running cucumber etc...

So, running cucumber is as simple as :-


```

bundle exec cucumber

```

#### Running Tests With Selenium

If you want to run tests using selenium (so the browser doesn't keep popping up, moving your focus, switching desktops
and generally being annoying) then you will need a selenium server.

The test framework provides this selenium server running inside a VNC server so you can view it if you want.  The VNC 
server can also be used by the test suite to record video of failing tests.  Note that the test framework also provides
a docker instance for running stuff from inside the docker network which in this case is wasted as we are not doing so.

Of course, you are free to provide your own selenium server, but the instructions below apply to using the docker version.

To start the test framework :-

```

./bin/dev/test_framework up

```

and from then on, when running cucumber, specify the browser in the DRIVER environment variable.  To use chrome do the following :-

```

DRIVER=chrome bundle exec cucumber

```

### Running Tests From Inside Docker

Start up the test environment like this :-

```
./bin/dev/test_framework up

```

adding '-d' at the end if you dont want to follow the logs etc..

once the test_framework is up and running - it is just idle doing nothing until you ask it to do something - so I would guess you would
want to run cucumber. However, this is just a 'container' with ruby on it and setup ready for you to go.  So, like any other ruby environment
you need to do a bundle install first (and every time you add a new gem to the Gemfile in THIS project, not the child projects) - like this :-

```

./bin/dev/test_exec bundle install

```

Then, to run cucumber :-


```

./bin/dev/test_exec bundle exec cucumber

```

or, if you prefer to just have a session open inside the 'test machine' - then do :-

```

./bin/dev/test_exec bash

```

then just type in commands as normal - note the app is inside the '/app' folder in the docker machine.

### Watching Your Tests Run

When developing locally, you can have a browser window visible which is great whilst debugging, but very annoying when you want to get
on with something else whilst the tests are running.

With the docker version, the browser is not launched on the local machine, but inside a docker container where you can't see it - so
it won't annoy you.  But, what happens when you want to see it ?  Simple, you connect a vnc client to the port forwarded by the selenium service.
This port is random to start with (use 'docker ps' when the test suite is uo and look for '5900' in selenium service), but you can lock it down to
a known free port by setting the SELENIUM_VNC_PORT environment variable.  Note that there is a password setup by default which is 'secret'

## Re Building Docker Images

Occasionally, if the Dockerfile has changed - things will need re building. If you are asked to rebuild, just add '--build' onto
the end of the 'up' command and it will force a re build of all our containers.

## More details if you want to know more :---

In the docker folder, there are a few folders each with at least a docker-compose.yml file in

Here are what they are for :-

### docker/test_servers

Will run all of the servers to run tests against or to manually test against

#### Environment Variables

There are some special environment variables too :-

SERVER_PORT - Defaults to 3100 - this is the port that the main server exposes to your local machine
SMTP_PORT - Just in case you want to run a service locally that uses SMTP - this port defaults to 1025
SERVER_DOMAIN - Defaults to et.127.0.0.1.nip.io which should work for everyone - not much point in changing
DB_PORT - Just in case you want to run a service locally that shares the same database
REDIS_PORT - Just in case you want to run a service locally that shares the same redis instance

### docker/test_framework

Used to run the test suite - generally you would grab a bash session using

```
docker-compose run test bash
```

and then do normal ruby stuff such as bundle exec rspec

but, don't forget, this is what the scripts in bin/dev do !!

## Environment Variables For Test Suite

### SERVER_PORT

### SERVER_DOMAIN

### ADMIN_USERNAME

The admin username (defaults to admin@example.com - same as seed data)

### ADMIN_PASSWORD

The admin password (defaults to password - same as seed data)

### SELENIUM_VNC_PORT

If set, the VNC port that selenium exposes will be forwarded to this port.  Otherwise, it is random

### SELENIUM_PORT

The selenium port that the tests talk to can be set using this.  If not set, it is random.
This could be useful if you wanted to use the docker setup for all of its supporting services, but run the actual tests in ruby on
your local machine.  Without this, your code would not know which port to connect to.

# Running The Test Suite Locally

## Preparation - Servers

Make sure you have the ports you want to use free and start up the test servers with them exposed - such as :-

```
./bin/dev/test_servers up
```

## Preparation - Test Framework


### Exposing the ports

The 'test' service in the test framework is not going to be required (as you are effectively running it locally) - however,
no harm in starting up the test framework as it provides the selenium service

```

SELENIUM_PORT=4444 SELENIUM_VNC_PORT=5900 ./bin/dev/test_framework up

```

### Setting Up Video Recording (Optional)

The suite will run without this, but its well worth having when things go wrong as it provides a nice video of it going wrong

#### First, install python and pip

You may already have this - try typing 'pip' and see if you get command not found.  If you do then continue :-

For OSX

```

brew install python

```

or if you already have python but no pip

```

sudo easy_install pip

```

For Linux (debian based - e.g. ubuntu)

```
apt-get install python python-dev python-pip

```

For Windows

I don't know - but if someone finds out, please update this readme


## Running The Test Suite

The .env file provided gives the defaults assumed above - the API is running on port 3000, the admin on port 3001, the
fake S3 server on port 3002, ET1 on port 3003 and selenium on port 4444.

So, if you want to go with this - just go ahead and run

```

bundle exec cucumber


```

# Running Everything Without Docker

'foreman' has been configured to run everything as well.  It is more prone to port clashes, but may suit you better

## Dependencies

* nodejs
* npm
* postgresql - if not installed, use Postgres.app to run as required (osx)
* redis - if not installed, use Redis.app to run as required ('brew cask install redis-app' on OSX)
* mailhog - ('brew install mailhog' on OSX)
* pdftk - (see https://www.pdflabs.com/tools/pdftk-server/)

## Running The end-to-end test suite in different environments and using profile

local: ./bin/dev/test_exec bundle exec cucumber
dev: ./bin/dev/test_exec bundle exec cucumber ENVIRONMENT=dev
staging: ./bin/dev/test_exec bundle exec cucumber ENVIRONMENT=staging

## Using cucumber.yml profile

./bin/dev/test_exec bundle exec cucumber -p smoke

## Running test in parallel

./bin/dev/test_exec bundle exec parallel_cucumber features/ ENVIRONMENT=dev

## Running test in different locale

TEST_LOCALE=cy [if left blank it will default to english']


### Running cross browser and device tests using Sauce Labs
Replace 'SAUCE_USERNAME' and 'SAUCE_ACCESS_KEY' in et-full-system/.env with your account details

Run tunnel:
Go to your terminal
Example go to the path where you've downloaded Sauce connect

Latest sauce version on Mac ->  sc-4.6.3-osx

`$ cd Downloads/sc-4.6.3-osx`

Run Below command

`$ sc-4.6.3-osx % bin/sc -u <SAUCE_USERNAME> -k  <SAUCE_ACCESS_KEY> --se-port 4449`

Replace '<SAUCE_USERNAME>' and '<SAUCE_ACCESS_KEY>' with your account details

Wait for 'Sauce Connect is up, you may start your tests.'

[Add the tag '@saucelabs' to a scenario/s that you want to run.]

To run Sauce Labs feature using specific browser:

Open new session on terminal

Go to your et-full-system folder path

Run Below command

`$ ENVIRONMENT=dev DRIVER=chrome_saucelabs cucumber --tags @saucelabs`
