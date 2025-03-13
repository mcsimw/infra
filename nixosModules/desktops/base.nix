{ inputs, self, ... }:
{ pkgs, ... }:
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
      package = inputs.flake-firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
    };
  };
  environment.systemPackages =
    (with self.packages.${pkgs.system}; [ google-chrome ])
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
