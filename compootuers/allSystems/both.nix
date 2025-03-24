{
  lib,
  pkgs,
  self,
  inputs,
  inputs',
  ...
}:
{
  imports = [
    self.nixosModules.kakoune
    inputs.nyx.nixosModules.mesa-git
  ];

  programs = {
    tmux.enable = true;
    neovim.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  environment.systemPackages =
    with pkgs;
    [
      onefetch
      fastfetch
      btop
      unzip
      unrar
      p7zip
      texliveFull
      dysk
      wget
      ripgrep
      eza
      bat
      fd
      nethack
      neomutt
      file
      yt-dlp
      trash-cli
      nnn
      fzf
      cowsay
      figlet
      lolcat
      gay
      blahaj
      sl
      (cataclysm-dda.override { tiles = false; })
    ]
    ++ (with inputs'.disko.packages; [
      disko-install
      disko
    ])
    ++ [ inputs'.nixos-search.packages.default ];

  myShit.programs.kakoune = {
    enable = true;
    defaultEditor = true;
  };

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos;
    zfs.package = lib.mkOverride 99 pkgs.zfs_cachyos;
  };

  time.timeZone = lib.mkDefault "Canada/Eastern";

  security.sudo.wheelNeedsPassword = lib.mkDefault false;

  networking.useNetworkd = true;

  systemd.oomd.enable = lib.mkForce false; # https://github.com/systemd/systemd/pull/36718 Once this is merged to stable version of systemd, I will re-enable. For now, no condoms. I could fix it myself, but I'm lazy.

  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org" # nix-community
      "https://chaotic-nyx.cachix.org" # chaotic nyx
      "https://nixpkgs-wayland.cachix.org" # nixpkgs-wayland
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" # nix-community
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8" # chaotic nyx
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA=" # nixpkgs-wayland
    ];
  };

  services.openssh.enable = lib.mkDefault true;
}
