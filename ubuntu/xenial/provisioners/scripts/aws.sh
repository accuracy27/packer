#!/bin/bash
set -x
set -e

# Things only for aws

yes 2>&- | apt-get -y --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
  cloud-init

# Block non-root calls to the AWS metadata service. Some webservices implicity proxy and this is often used by attackers.
iptables -A OUTPUT -m owner ! --uid-owner root -d 169.254.169.254 -j DROP
iptables-save > /etc/iptables/rules.v4

# Rebuild dm nodes
dmsetup mknodes
