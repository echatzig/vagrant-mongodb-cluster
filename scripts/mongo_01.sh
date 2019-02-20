#!/usr/bin/env bash
mkdir -p /home/vagrant/.ssh
cp /vagrant/.ssh/* /home/vagrant/.ssh/
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/id_rsa
chmod 644 /home/vagrant/.ssh/id_rsa.pub

sudo chown vagrant:vagrant /home/vagrant/.ssh -R

cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys

sudo apt-get install -y mongodb

cp /vagrant/scripts/mongodb.conf /etc/mongodb.conf

sudo sed -i 's/bind_ip = .*/bind_ip = '$1'/' /etc/mongodb.conf
sudo sed -i 's/.*port = .*/port = 27017/' /etc/mongodb.conf

sudo service mongodb restart
sleep 5

if [ "$1" == "192.168.1.100" ]; 
then  
	echo "setting up the cluster"
	sudo mongo --host 192.168.1.100 < /vagrant/scripts/initreplica.js  

	echo "inserting some data"
	sudo mongo --host 192.168.1.100 < /vagrant/scripts/setdata.js  

	echo "now querying secondary member (101)"
	sudo mongo --host 192.168.1.101 < /vagrant/scripts/query.js  

	echo "now querying secondary member (102)"
	sudo mongo --host 192.168.1.102 < /vagrant/scripts/query.js  
	
fi

