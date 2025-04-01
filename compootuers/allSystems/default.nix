{
  inputs,
  self,
  lib,
  ...
}:
{
  imports = [
    inputs.nixpkgs.nixosModules.readOnlyPkgs
    #    inputs.vaultix.nixosModules.default
    self.nixosModules.mcsimw
    self.nixosModules.bluetooth
    inputs.preservation.nixosModules.default
  ];
  services.userborn.enable = lib.mkDefault true;
  preservation = {
    preserveAt."/persist" = {
      directories = [
        "/var/log"
        "/var/lib/systemd/coredump"
      ];
      files = [
        {
          file = "/var/lib/systemd/random-seed";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
      ];
    };
  };
}
