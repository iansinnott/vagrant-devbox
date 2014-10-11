# Vagrant Docker

A multi-stack development environment built on top of `ubuntu/trusty`.

## Intro

The included Vagrant file will setup and provision a Ubuntu 14.04 image complete with everything you need for *most* development environments (see bellow).

**This stack is great for:** Web app development in Node.js, Ruby or PHP.

**This stack is *NOT* great for:** Inflexible development stacks and large CMSs (i.e. WordPress, Drupal, Joomla, Magento, etc)

## What you get

* [Nginx][nginx]
* [Ruby][ruby] (Managed by [Rbenv][rbenv]. Includes [gem][gem], [bundler][bundler])
* [Node.js][node] (Managed by [NVM][nvm]. Includes [NPM][npm])
* [Meteor][meteor]
* [PHP][php] (Includes [composer][composer])
* [Docker][docker]
* [MySQL][mysql]
* [Postgres][postgres]
* [SQLite][sqlite]
* [Redis][redis]
* [Mongo][mongo]

Clearly there is more here than you would ever need for one single project, but this image is designed to act like a local development environment one would have on a personal computer. It comes with the kitchen sink so that you can quickly get started with any project you want.

[nginx]: http://nginx.com/
[rbenv]: https://github.com/sstephenson/rbenv
[ruby]: https://www.ruby-lang.org/en/
[gem]: https://rubygems.org/
[bundler]: http://bundler.io/
[rails]: http://rubyonrails.org/
[nvm]: https://github.com/creationix/nvm
[node]: http://nodejs.org/
[npm]: https://www.npmjs.org/
[meteor]: http://meteor.com/
[php]: http://php.net/
[composer]: https://getcomposer.org/
[mysql]: http://www.mysql.com/
[postgres]: http://www.postgresql.org/
[docker]: https://www.docker.com/
[sqlite]: http://www.sqlite.org/
[redis]: http://redis.io/
[mongo]: http://www.mongodb.org/

## Usage

**Option 1**: Copy the `Vagrantfile` to your project directory and get started.

```
$ curl ... > Vagrantfile
$ vagrant up
```

**Option 2**: Clone this repository and use it as the starting point for you project

```
$ git clone ...
$ vagrant up
```

You will be able to connect to the virtual machine at `192.168.33.10`. This can be customized in the `Vagrantfile`.

## Limitations

As mentioned above, this is not the ideal image for running many CMSs including WordPress.

For example, while wordpress works with Nginx it usually introduces complications if not run on Apache. As

## Todo

* Support python based stacks
* Usage examples

