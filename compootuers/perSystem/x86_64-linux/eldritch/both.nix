{ config, ... }:
{
  imports = [
    ./hardware.nix
  ];

  system.stateVersion = "25.11";

  services.openssh.enable = true;

  programs = {
    niri.enable = true;
    steam.enable = config.programs.niri.enable;
  };

  hjem.users.mcsimw.rum.desktops.niri = {
    enable = true;
    config = builtins.readFile ./config.kdl;
  };

  analfabeta.programs.prismlauncher.enable = config.programs.niri.enable;

  users.users.mcsimw.enable = true;

}
