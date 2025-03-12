{
  flake.nixosModules = {
    kakoune = ./kakoune.nix;
  };
  imports = [
    ./desktops
    ./bootloaders
  ];
}
