# Helpers
update() { sudo apt-get -y update; }
get() { sudo apt-get -y --force-yes install $*; }

################################################################################
# Add apt repositories and necessary keys, then update
################################################################################

# Docker
sudo echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

# Postgres
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
sudo wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

# Mongo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
sudo echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

# Redis
sudo apt-add-repository -y ppa:chris-lea/redis-server

echo "Successfully added repositories."

# Initial Update
update

################################################################################
# Essentials
################################################################################

get git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common python-software-properties libexpat1-dev gettext unzip tcl8.5

################################################################################
# Utilities
################################################################################

# Ag & Ack
get ack-grep silversearcher-ag

# ack-grep -> ack
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

################################################################################
# Software
################################################################################

# Check that HTTPS transport is available to APT (Docker dependency)
[ ! -e /usr/lib/apt/methods/https ] && get apt-transport-https

# Docker
get lxc-docker

echo "Finished: Docker"

# Nginx
get nginx

# Sqlite
get libsqlite3-dev sqlite3

echo "Finished: SQLite"

# MySQL
# Todo: This may cause a prompt. Not sure how to get arround that.
# Note: This may not be necessary as apparently mysql is standard on ubuntu
# get mysql-server mysql-client libmysqlclient-dev

echo "Finished: MySQL"

# Postgres
get postgresql-common postgresql-9.3 libpq-dev

# Mongo
get mongodb-org

# Redis
get redis-server redis-tools

# PHP
get php5 php5-mcrypt php5-curl php5-fpm php5-mysql php5-pgsql php5-sqlite

# Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "The current user is: $(whoami)"

# Node (via NVM)
curl -L https://github.com/creationix/nvm/raw/master/install.sh | bash
exec $SHELL
nvm install 0.10
nvm use 0.10
nvm alias default 0.10

echo "Finished: NVM"

# Ruby (via Rbenv)
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
rbenv install 2.1.3
rbenv global 2.1.3
echo "gem: --no-ri --no-rdoc" > ~/.gemrc

echo "Finished: Ruby"

# Rails
gem install rails
rbenv rehash

echo "Finished: Rails"

# Meteor
curl https://install.meteor.com/ | sh

echo "Finished: Meteor"

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
