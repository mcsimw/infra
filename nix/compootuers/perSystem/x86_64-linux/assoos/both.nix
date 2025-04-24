{
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware.nix
    self.nixosModules.cinnamon
  ];

  environment.systemPackages = with pkgs; [
    signal-desktop-bin
    telegram-desktop
  ];

  programs.steam.enable = true;

  system.stateVersion = "25.05";
}
