{
  imports = [
    ./_hardware.nix
    ./_fileSystems.nix
    ./_bootloader.nix
  ];
  analfabeta.users.mcsimw.enable = true;
}
