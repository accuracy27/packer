#!/bin/bash
set -x
set -e

# Things only for aws
PACKER_PROVISIONERS="/tmp/provisioners"
PACKER_FILES="/tmp/provisioners/files"

# Block non-root calls to the AWS metadata service. Some webservices implicity proxy and this is often used by attackers.
iptables -A OUTPUT -m owner ! --uid-owner root -d 169.254.169.254 -j DROP
iptables-save > /etc/iptables/rules.v4

# Rebuild dm nodes
dmsetup mknodes
