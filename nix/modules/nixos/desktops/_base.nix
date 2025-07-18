{
  self',
  pkgs,
  inputs',
  lib,
  config,
  ...
}:
{
  security.rtkit.enable = true;

  services = {
    graphical-desktop.enable = lib.mkForce true;
    dbus.packages = [ pkgs.dconf ];
    pipewire = {
      enable = lib.mkForce true;
      jack.enable = lib.mkDefault true;
      alsa = {
        enable = lib.mkDefault true;
        support32Bit = lib.mkDefault true;
      };
      pulse.enable = lib.mkDefault true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };

  hardware.graphics = {
    enable = lib.mkForce true;
    enable32Bit = lib.mkForce true;
  };

  environment = {
    variables = {
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = 1;
      MOZ_WEBRENDER = 1;
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland";
      #        QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = 1;
    };
    systemPackages =
      (with self'.packages; [
        nyxt
      ])
      ++ (with inputs'; [
        browser-previews.packages.google-chrome-dev
        flake-firefox-nightly.packages.firefox-nightly-bin
      ])
      ++ (with pkgs; [
        adwaita-icon-theme
        self'.packages.mpv
        inkscape
        gimp3
        wl-clipboard-rs
        pwvucontrol_git
        xorg.xeyes
        ghostty
      ])
      ++ (lib.optional config.programs.wireshark.enable pkgs.wireshark);
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
          "Georgia"
          "Symbols Nerd Font"
        ];
        sansSerif = [
          "Verdana"
          "Symbols Nerd Font"
        ];
        monospace = [
          "Comic Code Ligatures"
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
      (pkgs.cascadia-code.override { useVariableFont = true; })
    ];
  };
}
