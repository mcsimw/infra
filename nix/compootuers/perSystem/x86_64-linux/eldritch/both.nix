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
    signal-desktop-source
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
    wireshark.enable = true;
    steam.enable = true;
  };

  system.stateVersion = "25.05";
}
