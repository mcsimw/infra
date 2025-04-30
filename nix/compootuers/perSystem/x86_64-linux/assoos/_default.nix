{ self, ... }:
{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];
}
