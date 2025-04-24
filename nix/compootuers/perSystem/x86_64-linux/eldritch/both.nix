{
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware.nix
    self.nixosModules.dwl
  ];
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
    torzu
    element-desktop
  ];
  programs.wireshark.enable = true;

  networking.useNetworkd = true;

  system.stateVersion = "25.05";
}
