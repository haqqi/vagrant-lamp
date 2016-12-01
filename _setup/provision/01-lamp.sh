#!/usr/bin/env bash

# LAMP standard installation

timezone=$(echo "$1")

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}

#== Provision script ==

info "Provision-script user: `whoami`"

# change mirror to singapore
if ! [ -f /etc/apt/sources.list.origin ]; then
  sudo mv /etc/apt/sources.list /etc/apt/source.list.origin
  sudo cp /vagrant/_setup/config/sources.list /etc/apt/sources.list
fi

info "Updating package..."

# update the package
sudo apt-get update -qq
sudo apt-get upgrade -y -qq

# APACHE #######################################################################
echo -e "-- Installing Apache web server\n"
sudo apt-get install -y apache2 > /vagrant/null 2>&1

# create symbolic link
if ! [ -L /var/www ]; then
  sudo rm -rf /var/www
  sudo ln -fs /vagrant /var/www
fi
