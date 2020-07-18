#!/bin/bash
# ConoHa VPS startup script
# Get systems ready to accept Ansible configuration

sed --in-place s/ONBOOT.*/ONBOOT=yes/ /etc/sysconfig/network-scripts/ifcfg-eth0 
systemctl restart network

yum install policycoreutils-python
semanage port -m -t ssh_port_t -p tcp 7
sed --in-place 's/^#Port.*/Port 7/' /etc/ssh/sshd_config
systemctl restart sshd
iptables -F

useradd ansible
usermod -G wheel ansible
echo "ansible:passwd"|chpasswd

mkdir -p ~ansible/.ssh
cp /root/.ssh/authorized_keys ~ansible/.ssh/
chown ansible:ansible ~ansible/.ssh/authorized_keys
