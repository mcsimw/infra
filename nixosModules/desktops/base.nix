{
  inputs',
  pkgs,
  self',
}:
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
        self'.packages.gimp
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
	serif = [ "Inter" "Symbols Nerd Font" ];
	sansSerif = [ "Inter" "Symbols Nerd Font" ];
	monospace = [ "Cascadia Code" "Symbols Nerd Font Mono" ];
	emoji = [ "Apple Color Emoji" ];
      };
    };
    packages =
      [
        inputs'.apple-emoji-linux.packages.default
      ]
      ++ (with pkgs; [
        spleen
	cascadia-code
        vistafonts
        corefonts
        inter
        iosevka
        nerd-fonts.symbols-only
      ]);
  };
}
