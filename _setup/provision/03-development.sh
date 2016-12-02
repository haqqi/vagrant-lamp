#!/usr/bin/env bash

echo "Install composer"
sudo curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

echo "Install webmin"
sudo wget http://www.webmin.com/jcameron-key.asc
sudo apt-key add jcameron-key.asc

sudo apt-get update -qq
sudo apt-get install -y webmin

echo -e "\n--- Disable SSL for webmin development ---\n"
sudo sed -i "s/ssl=1/ssl=0/g" /etc/webmin/miniserv.conf
sudo service webmin restart
echo -e "\n--- Access webmin in your server via port 10000 ---\n"
