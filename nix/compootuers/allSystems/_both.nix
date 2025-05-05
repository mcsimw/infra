{
  lib,
  pkgs,
  self,
  inputs',
  ...
}:
{
  imports = with self.modules.nixos; [
    kakoune
    bluetooth
  ];

  programs = {
    bat.enable = true;
    bash.interactiveShellInit = ''source ${self}/bash/functions.bash'';
    tmux.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    git = {
      enable = true;
      config.init.defaultBranch = lib.mkDefault "master";
    };
  };

  environment.systemPackages =
    with pkgs;
    [
      btop
      unzip
      unrar
      p7zip
      texliveFull
      inputs'.typst.packages.default
      dysk
      wget
      nethack
      neomutt
      file
      yt-dlp_git
      shpool
      exfatprogs
      amfora
      parted
      cryptsetup
      btrfs-progs
      xfsprogs
      f2fs-tools
      rsync
      entr
      xdg-user-dirs
      openvi
      pandoc
      sc-im
      onefetch
      fastfetch
      eza
      ripgrep
      fd
    ]
    ++ [ inputs'.nixos-search.packages.default ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos;
    zfs.package = lib.mkOverride 99 pkgs.zfs_cachyos;
  };

  time.timeZone = lib.mkDefault "Canada/Eastern";

  security.sudo.wheelNeedsPassword = lib.mkDefault false;

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

  services = {
    openssh.enable = lib.mkDefault true;
    gpm.enable = lib.mkDefault true;
  };
}
