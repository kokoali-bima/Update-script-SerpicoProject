# Installing serpico
#!/bin/bash

username=$(whoami)

sudo adduser --disabled-login --gecos 'serpico' serpico

sudo ln -s /bin/mkdir /usr/bin/mkdir

apt-get -y install curl git wget

# Use this to download the rvm gpg
\curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import -

# Download and install the stable version of RVM in multi user mode
\curl -sSL https://get.rvm.io | sudo bash -s stable

curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg --import -
adduser root rvm
adduser $username rvm

# Run this once to allow rvm to be run
source /etc/profile.d/rvm.sh

# This will add the source command to your .bashrc to ensure you don't have to run it each time
echo source /etc/profile >> /home/$username/.bashrc
echo source /etc/profile >> /root/.bashrc

# Install openssl library (required for ruby install 2.6.3)
apt-get install -y libssl-dev

rvm get master

# Install and use Ruby 2.6.3, the version used by Serpico
rvm install 2.6.3

source /etc/profile.d/rvm.sh
rvm use 2.6.3

# Serpico Dependencies
apt-get -y install libsqlite3-dev libxslt-dev libxml2-dev zlib1g-dev gcc

# Get and install the development version of Serpico
git clone https://github.com/SerpicoProject/Serpico.git /opt/serpico

chown -R serpico:serpico /opt/serpico

cd /opt/serpico/

gem install bundler

sudo -u serpico -H bundle install

# Initialize the findings database
echo "|+| Please run 'ruby scripts/first_time.rb' to complete the installation"


# One completed, you can edit /opt/Serpico-Dev/config.json so that your Serpico instance is local only.
# Change "bind_address": "0.0.0.0", to "bind_address": "127.0.0.1",
