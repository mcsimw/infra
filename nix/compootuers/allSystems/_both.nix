{
  lib,
  pkgs,
  self,
  inputs',
  ...
}:
let
  parseINI =
    ini:
    let
      lines = lib.splitString "\n" ini;
      trim = s: lib.strings.trim s;
      step =
        state: line:
        let
          l = trim line;
        in
        if l == "" || lib.hasPrefix "#" l || lib.hasPrefix ";" l then
          state # Skip comments and empty lines
        else if lib.hasPrefix "[" l && lib.hasSuffix "]" l then
          state // { current = lib.removeSuffix "]" (lib.removePrefix "[" l); }
        else if builtins.match ".*=.*" l != null then
          let
            idx = builtins.match "([^=]*)=(.*)" l;
            key = trim (builtins.elemAt idx 0);
            val = trim (builtins.elemAt idx 1);
            sec = state.current;
            cur = state.${sec} or { };
          in
          if key != "" then
            state
            // {
              ${sec} = cur // {
                ${key} = val;
              };
            }
          else
            state
        else
          state;
      res = builtins.foldl' step { current = ""; } lines;
    in
    lib.removeAttrs res [ "current" ];
in
{
  imports = with self.modules.nixos; [
    kakoune
    bluetooth
  ];

  programs = {
    bat.enable = true;
    tmux.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    git = {
      enable = true;
      config = lib.mkMerge [
        (parseINI (builtins.readFile (self + "/git/gconfig.ini")))
        { core.excludesFile = lib.mkForce (toString (self + "/git/ignore_global")); }
      ];
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
