{
  inputs',
  lib,
  config,
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
        desktop.enable = true;
      };
    }
    (lib.mkIf config.analfabeta.desktop.enable {
      hjem.users.mcsimw.files.".config/niri/config.kdl".source = ./config.kdl;
      programs.firefox = {
        enable = true;
        package = inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
      };
    })
  ];
}
