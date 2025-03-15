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

  environment.systemPackages =
    [
      inputs'.browser-previews.packages.google-chrome-dev
    ]
    ++ (with pkgs; [
      mpv
      gimp
      krita
      inkscape
      ani-cli
    ]);

  fonts.packages = with pkgs; [
    spleen
  ];
}
