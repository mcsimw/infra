{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    {
      inputs',
      pkgs,
      self',
      ...
    }:
    { config, lib, ... }:
    let
      cfg = config.analfabeta.desktop;
    in
    {
      options.analfabeta.desktop.enable = lib.mkEnableOption "niri";

      config = lib.mkIf cfg.enable {
        hardware.graphics = {
          enable = lib.mkForce true;
          enable32Bit = lib.mkForce true;
        };
        programs = {
          niri = {
            enable = true;
            package = inputs'.niri.packages.default;
          };
          foot.enable = true;
          dconf.profiles.user.databases = [
            {
              lockAll = true;
              settings = {
                "org/gnome/desktop/interface" = {
                  accent-color = "pink";
                  color-scheme = "prefer-dark";
                };
                "org/gnome/desktop/wm/preferences" = {
                  button-layout = "";
                };
              };
            }
          ];
        };
        environment.systemPackages = [
          inputs'.xwayland-satellite.packages.default
          self'.packages.mpv
        ]
        ++ (with pkgs; [
          mako
          wmenu
          (lib.mkIf config.services.pipewire.enable pwvucontrol_git)
          adwaita-icon-theme
          zathura
          imv
          wl-clipboard-rs
          (lib.mkIf config.programs.wireshark.enable wireshark)
        ]);
        services = {
          blueman.enable = lib.mkIf config.hardware.bluetooth.enable true;
          xserver.desktopManager.runXdgAutostartIfNone = lib.mkForce true;
          graphical-desktop.enable = lib.mkForce true;
          dbus.packages = [ pkgs.dconf ];
        };
        fonts = {
          enableDefaultPackages = lib.mkForce false;
          fontconfig = {
            useEmbeddedBitmaps = true;
            antialias = false;
            hinting = {
              enable = false;
              style = "none";
            };
            subpixel.lcdfilter = "none";
            defaultFonts = {
              serif = [
                "Fraunces"
                "Symbols Nerd Font"
              ];
              sansSerif = [
                "Inter Variable"
                "Symbols Nerd Font"
              ];
              monospace = [
                "Cascadia Code"
                "Symbols Nerd Font Mono"
              ];
              emoji = [ "Apple Color Emoji" ];
            };
          };
          packages = with pkgs; [
            spleen
            terminus_font
            nerd-fonts.symbols-only
            inputs'.apple-emoji-linux.packages.default
            inter
            fraunces
            (pkgs.cascadia-code.override { useVariableFont = true; })
            corefonts
            vista-fonts
          ];
        };
        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-gnome
          ];
          config = {
            common.default = [ "gtk" ];
            niri = {
              default = [
                "gnome"
                "gtk"
              ];
              "org.freedesktop.impl.portal.Access" = "gtk";
              "org.freedesktop.impl.portal.Notification" = "gtk";
              "org.freedesktop.portal.RemoteDesktop" = "none";
              "org.freedesktop.portal.Wallpaper" = "none";
            };
          };
        };
      };
    }
  );
}
