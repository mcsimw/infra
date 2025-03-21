{ self, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    self.nixosModules.dwl
  ];
  environment.systemPackages = with pkgs; [
    heroic
    zeroad
    mangohud
    gamescope
    obs-studio
    dolphin-emu
    zoom-us
    libreoffice-fresh
    dwarf-fortress
  ];
  programs = {
    steam = {
      enable = true;
      extest.enable = true;
    };
    wireshark.enable = true;
  };
  system.stateVersion = "25.05";
}
