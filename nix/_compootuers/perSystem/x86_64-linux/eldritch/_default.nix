{ config, ... }:
{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
    ./_bootloader.nix
  ];

  analfabeta = {
    users.mcsimw.enable = true;
    desktop.users.mcsimw = ./config.kdl;
    programs.prismlauncher.enable = config.analfabeta.desktop.enable;
  };

  programs.steam.enable = config.analfabeta.desktop.enable;

}
