{
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];
  hardware.xpadneo.enable = true;
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
