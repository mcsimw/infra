{
  inputs,
  self,
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
    enable = true;
    preserveAt."/persist" = {
      files = [ ];
      directories = [
        # no /var since regular mount
      ];

      users = {
        root = {
          home = "/root";
          directories = [
            {
              directory = ".ssh";
              mode = "0700";
            }
          ];
          files = [
            ".bash_history"
          ];
        };
      };
    };
  };
}
