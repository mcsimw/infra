{
  flake.nixosModules = {
    kakoune = ./kakoune.nix;
    bluetooth = ./bluetooth.nix;
  };
  imports = [
    ./desktops
    ./bootloaders
    ./users
  ];
}
