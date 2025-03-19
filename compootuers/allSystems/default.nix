{
  inputs,
  self,
  config,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
    #    inputs.vaultix.nixosModules.default
    self.nixosModules.mcsimw
    self.nixosModules.bluetooth
    inputs.preservation.nixosModules.default
  ];
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
#  system.etc.overlay.enable = config.boot.initrd.systemd.enable;
}
