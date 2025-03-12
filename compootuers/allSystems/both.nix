{
  lib,
  pkgs,
  self,
  inputs',
  ...
}:
{
  imports = [
    self.nixosModules.kakoune
  ];
  programs.tmux.enable = true;
  environment.systemPackages = with pkgs; [
    onefetch
    fastfetch
    btop
    unzip
    unrar
    p7zip
    texliveFull
    dysk
    wget
  ];
  lemon.programs.kakoune = {
    enable = true;
    defaultEditor = true;
  };
  boot = {
    kernelPackages = lib.mkDefault inputs'.nyx.legacyPackages.linuxPackages_cachyos;
    zfs.package = lib.mkOverride 99 inputs'.nyx.packages.zfs_cachyos;
  };
  time.timeZone = lib.mkDefault "Canada/Eastern";
  security.sudo.wheelNeedsPassword = lib.mkDefault false;
  networking.useNetworkd = true;
  systemd.oomd.enable = lib.mkForce false;
  nix.settings = {
    substituters = [
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
}
