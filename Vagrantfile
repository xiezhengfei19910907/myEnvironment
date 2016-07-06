Vagrant.configure(2) do |config|
  config.vm.box = "base"
  config.vm.synced_folder ".", "/var/www"
  config.vm.network "public_network", ip: "192.168.1.200"
  config.vm.network "private_network", ip: "192.168.56.100" 
  config.vm.provision "shell", path: "up.sh"
  config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 2
  end
end