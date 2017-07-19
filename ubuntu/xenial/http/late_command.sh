set -x
base=/target
echo $httpip
echo $httpport

# Mount /tmp as tmpfs
echo -e 'swap\t\t/tmp\ttmpfs\tsize=512m\t\t0\t0' >> ${base}/etc/fstab

# If you want packer to use ssh keys for auth instead of simple passwords you can do something like this
#mkdir -m 700 -p ${base}/root/.ssh
#wget http://${httpip}:${httpport}/post-scripts/authorized_keys -O ${base}/root/.ssh/authorized_keys -o /dev/null
#chown -R root:root ${base}/root/.ssh

echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' > ${base}/etc/sudoers.d/ubuntu
chmod 440 /etc/sudoers.d/ubuntu

exit 0
