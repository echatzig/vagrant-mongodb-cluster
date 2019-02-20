Vagrant.configure("2") do |config|
  config.vm.box = 'debian/stretch64'

  config.vm.define "mongo_03" do |subconfig|
    subconfig.vm.network "public_network", ip: "192.168.1.102", type: "static", bridge: ["Intel(R) Ethernet Connection I218-LM", "eth0"]
    subconfig.vm.provider "virtualbox" do |v|
      v.memory = 512
    end
    subconfig.vm.provision :shell, path: "./scripts/mongo_01.sh", args: ["192.168.1.102"]
  end

  config.vm.define "mongo_02" do |subconfig|
    subconfig.vm.network "public_network", ip: "192.168.1.101", type: "static", bridge: ["Intel(R) Ethernet Connection I218-LM", "eth0"]
    subconfig.vm.provider "virtualbox" do |v|
      v.memory = 512
    end
    subconfig.vm.provision :shell, path: "./scripts/mongo_01.sh", args: ["192.168.1.101"]
  end

  config.vm.define "mongo_01" do |subconfig|
    subconfig.vm.network "public_network", ip: "192.168.1.100", type: "static", bridge: ["Intel(R) Ethernet Connection I218-LM", "eth0"]
    subconfig.vm.provider "virtualbox" do |v|
      v.memory = 512
    end
    subconfig.vm.provision :shell, path: "./scripts/mongo_01.sh", args: ["192.168.1.100"]
  end

  
end
