{ self, ... }:
{
  imports = [
    ./_hardware.nix
    self.modules.nixos.desktop
  ];

  programs.dwl.enable = true;

  system.stateVersion = "25.11";
}
