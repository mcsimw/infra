{
  lib,
  self,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ self.modules.nixos.analfabeta ];

  system.rebuild.enableNg = true;

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos-lto;
    zfs.package = lib.mkOverride 99 pkgs.zfs_cachyos;
  };

  time.timeZone = lib.mkDefault "Canada/Eastern";

  i18n.defaultLocale = lib.mkDefault "en_CA.UTF-8";

  systemd = {
    services = {
      systemd-oomd.after = [ "swap.target" ]; # https://github.com/systemd/systemd/pull/36718 forever and a day :) REMOVE ON SYSTEMD V258 RELEASE IN NIXOS
      NetworkManager-wait-online.wantedBy = lib.mkForce [ ];
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
