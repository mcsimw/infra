{ self, ... }:
{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
    self.modules.nixos.systemd-bootloader
  ];
  environment.variables.DOTFILES = "/mnt/nyx/.dotfiles";
}
