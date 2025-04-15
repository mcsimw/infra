{
  flake.nixosModules = {
    kakoune = ./kakoune.nix;
    bluetooth = ./bluetooth.nix;
    zfs-rollback = ./zfs-rollback.nix;
    virtualization = ./virtualization.nix;
    starship = ./starship;
  };
  imports = [
    ./desktops
    ./bootloaders
    ./users
  ];
}
