{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
  ];
  analfabeta = {
    users.mcsimw.enable = true;
    bootloader.enable = true;
  };
}
