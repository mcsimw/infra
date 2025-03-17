{ inputs', pkgs }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs = {
    dconf.enable = true;
    firefox = {
      enable = true;
      package = inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
    };
  };

  environment = {
    systemPackages =
      [
        inputs'.browser-previews.packages.google-chrome-dev
      ]
      ++ (with pkgs; [
        mpv
        #        krita
        inkscape
        ani-cli
        nautilus
      ]);
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      hinting.enable = false;
      defaultFonts = {
        serif = [ "Inter" ];
        sansSerif = [ "Inter" ];
        monospace = [ "Ubuntu Mono" ];
      };
    };
    packages = with pkgs; [
      spleen
      vistafonts
      corefonts
      inter
      iosevka
    ];
  };
}
