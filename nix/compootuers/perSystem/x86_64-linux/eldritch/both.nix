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

  hjem.users.mcsimw.files.".config/niri/config.kdl".source = ./config.kdl;

  analfabeta = {
    users.mcsimw.enable = true;
    programs.prismlauncher.enable = config.programs.niri.enable;
  };

}
