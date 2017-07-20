#!/bin/bash
set -x
set -e

# Things only for virtualbox
PACKER_PROVISIONERS="/tmp/provisioners"
PACKER_FILES="/tmp/provisioners/files"

cp $PACKER_FILES/99_local.cfg /etc/cloud/cloud.cfg.d/
