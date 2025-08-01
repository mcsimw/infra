{ self, ... }:
{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
    self.modules.nixos.systemd-bootloader
    self.modules.nixos.aliases
  ];

  analfabeta.rebuilder = {
    enable = true;
    dotfiles = /mnt/nyx/infra;
  };
}
