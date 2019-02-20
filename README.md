# MongoDB cluster

Deploys a postgres cluster with 3 servers, one master and two slaves.
Creates a Vagrant environment running MongoDB 3.2.11 cluster.

### Tools deployed
* mongodb

Tools used in preparation
* Vagrant
* Virtualbox


### How to run:

Clone the project
```
git clone https://github.com/echatzig/vagrant-mongodb-cluster.git
```
 
Go to the folder that you just checkout and run the following commands:
```
mkdir .ssh
chmod 700 .ssh
ssh-keygen -f .ssh/id_rsa 
```
To make things easy ignore the passphrase

and finally run
```
vagrant up
```

### Notes

The mongodb config file is mostly using the default settings. The only noticable settings
are the listen IP (which we set to the public IP) and the replication set name.

### To verify

The deployment includes a test that verifies replication is properly setup.
What it does is that it inserts a few rows in the primary (192.168.0.100)
and then connects to the secondaries (192.168.0.101 & 192.168.0.102) and 
queries the data.

to set data we use the below:

```
use exampleDB
for (var i = 0; i <= 10; i++) db.exampleCollection.insert( { x : i } )
```

To test this, connect to the mongo shell on one of your secondary members, and run:
```
db.getMongo().setSlaveOk()	
```

This command enables secondary member read operations on a per-connection basis.
By default, read queries are not allowed on secondary members.

Now that you’ve enabled reading, switch to the exampleDB database:
```
use exampleDB
```

Next, run a find() method with no arguments to show all documents in exampleCollection:
```
db.exampleCollection.find()
```
If replication is working, we see a list of the sample documents we created on the primary host.
