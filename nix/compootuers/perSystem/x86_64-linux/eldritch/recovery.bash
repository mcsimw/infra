#!/usr/bin/env bash

zpool import nyx

mount --mkdir -t zfs nyx/faketmpfs /mnt -o zfsutil
mount --mkdir -t zfs nyx/nix /mnt/nix -o zfsutil
mount --mkdir -t zfs nyx/tmp /mnt/tmp -o zfsutil
mount --mkdir -t zfs nyx/persist /mnt/persist -o zfsutil
mount --mkdir -t vfat -o dmask=0022,fmask=0022,umask=0077 /dev/disk/by-partuuid/1842a05b-a2fa-4e8e-aa1c-a21d684f7087 /mnt/boot

sudo nixos-install --no-channel-copy --no-root-passwd --flake ".#eldritch
