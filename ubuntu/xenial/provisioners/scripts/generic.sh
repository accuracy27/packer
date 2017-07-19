#!/bin/bash
set -e
set -x

# Things for every build

PACKER_PROVISIONERS="/tmp/provisioners"
PACKER_FILES="/tmp/provisioners/files"

# Setup Apt
export DEBIAN_FRONTEND=noninteractive
# This saves a lot of space from the resultant template
mount -t tmpfs none /var/cache/apt

# Explicity disable unattended upgrades
yes 2>&- | apt-get -y --force-yes --purge autoremove unattended-upgrades
rm -f /etc/apt/apt.conf.d/20auto-upgrades
rm -f /etc/apt/apt.conf.d/50unattended-upgrades

# Install packages
yes 2>&- | apt-get update
# Upgrade and install packages
yes 2>&- | apt-get -y --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
yes 2>&- | apt-get -y --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
  software-properties-common \
  ntp \
  git \
  bc \
  vim \
  zip \
  unzip \
  iptables \
  iptables-persistent \
  virt-what \
  curl \
  python-pip \
  at \
  dkms \
  mlock \
  sysstat \
  dc \
  gawk \
  default-jre-headless \
  ca-certificates-java \
  uuid-runtime \
  ethtool \
  parted \
  jq

apt-get autoclean
apt-get clean

# Take care of the remaining config files
cp $PACKER_FILES/issue /etc/
cp $PACKER_FILES/hosts /etc/
ln -sf /etc/issue /etc/issue.net

# System tunables
echo 'vm.swappiness = 1' >> /etc/sysctl.conf
echo 'kernel.sysrq = 0' >> /etc/sysctl.conf
echo 'kernel.kptr_restrict = 2' >> /etc/sysctl.conf
echo 'kernel.core_uses_pid = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.send_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.accept_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.log_martians = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.log_martians = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.accept_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.accept_source_route = 0' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_timestamps = 0' >> /etc/sysctl.conf
echo 'net.ipv6.conf.all.accept_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv6.conf.default.accept_redirects = 0' >> /etc/sysctl.conf
