{ self, ... }:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix

    self.nixosModules.systemd-bootloader
  ];
}
