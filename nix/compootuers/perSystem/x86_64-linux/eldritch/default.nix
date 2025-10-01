{ config, ... }:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    ./bootloader.nix
  ];

  analfabeta = {
    users.mcsimw.enable = true;
    desktop.users.mcsimw = ./config.kdl;
    programs.prismlauncher.enable = config.analfabeta.desktop.enable;
  };

  programs.steam.enable = config.analfabeta.desktop.enable;

}
