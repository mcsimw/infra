{
  lib,
  pkgs,
  self,
  inputs',
  ...
}:
{
  imports = [
    self.modules.nixos.infra
  ];
  analfabeta.programs.kakoune = {
    enable = true;
    defaultEditor = true;
  };
  programs = {
    gnupg.agent = {
      enable = true;
      pinentryPackage = lib.mkDefault pkgs.pinentry-curses;
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
        typst
        dysk
        wget
        nethack
        unnethack
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
      ++ (with inputs'; [
        typst.packages.default
      ]);
  };

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos-rc;
    zfs.package = lib.mkOverride 99 pkgs.zfs_cachyos;
  };

  networking = {
    networkmanager.enable = lib.mkForce false;
    wireless.enable = lib.mkForce false;
    useNetworkd = true;
  };

  time.timeZone = lib.mkDefault "Canada/Eastern";
  i18n.defaultLocale = "en_CA.UTF-8";

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
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8"
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  services = {
    openssh.enable = lib.mkDefault true;
    gpm.enable = lib.mkDefault true;
  };
}
