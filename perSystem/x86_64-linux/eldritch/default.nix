{ self, ... }:
{
  imports = [
    self.nixosModules.systemd-bootloader
    ./fileSystems.nix
  ];
  system.stateVersion = "25.05";
}
