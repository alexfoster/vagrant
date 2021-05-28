# A minimal ubuntu 18.04 box with a few additional tools I use

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu1804"
  config.vm.provision :shell, :inline  => 'mkdir -p /home/vagrant/sync_folder'
  config.vm.synced_folder ".", "/home/vagrant/sync_folder", id: "vagrant-root", :mount_options => ["dmode=777","fmode=777"]
  config.ssh.forward_agent = true
  config.vm.provision :shell, path: "vagrant_setup.sh", privileged: false
end
