{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    ./bootloader.nix
  ];

  programs.ghostty.enable = true;
}
