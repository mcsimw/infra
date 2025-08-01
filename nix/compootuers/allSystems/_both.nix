{
  lib,
  pkgs,
  self,
  inputs',
  ...
}:
{
  imports = [
    self.modules.nixos.kakoune
  ];

  programs = {
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
    systemPackages =
      with pkgs;
      [
        npins
        btop
        unzip
        unrar
        p7zip
        texliveFull
        #inputs'.typst.packages.default
        typst
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
        nnn
        figlet
        cowsay
        toilet
        lolcat
      ]
      ++ [ inputs'.nixos-search.packages.default ];
  };

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos;
    zfs.package = lib.mkOverride 99 pkgs.zfs_cachyos;
  };

  networking = {
    networkmanager.enable = lib.mkForce false;
    wireless.enable = lib.mkForce false;
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
