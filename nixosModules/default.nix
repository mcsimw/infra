{
  flake.nixosModules = {
    kakoune = ./kakoune.nix;
    bluetooth = ./bluetooth.nix;
    zfs-rollback = ./zfs-rollback.nix;
  };
  imports = [
    ./desktops
    ./bootloaders
    ./users
  ];
}
