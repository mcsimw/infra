{
  flake.nixosModules = {
    kakoune = ./kakoune.nix;
    bluetooth = ./bluetooth.nix;
    zfs-rollback = ./zfs-rollback.nix;
    virtualization = ./virtualization.nix;
  };
  imports = [
    ./desktops
    ./bootloaders
    ./users
  ];
}
