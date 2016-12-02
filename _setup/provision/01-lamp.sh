#!/usr/bin/env bash

# LAMP standard installation

timezone=$(echo "$1")
DBPASSWD=root
APACHE_USER=vagrant
APACHE_GROUP=vagrant

#== Bash helpers ==

function info {
  echo " "
  echo "-- $1"
  echo " "
}

# BEGIN ########################################################################
echo -e "\n-- ------------------ --"
echo -e "-- BEGIN BOOTSTRAPING --"
echo -e "-- ------------------ --\n"

#== Provision script ==

info "Provision-script user: `whoami`"

# change mirror to singapore
if ! [ -f /etc/apt/sources.list.origin ]; then
  sudo mv /etc/apt/sources.list /etc/apt/sources.list.origin
  sudo cp /vagrant/_setup/config/sources.list /etc/apt/sources.list
fi


# Repository for latest MySQL
# http://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#repo-qg-apt-repo-manual-setup
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5 > /vagrant/setup.log 2>&1
echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.7" | sudo tee /etc/apt/sources.list.d/mysql.list

# update the package
echo -e "-- Updating OS packages...\n"
sudo apt-get update > /vagrant/setup.log 2>&1
sudo apt-get upgrade -y  > /vagrant/setup.log 2>&1
echo -e "-- Finish updating OS packages.\n"

# MySQL setup for development purposes ONLY
echo -e "\n--- Install MySQL specific packages and settings ---\n"
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/data-dir select ''"
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password $DBPASSWD"
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password $DBPASSWD"
sudo apt-get install -y mysql-server >> /vagrant/setup.log 2>&1

# APACHE #######################################################################
echo -e "-- Installing Apache web server...\n"
sudo apt-get install -y apache2 > /vagrant/setup.log 2>&1
echo -e "-- Finish installing Apache web server.\n\n"

# create symbolic link
if ! [ -L /var/www ]; then
  sudo rm -rf /var/www
  sudo ln -fs /vagrant /var/www
fi

# echo -e "-- Your web folder is in directory /vagrant.\n"

echo -e "-- Installing PHP 5...\n"
sudo apt-get install -y php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-imagick > /vagrant/setup.log 2>&1
echo -e "-- Finish installing PHP 5.\n\n"

echo -e "-- Changing user group of apache user...\n"
sudo sed -i "s/APACHE_RUN_USER=.*/APACHE_RUN_USER=$APACHE_USER/g" /etc/apache2/envvars
sudo sed -i "s/APACHE_RUN_GROUP=.*/APACHE_RUN_GROUP=$APACHE_GROUP/g" /etc/apache2/envvars

# last process, must restart apache2 server
sudo service apache2 restart
