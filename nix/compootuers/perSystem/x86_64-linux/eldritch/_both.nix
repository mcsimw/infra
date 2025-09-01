{ self, ... }:
{
  imports = [
    ./_hardware.nix
    self.modules.nixos.desktop
  ];

  system.stateVersion = "25.11";
}
