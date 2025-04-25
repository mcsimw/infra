{
  flake.nixosModules = {
    kakoune = ./kakoune.nix;
    bluetooth = ./bluetooth.nix;
    zfs-rollback = ./zfs-rollback.nix;
    virtualization = ./virtualization.nix;
    sane = ./sane.nix;
    nix-conf = ./nix-conf.nix;
  };

  imports = [
    ./desktops
    ./bootloaders
    ./users
  ];
}
