Vagrant.configure(2) do |config|
  config.vm.box = "base"
  config.vm.synced_folder ".", "/var/www", create:true, owner: "www-data", group: "www-data", :mount_options => ["dmode=755", "fmode=644"]
  config.vm.network "public_network", ip: "192.168.1.200"
  config.vm.provision "shell", path: "up.sh"
  config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 2
  end
end