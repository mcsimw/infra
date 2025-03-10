{
  flake.nixosModules = {
    kakoune = ./kakoune.nix;
  };
  imports = [
    ./users
    ./mcsimw
    ./desktops
    ./bootloaders
  ];
}
