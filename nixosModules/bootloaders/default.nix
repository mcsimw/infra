{ self, lib, ... }:
{
  flake.nixosModules = {
    systemd-bootloader = ./systemd-bootloader.nix;
    lanaboote = lib.modules.importApply ./lanzaboote.nix { inherit self; };
    efi-packages = ./efi-packages.nix;
  };
}
