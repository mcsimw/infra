{ lib, inputs, ... }:
{
  flake.nixosModules =
    let
      defaultModules = {
        users-git = lib.modules.importApply ./git.nix { inherit inputs; };
        users-foot = lib.modules.importApply ./foot.nix { inherit inputs; };
      };
    in
    defaultModules
    // {
      users-default.imports = builtins.attrValues defaultModules;
    };
}
