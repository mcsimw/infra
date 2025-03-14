{ config, lib, ... }:

lib.concatLists [
  (lib.optional config.virtualisation.libvirtd.enable "libvirtd")
  (lib.optional config.networking.networkmanager.enable "networkmanager")
  (lib.optional config.programs.light.enable "video")
  (lib.optional config.programs.adb.enable "adbusers")
  (lib.optional config.virtualisation.docker.enable "docker")
  (lib.optional config.services.pipewire.enable "audio")
]
