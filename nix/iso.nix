{ config, ... }:
let
  imports = [
    "${config.sources.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel.nix"
    config.flake.modules.nixos.iso
  ];
in
{
  configurations.nixos = {
    "iso-x86_64-linux" = {
      system = "x86_64-linux";
      usePkgsFromSystem = true;
      module =
        { lib, pkgs, ... }:
        {
          users.users.mcsimw.enable = true;
          networking.hostName = "iso-nixos-amd64";
          inherit imports;
          boot = {
            zfs.package = lib.mkForce pkgs.zfs_unstable;
            kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
          };
        };
    };
    "iso-aarch64-linux" = {
      system = "aarch64-linux";
      usePkgsFromSystem = true;
      module =
        { lib, pkgs, ... }:
        {
          users.users.mcsimw.enable = true;
          networking.hostName = "iso-nixos-aarch64";
          inherit imports;
          boot = {
            zfs.package = lib.mkForce pkgs.zfs_unstable;
            kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
          };
        };
    };
  };
}
