{
  inputs,
  self,
  lib,
  ...
}:
{
  imports = [
    inputs.nixpkgs.nixosModules.readOnlyPkgs
    self.modules.nixos.mcsimw
    inputs.preservation.nixosModules.default
  ];
  programs.bash.interactiveShellInit = lib.mkAfter ''source ${self}/bash/nixos.bash'';
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
