# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set the IP address at which the virtual machine will be exposed
IP_ADDRESS = "192.168.33.10"

Vagrant.configure('2') do |config|

  # Use the official trusty image
  config.vm.box = "ubuntu/trusty64"

  # Provision the VM with the latest stable version of Docker
  config.vm.provision :shell, path: 'provision.sh'

  # Expose the virtual host on port
  config.vm.network "private_network", ip: IP_ADDRESS
end
