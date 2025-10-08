{ config, ... }:
let
  niri = config.programs.niri.enable;
in
{
  imports = [
    ./hardware.nix
  ];

  system.stateVersion = "25.11";

  services.openssh.enable = true;

  programs = {
    niri.enable = true;
    steam.enable = niri;
    prismlauncher.enable = niri;
  };

  hjem.users.mcsimw.rum.desktops.niri = {
    enable = true;
    config = builtins.readFile ./config.kdl;
  };

  users.users.mcsimw.enable = true;
}
