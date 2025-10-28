{
  lib,
  self,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ self.modules.nixos.analfabeta ];
  disabledModules = [ "hardware/facter/system.nix" ];

  system.rebuild.enableNg = true;

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos-lto;
    zfs.package = lib.mkOverride 99 pkgs.zfs_cachyos;
  };

  time.timeZone = lib.mkDefault "Canada/Eastern";

  i18n.defaultLocale = lib.mkDefault "en_CA.UTF-8";

  systemd = {
    services = {
      NetworkManager-wait-online.wantedBy = lib.mkForce [ ];
      systemd-networkd-wait-online.wantedBy = lib.mkForce [ ];
    };
    oomd = {
      enable = true;
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserSlices = true;
      settings.OOM.DefaultMemoryPressureDurationSec = "20s";
    };
  };

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "65536";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];

}
