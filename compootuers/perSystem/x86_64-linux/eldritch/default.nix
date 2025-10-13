{ config, ... }:
let
  niri = config.programs.niri.enable;
in
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    ./bootloader.nix
  ];

  programs = {
    steam.enable = niri;
    prismlauncher.enable = niri;
  };
}
