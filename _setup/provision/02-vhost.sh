#!/usr/bin/env bash

# Setup vhost development

echo -e "\n--- Enabling mod-rewrite ---\n"
sudo a2enmod rewrite >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Allowing Apache override to all ---\n"
sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf