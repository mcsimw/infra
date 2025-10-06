{ inputs, ... }:

{
  imports = [
    inputs.nixpkgs.nixosModules.readOnlyPkgs
    inputs.preservation.nixosModules.default
  ];

  preservation.preserveAt."/persist" = {
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
}
