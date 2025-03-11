{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  flake.nixosModules =
    let
      defaultModules = {
        users-git = lib.modules.importApply ./git.nix { inherit inputs; };
        users-foot = lib.modules.importApply ./foot.nix { inherit inputs pkgs; };
      };
    in
    defaultModules
    // {
      users-default.imports = builtins.attrValues defaultModules;
    };
}
