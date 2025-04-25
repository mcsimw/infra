{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

lib.mkMerge [
  {
    services.blueman.enable = config.hardware.bluetooth.enable;

    environment.systemPackages = with pkgs; [
      inputs.nixpkgs.legacyPackages.${pkgs.system}.wlvncc
      pwvucontrol_git
      wl-clipboard-rs
      wmenu
      sway-contrib.grimshot
      slurp
      zathura
      swaybg
      mako
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      wlr.enable = true;
      config.common.default = [ "gtk" ];
    };

    programs = {
      dconf = {
        enable = true;
        profiles.user.databases = [
          {
            lockAll = true;
            settings = {
              "org/gnome/desktop/interface".color-scheme = "prefer-dark";
              "org/gnome/desktop/wm/preferences".button-layout = "";
            };
          }
        ];
      };
      foot = {
        enable = true;
        settings = {
          main = {
            font = "Spleen:size=12, Symbols Nerd Font Mono:size=9, Apple Color Emoji:size=9";
            "font-size-adjustment" = 6;
            pad = "40x40";
            "bold-text-in-bright" = "yes";
          };
          cursor.color = "ffffff cc0077";
          colors = {
            foreground = "ffffff";
            background = "000000";
            "selection-foreground" = "000000";
            "selection-background" = "cc0077";
            urls = "88ccff";
            regular0 = "000000";
            regular1 = "ee2a2a";
            regular2 = "00ff5f";
            regular3 = "ffdd00";
            regular4 = "2f8fff";
            regular5 = "ff5fae";
            regular6 = "00d7d7";
            regular7 = "d0d0d0";
            bright0 = "3a3a3a";
            bright1 = "ff5555";
            bright2 = "00ffaa";
            bright3 = "ffff66";
            bright4 = "7ab7ff";
            bright5 = "ff85d7";
            bright6 = "7fffff";
            bright7 = "ffffff";
            "16" = "ffae00";
            "17" = "ff7755";
          };
        };
      };
    };
  }

  (import ./wayland.nix)
]
