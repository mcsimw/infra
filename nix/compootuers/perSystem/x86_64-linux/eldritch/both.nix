{
  self,
  pkgs,
  inputs',
  ...
}:
{
  imports = [
    ./hardware.nix
    self.nixosModules.dwl
  ];
  environment.systemPackages = with pkgs; [
    obs-studio
    libreoffice-fresh
    signal-desktop-bin
    telegram-desktop_git
    heroic
    wireshark
    adwaita-icon-theme
    snort
    kdePackages.kdenlive
    (cataclysm-dda.override {
      tiles = false;
    })
  ];
  programs = {
    hyprland = {
      enable = true;
      package = inputs'.hyprland.packages.hyprland;
      portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
    };
    wireshark.enable = true;
    steam.enable = true;
    starship.enable = true;
  };

  system.stateVersion = "25.05";
}
