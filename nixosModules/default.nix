{
  imports = [
    ./users
    ./mcsimw
  ];
  flake.nixosModules = {
    systemd-bootloader = ./systemd-bootloader.nix;
    dwl = ./dwl.nix;
  };
}
