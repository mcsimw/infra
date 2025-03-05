{ self, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];
}
