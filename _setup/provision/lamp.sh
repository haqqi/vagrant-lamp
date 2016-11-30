#!/usr/bin/env bash

# change mirror to singapore
if ! [ -f /etc/apt/sources.list.origin ]; then
  sudo mv /etc/apt/sources.list /etc/apt/source.list.origin
  sudo cp /vagrant/_setup/config/sources.list /etc/apt/sources.list
fi

# update the package
sudo apt-get update

# install apache2
sudo apt-get install -y apache2

# create symbolic link
if ! [ -L /var/www ]; then
  sudo rm -rf /var/www
  sudo ln -fs /vagrant /var/www
fi
