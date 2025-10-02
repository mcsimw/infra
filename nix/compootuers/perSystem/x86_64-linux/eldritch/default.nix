{ config, ... }:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    ./bootloader.nix
  ];

  analfabeta = {
    users.mcsimw.enable = true;
    programs.prismlauncher.enable = config.programs.niri.enable;
  };

  programs.steam.enable = config.programs.niri.enable;

}
