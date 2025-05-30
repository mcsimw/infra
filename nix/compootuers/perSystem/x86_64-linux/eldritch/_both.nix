{
  self,
  pkgs,
  system,
  inputs',
  ...
}:
{
  imports = [
    ./_hardware.nix
    self.modules.nixos.desktop
  ];

  myShit.desktop = {
    dwl.enable = true;
    hyprland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    obs-studio
    signal-desktop-bin
    telegram-desktop
    wireshark
    snort
    kdePackages.kdenlive
    (cataclysm-dda.override {
      tiles = false;
    })
    openmw
    torzu_git
    element-desktop
    inputs'.lem.packages.lem-sdl2
    inputs'.browser-previews.packages.google-chrome-dev
    emacs-igc-pgtk
    mangohud_git
  ];

  programs = {
    wireshark.enable = true;
    steam.enable = true;
  };

  networking.useNetworkd = true;

  system.stateVersion = "25.11";
}
