{ self, ... }:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];
  environment.variables.DOTFILES = "/mnt/nyx/.dotfiles";
}
