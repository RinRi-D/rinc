#!/bin/bash

# prepare rootfs as a mounted loop device. assuming alpine.tar is prepared. assuming rootfs is not mounted already.
dd if=/dev/zero of=alpine.img bs=1G count=1
mkfs.ext4 alpine.img
mkdir rootfs
sudo mount -o loop alpine.img rootfs
sudo chown -R rinri:rinri rootfs
tar xf alpine.tar -C rootfs

# run the container
env - unshare -U -p -m --mount-proc -C -n -r -f -R rootfs /bin/sh
