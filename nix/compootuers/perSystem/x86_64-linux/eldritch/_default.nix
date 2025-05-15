{ self, ... }:
{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
    self.modules.nixos.systemd-bootloader
    self.modules.nixos.aliases
  ];

  myShit.rebuilder = {
    enable = true;
    dotfiles = /mnt/nyx/.dotfiles;
  };
}
