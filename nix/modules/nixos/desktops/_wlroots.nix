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

    environment = {
      systemPackages = with pkgs; [
        inputs.nixpkgs.legacyPackages.${pkgs.system}.wlvncc
        pwvucontrol_git
        wl-clipboard-rs
        wmenu
        sway-contrib.grimshot
        slurp
        zathura
        swaybg
        mako
        imv
      ];
      #      etc."xdg/foot/foot.ini".source = lib.mkForce (builtins.toPath "${self}/foot/foot.ini");
    };

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
      foot.enable = true;
    };
  }
  (import ./_wayland.nix)
]
