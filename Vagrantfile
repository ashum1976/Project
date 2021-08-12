## -*- mode: ruby -*-
# vim: set ft=ruby :
# -*- mode: ruby -*-
# vim: set  ft=ruby :

MACHINES = {

:firewall =>
            {
        :box_name => "centos/8",
        :net => [
                   {ip: '192.168.6.3', adapter: 2, netmask: "255.255.255.240", virtualbox__extnet: "ext_net"},
                   {ip: '192.168.3.14', adapter: 3, netmask: "255.255.255.240", virtualbox__intnet: "proj_net"},
                ]
  },
#  :srvmysql => {
#          :box_name => "centos/8",
#          :net => [
#                     {ip: '192.168.3.7', adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "proj_net"},
#                  ]
#    },
#
#  :backupmysql => {
#          :box_name => "centos/8",
#          :net => [
#                     {ip: '192.168.3.8', adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "proj_net"},
#                  ]
#    },

:srvweb => {
        :box_name => "centos/8",
        :net => [
                   {ip: '192.168.3.5', adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "proj_net"},
                ]
},
:srvbam =>
            {
        :box_name => "centos/8",
        :net => [
                   {ip: '192.168.3.6', adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "proj_net"},
                ]
},

}

Vagrant.configure("2") do |config|

    if Vagrant.has_plugin?("vagrant-timezone")
      config.timezone.value = "Europe/Minsk"
    end

    config.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--audio", "none", "--memory", "512", "--cpus", "1" ]
    end

  MACHINES.each do |boxname, boxconfig|
    config.vm.synced_folder "./", "/vagrant", type: "rsync", rsync__auto: true, rsync__exclude: ['./hddvm, README.md']
    config.vm.define boxname do |box|
        box.vm.provider "virtualbox" do |v|
            if boxname.to_s == "srvmysql"
              v.customize ["modifyvm", :id, "--audio", "none", "--memory", "2048", "--cpus", "1" ]
            end
            if boxname.to_s == "srvbam"
              v.customize ["modifyvm", :id, "--audio", "none", "--memory", "4096", "--cpus", "2" ]
            end
        end

        box.vm.box = boxconfig[:box_name]
          box.vm.host_name = boxname.to_s

        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end

      if boxname.to_s == "srvmysql"

        box.vm.provision "shell", inline: <<-SHELL
          mkdir -p ~root/.ssh
          cp ~vagrant/.ssh/auth* ~root/.ssh
          sed -i.bak 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
          systemctl restart sshd
          dnf config-manager --set-enabled powertools
	        dnf -y --nogpgcheck install python39 epel-release
	        dnf -y --nogpgcheck install sshpass
	        pip3 install ansible pyOpenSSL
        SHELL

         box.vm.provision :ansible_local do |ansible|
          # ansible.galaxy_role_file = 'requirements.yml'
	        ansible.compatibility_mode = '2.0'
	        ansible.verbose = "vv"
        # ansible.install = "true"
	        ansible.install = "false"
          ansible.tags = boxname.to_s
          ansible.inventory_path = "./ansible/inventory/"
          ansible.playbook = "./ansible/playbooks/project.yml"
        end
      else
          box.vm.provision "shell", inline: <<-SHELL
          mkdir -p ~root/.ssh
          cp ~vagrant/.ssh/auth* ~root/.ssh
          sed -i.bak 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
          systemctl restart sshd
          dnf config-manager --set-enabled powertools
          dnf -y --nogpgcheck install epel-release
	        dnf -y --nogpgcheck install sshpass
	        # pip3 install ansible pyOpenSSL wheel
        SHELL

         box.vm.provision :ansible_local do |ansible|
          # ansible.galaxy_role_file = 'requirements.yml'
	        ansible.compatibility_mode = '2.0'
	        ansible.verbose = "vv"
          ansible.install = "true"
	        # ansible.install = "false"
          ansible.tags = boxname.to_s
          ansible.inventory_path = "./ansible/inventory/"
          ansible.playbook = "./ansible/playbooks/project.yml"

        end
      end
    end
  end
end
