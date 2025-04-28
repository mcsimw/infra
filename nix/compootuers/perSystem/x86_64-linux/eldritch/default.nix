{ self, inputs, ... }:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
    inputs.home-manager.nixosModules.home-manager
  ];
  environment.variables.DOTFILES = "/mnt/nyx/.dotfiles";
}
