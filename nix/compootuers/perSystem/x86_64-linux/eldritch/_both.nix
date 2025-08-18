{ self, ... }:
{
  imports = [
    ./_hardware.nix
    self.modules.nixos.desktop
  ];

  programs.niri.enable = true;

  system.stateVersion = "25.11";
}
