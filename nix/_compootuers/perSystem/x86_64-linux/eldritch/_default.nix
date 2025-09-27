{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
    ./_bootloader.nix
  ];

  config = lib.mkMerge [
    {
      analfabeta = {
        users.mcsimw.enable = true;
        desktop.users.mcsimw = ./config.kdl;
      };
      environment.systemPackages = with pkgs; [ fish ];
    }
  ];
}
