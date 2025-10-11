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
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos-gcc;
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
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://chaotic-nyx.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://ghostty.cachix.org"
        "https://prismlauncher.cachix.org"
      ];
      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://chaotic-nyx.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://ghostty.cachix.org"
        "https://prismlauncher.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
      ];
    };
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
