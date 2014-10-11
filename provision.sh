# Be sudo
sudo -s

# Helpers
update() { apt-get -y update; }
get() { apt-get -y --force-yes install $*; }

# Initial Update
update

################################################################################
# Essentials
################################################################################
get git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common python-software-properties libexpat1-dev gettext unzip tcl8.5

################################################################################
# Utilities
################################################################################
get ack-grep silversearcher-ag

# Make ack-grep ack
dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

################################################################################
# Docker
################################################################################

# Check that HTTPS transport is available to APT
if [ ! -e /usr/lib/apt/methods/https ]; then
	get apt-transport-https
fi

# Add the repository to your APT sources
echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list

# Then import the repository key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
update

# Install docker
get lxc-docker

echo "Finished: Docker"

################################################################################
# Software
################################################################################

# Nginx
get nginx

# Sqlite
get libsqlite3-dev sqlite3

echo "Finished: SQLite"

# MySQL
# Todo: This may cause a prompt. Not sure how to get arround that.
get mysql-server mysql-client libmysqlclient-dev

# Postgres
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
update
get postgresql-common postgresql-9.3 libpq-dev

# Mongo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
update
get mongodb-org

# Redis
apt-add-repository -y ppa:chris-lea/redis-server
update
get redis-server redis-tools

# PHP
# PHP is omitted for now b/c I don't want to take the time to test it out
get php5 php5-mcrypt php5-curl php5-fpm php5-mysql php5-pgsql php5-sqlite

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Be the vagrant user. NVM, Rbenv and a number of other tools are meant to be
# installed as a user, and they may need to correctly detect files under ~/,
# which should resolve to /home/vagrant and not /root
su vagrant

  # Node (via NVM)
  curl -L https://github.com/creationix/nvm/raw/master/install.sh | bash
  nvm install 0.10
  nvm use 0.10
  nvm alias default 0.10

  # Ruby (via Rbenv)
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  exec $SHELL
  rbenv install 2.1.3
  rbenv global 2.1.3
  echo "gem: --no-ri --no-rdoc" > ~/.gemrc

  # Rails
  gem install rails
  rbenv rehash

  # Meteor
  curl https://install.meteor.com/ | sh


# Return to being sudo
exit

cat <<INSTRUCTIONS

All done, everything has been installed. However, there is still some manual
setup that you may need to do:

    * Configure Git with your username and email
    * Set up project specific packages (ex: Sinatra, Express, etc)
    * Set up your personal SSL certificats
    * Import any preexisting databases
    * Copy over your own configuration files
    * Etc...

Have fun.

INSTRUCTIONS
