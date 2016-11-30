#@IgnoreInspection BashAddShebang

require 'yaml'
require 'fileutils'

Vagrant.configure("2") do |config|

  config.vm.box = "debian/contrib-jessie64"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.network "private_network", ip: "192.168.77.77"

  config.vm.synced_folder ".", "/vagrant"

  # config.vm.provision :shell, path: "./v/provision/lamp.sh"

end
