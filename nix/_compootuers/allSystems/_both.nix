{
  lib,
  pkgs,
  self,
  inputs',
  inputs,
  config,
  ...
}:
{
  imports = [ self.modules.nixos.analfabeta ];
  system.rebuild.enableNg = true;
  analfabeta.programs.kakoune = {
    enable = true;
    defaultEditor = true;
  };
  programs = {
    gnupg.agent = {
      enable = true;
      pinentryPackage = lib.mkDefault pkgs.pinentry-curses;
    };
    tmux.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    wireshark.enable = lib.mkDefault true;
    direnv = {
      enable = lib.mkDefault true;
      silent = lib.mkDefault true;
    };
    command-not-found.enable = lib.mkForce false;
    fuse.userAllowOther = true;
    git = {
      enable = lib.mkForce true;
      lfs.enable = lib.mkDefault true;
    };
    nano.enable = lib.mkForce false;
  };

  documentation = lib.genAttrs [ "doc" "nixos" "info" ] (_: {
    enable = lib.mkForce false;
  });

  environment = {
    defaultPackages = [ ];
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
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = lib.mkForce false;
      wifi.powersave = lib.mkDefault false;
    };
    wireless = {
      enable = lib.mkForce false;
    };
    useNetworkd = lib.mkDefault true;
  };

  time.timeZone = lib.mkDefault "Canada/Eastern";

  i18n = {
    defaultLocale = lib.mkDefault "en_CA.UTF-8";
    extraLocaleSettings.LC_TIME = lib.mkDefault "C.UTF-8";
  };

  security = {
    polkit.enable = lib.mkDefault true;
    rtkit.enable = lib.mkDefault true;
    sudo = {
      wheelNeedsPassword = lib.mkDefault false;
      execWheelOnly = lib.mkForce true;
    };
  };

  xdg.portal.xdgOpenUsePortal = lib.mkDefault true;
  users.mutableUsers = lib.mkForce false;

  systemd = {
    services = {
      systemd-oomd.after = [ "swap.target" ]; # https://github.com/systemd/systemd/pull/36718 forever and a day :)
      NetworkManager-wait-online.wantedBy = lib.mkForce [ ];
    };
    oomd = {
      enable = true;
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserSlices = true;
      extraConfig.DefaultMemoryPressureDurationSec = "20s";
    };
  };

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    channel.enable = false;
    settings = {
      auto-allocate-uids = true;
      trusted-users = [ "@wheel" ];
      allowed-users = lib.mapAttrsToList (_: u: u.name) (
        lib.filterAttrs (_: user: user.isNormalUser) config.users.users
      );
      "flake-registry" = "/etc/nix/registry.json";
      warn-dirty = false;
      keep-derivations = true;
      keep-outputs = true;
      accept-flake-config = false;
      allow-import-from-derivation = false;
      builders-use-substitutes = true;
      use-xdg-base-directories = true;
      use-cgroups = true;
      log-lines = 30;
      keep-going = true;
      connect-timeout = 5;
      sandbox = true;
      http-connections = 0;
      max-substitution-jobs = 128;
      system-features = [ "uid-range" ];
      extra-experimental-features = [
        "nix-command"
        "flakes"
        "cgroups"
        "auto-allocate-uids"
        "fetch-closure"
        "dynamic-derivations"
        "pipe-operators"
        "recursive-nix"
      ];
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
  };

  services = {
    openssh.enable = lib.mkDefault true;
    gpm.enable = lib.mkDefault true;
    pulseaudio.enable = lib.mkForce false;
    udisks2.enable = lib.mkDefault true;
    dbus.implementation = lib.mkForce "broker";
    userborn.enable = lib.mkForce true;
  };
}
