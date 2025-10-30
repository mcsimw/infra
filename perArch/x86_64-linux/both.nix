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

  boot.zfs.package = lib.mkOverride 99 (
    if lib.hasInfix "cachyos" (config.boot.kernelPackages.kernel.pname or "") then
      pkgs.zfs_cachyos
    else
      pkgs.zfs
  );
}
