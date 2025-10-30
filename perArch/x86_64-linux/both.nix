{
  lib,
  pkgs,
  config,
  ...
}:
{
  hardware = {
    cpu.x86.msr.enable = true;
    graphics = {
      package = lib.mkForce pkgs.mesa_git;
      package32 = lib.mkForce pkgs.mesa32_git;
    };
  };

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos-lto;
    zfs.package = lib.mkOverride 99 (
      if config.boot.kernelPackages ? cachyOverride then pkgs.zfs_cachyos else pkgs.zfs
    );
  };
}
