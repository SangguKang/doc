#!/bin/bash
#
# SRU BSP repository에서 build한 m-plane lib을 설치하는 script
#

tarball="mplane-lib.tar.gz"
if [ ! -r "$tarball" ]
then
    echo "$tarball not found"
    exit 1
fi

rm -rf include/ aarch64/rootfs/usr/local/
if tar xzf "$tarball"
then
    rm -f "$tarball"
    aarch64-linux-gnu-strip $(find aarch64/ -name '*.so*') >/dev/null 2>&1
fi

exit 0





