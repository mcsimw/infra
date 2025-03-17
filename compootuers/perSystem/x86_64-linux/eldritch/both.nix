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
  system.stateVersion = "25.05";
  environment.systemPackages = with pkgs; [
    heroic
    zeroad
    mangohud
    gamescope
    obs-studio
    dolphin-emu
    zoom-us
  ];
  programs.steam = {
    enable = true;
    extest.enable = true;
  };
}
