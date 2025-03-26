{ self, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    self.nixosModules.dwl
  ];
  environment.systemPackages = with pkgs; [
    obs-studio
    zoom-us
    libreoffice-fresh
    vesktop
    signal-desktop
  ];
  programs.wireshark.enable = true;
  system.stateVersion = "25.05";
}
