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
          uwsm = {
            enable = true;
            waylandCompositors.niri = {
              prettyName = "Niri";
              comment = "Niri compositor managed by UWSM";
              # https://github.com/YaLTeR/niri/issues/254
              binPath = pkgs.writeShellScript "niri" ''
                ${lib.getExe config.programs.niri.package} --session
              '';
            };
          };
          niri = {
            enable = true;
            package = inputs'.niri.packages.default;
          };
          foot.enable = true;
          dconf = {
            enable = true;
            profiles.user.databases = [
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
        };
        qt.enable = true;
        environment.systemPackages = [
          inputs'.xwayland-satellite.packages.default
          inputs'.browser-previews.packages.google-chrome-dev
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
            subpixel = {
              lcdfilter = "none";
              rgba = "none";
            };
            defaultFonts = {
              serif = [
                "Fraunces"
                "Apple Color Emoji"
                "Noto Sans Symbols"
                "Symbols Nerd Font"
              ];
              sansSerif = [
                "Inter Variable"
                "Apple Color Emoji"
                "Noto Sans Symbols"
                "Symbols Nerd Font"
              ];
              monospace = [
                "Cascadia Code"
                "Apple Color Emoji"
                "Noto Sans Symbols"
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
            noto-fonts
            noto-fonts-color-emoji
            noto-fonts-cjk-serif
            noto-fonts-cjk-sans
            noto-fonts-lgc-plus
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
