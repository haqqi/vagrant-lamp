#!/usr/bin/env bash

# Setup vhost development

APACHE_SITE=/etc/apache2/sites-available

# Clearing up current configurations
sudo rm /etc/apache2/sites-enabled/*.conf
sudo rm $APACHE_SITE/*.conf

# Copy all vhost in _setup/host to sites-available
for filename in /vagrant/_setup/host/*.conf; do
  echo "Copy file $filename and enabling the virtual host..."

  sudo cp "$filename" "$APACHE_SITE/$(basename "$filename")"

  sudo a2ensite "$(basename "$filename")" >> /vagrant/vm_build.log 2>&1
done

# Enable all site
sudo service apache2 restart

echo "Virtual host is ready"
