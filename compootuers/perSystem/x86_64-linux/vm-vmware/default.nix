{ self, packages, ... }:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];
  users.users.mcsimw.packages = with packages; [ neovim foot ];
}
