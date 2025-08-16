{
  lib,
  pkgs,
  self,
  inputs',
  inputs,
  ...
}:
{
  imports = [
    self.modules.nixos.emacs
    self.modules.nixos.kakoune
    inputs.hjem.nixosModules.default
  ];

  programs = {
    emacs.enable = true;
    kakoune = {
      enable = true;
      defaultEditor = true;
    };
    bat.enable = true;
    tmux.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  environment = {
    variables.NIXPKGS_CONFIG = lib.mkForce "";
    systemPackages = import (self + "/nix/misc/_pkgs.nix") { inherit pkgs inputs'; };
  };

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos;
    zfs.package = lib.mkOverride 99 pkgs.zfs_cachyos;
  };

  networking = {
    networkmanager.enable = lib.mkForce false;
    wireless.enable = lib.mkForce false;
    useNetworkd = true;
  };

  time.timeZone = lib.mkDefault "Canada/Eastern";

  security.sudo.wheelNeedsPassword = lib.mkDefault false;

  systemd = {
    services.systemd-oomd.after = [ "swap.target" ]; # https://github.com/systemd/systemd/pull/36718 forever and a day :)
    oomd = {
      enable = true;
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserSlices = true;
      extraConfig.DefaultMemoryPressureDurationSec = "20s";
    };
  };

  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8"
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

  services = {
    openssh.enable = lib.mkDefault true;
    gpm.enable = lib.mkDefault true;
  };
}
