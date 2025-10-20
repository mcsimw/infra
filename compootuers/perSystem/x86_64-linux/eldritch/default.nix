{
  config,
  pkgs,
  ...
}:
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
    steam = {
      enable = niri;
      extraCompatPackages = [ pkgs.proton-cachyos ];
    };
  };

  environment.systemPackages = with pkgs; [
    mangohud
    openmw
    gimp
    kdePackages.kdenlive
  ];

  preservation.preserveAt."/persist".users.mcsimw = {
    directories = [
      ".local/share/Steam"
      ".steam"
      ".local/share/openmw"
      ".config/openmw"
    ];
  };
}
