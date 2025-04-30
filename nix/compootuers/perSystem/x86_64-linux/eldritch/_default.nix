{ self, inputs, ... }:
{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
    self.nixosModules.systemd-bootloader
    inputs.home-manager.nixosModules.home-manager
  ];
  environment.variables.DOTFILES = "/mnt/nyx/.dotfiles";
}
