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
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages =
      (with self'.packages; [
        nyxt
      ])
      ++ (with inputs'; [
        ghostty.packages.default
        browser-previews.packages.google-chrome-dev
      ])
      ++ (with pkgs; [
        adwaita-icon-theme
        self'.packages.mpv
        inkscape
        gimp3
        pulsemixer
        wl-clipboard-rs
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
