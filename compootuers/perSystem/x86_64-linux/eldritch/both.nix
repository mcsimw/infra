{
  imports = [
    ./hardware.nix
  ];

  system.stateVersion = "25.11";

  services.openssh.enable = true;

  programs = {
    niri.enable = true;
    helium.enable = true;
  };

  hjem.users.mcsimw.rum.desktops.niri = {
    enable = true;
    config = builtins.readFile ./config.kdl;
  };

  users.users.mcsimw.enable = true;
}
