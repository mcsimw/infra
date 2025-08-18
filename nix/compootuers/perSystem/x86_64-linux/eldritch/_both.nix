{ self, ... }:
{
  imports = [
    ./_hardware.nix
    self.modules.nixos.desktop
  ];

  analfabeta.desktop = "niri";

  system.stateVersion = "25.11";
}
