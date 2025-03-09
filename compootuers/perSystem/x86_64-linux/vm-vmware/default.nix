{ self, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./fileSystems.nix
    ./users.nix
    self.nixosModules.systemd-bootloader
  ];
}
