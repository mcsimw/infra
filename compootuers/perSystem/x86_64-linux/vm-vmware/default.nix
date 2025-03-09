{ self, ... }:
{
  imports = [
    ./conf.nix
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
    self.mcsimwModules.git
  ];
}
