#!/bin/bash
set -e

version=4.3.4
wget -q -N -P /tmp/ "https://s3.amazonaws.com/cntrm-build-assets/ixgbevf-${version}.tar.gz"
tar -xzf /tmp/ixgbevf-${version}.tar.gz
mv ixgbevf-${version} /usr/src/

cat <<EOT | tee /usr/src/ixgbevf-${version}/dkms.conf
PACKAGE_NAME="ixgbevf"
PACKAGE_VERSION="${version}"
CLEAN="cd src/; make clean"
MAKE="cd src/; make BUILD_KERNEL=\${kernelver}"
BUILT_MODULE_LOCATION[0]="src/"
BUILT_MODULE_NAME[0]="ixgbevf"
DEST_MODULE_LOCATION[0]="/updates"
DEST_MODULE_NAME[0]="ixgbevf"
AUTOINSTALL="yes"
EOT

dkms add -m ixgbevf -v ${version}
dkms build -m ixgbevf -v ${version}
dkms install -m ixgbevf -v ${version}
update-initramfs -c -k all

echo "options ixgbevf InterruptThrottleRate=1,1,1,1,1,1,1,1" | tee /etc/modprobe.d/ixgbevf.conf
modinfo ixgbevf
