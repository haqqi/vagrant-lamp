#@IgnoreInspection BashAddShebang

require 'yaml'
require 'fileutils'


config = {
  local: './_setup/config/vm-config.yml',
  sample: './_setup/config/vm-config.sample.yml'
}

# copy config from example if local config not exists
FileUtils.cp config[:sample], config[:local] unless File.exist?(config[:local])
# read config
options = YAML.load_file config[:local]

# check github token
if options['github_token'].nil? || options['github_token'].to_s.length != 40
  puts "You must place REAL GitHub token into configuration:\n/_setup/config/vm-config.yml"
  exit
end

Vagrant.configure("2") do |config|

  # use debian for better server
  config.vm.box = "debian/contrib-jessie64"

  # should we ask about box updates?
  config.vm.box_check_update = options['box_check_update']

  config.vm.provider 'virtualbox' do |vb|
    # machine cpus count
    vb.cpus = options['cpus']
    # machine memory size
    vb.memory = options['memory']
    # machine name (for VirtualBox UI)
    vb.name = options['machine_name']
  end

  # machine name (for vagrant console)
  config.vm.define options['machine_name']

  # machine name (for guest machine console)
  config.vm.hostname = options['machine_name']

  config.vm.network "forwarded_port", guest: 80, host: 8080

  # network settings
  config.vm.network 'private_network', ip: options['ip']

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision :shell, path: "./_setup/provision/lamp.sh"

end
