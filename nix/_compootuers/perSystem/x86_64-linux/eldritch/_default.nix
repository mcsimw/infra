{ inputs, ... }:
{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
    ./_bootloader.nix
    inputs.nix-maid.nixosModules.default
  ];

  analfabeta = {
    users.mcsimw.enable = true;
    desktop.users.mcsimw = ./config.kdl;
  };

  users.users.mcsimw.maid.gsettings.settings.org.gnome.desktop.interface.accent-color = "red";

}
