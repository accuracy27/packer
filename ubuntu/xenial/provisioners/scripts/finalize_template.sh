#!/bin/bash
 
set -x
set -e

#### Cleanup
# Clean up apt
apt-get -y autoremove
apt-get autoclean
apt-get clean

# Lock ubuntu
passwd --delete ubuntu

# Cleanup ssh
shred -u /etc/ssh/*key* || true
shred -u /root/.ssh/* || true
shred -u ~ubuntu/.ssh/* || true
 
## Remove state related things
rm /var/lib/dhcp/*
rm -rf /dev/.udev
rm -f /lib/udev/rules.d/75-persistent-net-generator.rules
rm -f /etc/udev/rules.d/70*
cat /dev/null > /var/log/wtmp 2>/dev/null
logrotate -f /etc/logrotate.conf 2>/dev/null
find /var/log -type f -name '*.gz' -exec rm {} \;
find /var/log -type f | while read f; do > $f; done

# Clean up cloud-init
rm -Rf /var/lib/cloud/data/*
rm -Rf /var/lib/cloud/seed/*
rm -f /var/lib/cloud/instance
rm -Rf /var/lib/cloud/instances/*

# set the hostname and other interface stuff
echo $PACKER_BUILD_NAME > /etc/hostname
hostname -F /etc/hostname

## Clean up tmp dirs
rm -rf /var/cache/* || true
rm -rf /var/tmp/* || true
rm -rf /tmp/* || true

# Clear the shell history
history -c
unset HISTFILE
shred -u /root/.*history || true
shred -u ~ubuntu/.*history || true
shred -u ~packer/.*history || true
history -w
history -c
