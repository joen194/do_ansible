#!/usr/bin/env bash
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible sshpass

ln -sf /vagrant/hosts /etc/ansible/hosts


KNOW_HOSTS_FILE="/home/vagrant/.ssh/known_hosts"

[ -f "$KNOW_HOSTS_FILE" ] && rm $KNOW_HOSTS_FILE 

ssh-keyscan 192.168.2.3 >> $KNOW_HOSTS_FILE 
ssh-keyscan 192.168.2.4 >> $KNOW_HOSTS_FILE
ssh-keyscan 192.168.2.5 >> $KNOW_HOSTS_FILE
ssh-keyscan 192.168.2.6 >> $KNOW_HOSTS_FILE
chown vagrant:vagrant $KNOW_HOSTS_FILE 


# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL

# vagrant environment nodes
192.168.2.6  mgr
192.168.2.5  lb
192.168.2.3  www1SS
192.168.2.4  www2
EOL
