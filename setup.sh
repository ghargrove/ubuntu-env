#!/usr/bin/env bash
user=$1
pass=$2
# Setup a user
sudo useradd -d /home/$user -m -s /bin/bash -G admin $user
echo "$user:$pass" | sudo chpasswd
# Install some basic libraries
sudo apt-get update
sudo apt-get install -y build-essential git curl zlibc zlib1g-dev zlib1g libcurl4-openssl-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-0 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool
# Install postgresql
# https://www.amberbit.com/blog/2014/2/4/postgresql-awesomeness-for-rails-developers/
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" | sudo tee -a /etc/apt/sources.list
wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-9.3 libpq-dev
# Packages retrieved by rvm
sudo apt-get update
sudo apt-get install -y gawk libsqlite3-dev sqlite3 libgdbm-dev libncurses5-dev bison libffi-dev
# Install ruby from source
wget -q http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p598.tar.gz
tar xzvf ruby-2.0.0-p598.tar.gz
rm ruby-2.0.0-p598.tar.gz
cd ruby-2.0.0-p598
./configure
make
sudo make install
# Install Phusion Passenger from apt repository
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates
# Had problems trying to create the file directory into /etc so I created it locally & moved it
echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main" > passenger.list
sudo mv passenger.list /etc/apt/sources.list.d/
sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 600 /etc/apt/sources.list.d/passenger.list
sudo apt-get update
sudo apt-get install -y nginx-extras passenger
# Install Rails
echo "gem: --no-rdoc --no-ri" > ~/.gemrc
sudo gem update --system
sudo gem install rails
