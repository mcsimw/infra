#!/usr/bin/env bash
zpool import nyx

mount --mkdir -t zfs nyx/faketmpfs /mnt -o zfsutil

for subdir in nix tmp persist; do
    mount --mkdir -t zfs nyx/$subdir /mnt/$subdir -o zfsutil
done

mount --mkdir -t vfat -o dmask=0022,fmask=0022,umask=0077 \
    /dev/disk/by-partuuid/1842a05b-a2fa-4e8e-aa1c-a21d684f7087 \
    /mnt/boot

sudo nixos-install --no-channel-copy --no-root-passwd --flake ".#eldritch"
