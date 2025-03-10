{ lib, inputs, ... }:
{
  flake.nixosModules =
    let
      defaultModules = {
        mcsimw-default = lib.modules.importApply ./git.nix { inherit inputs; };
      };
      wlroots = {
        mcsimw-foot = lib.modules.importApply ./foot.nix { inherit inputs; };
      };
    in
    defaultModules
    // wlroots
    // {
      mcsimw-default.imports = builtins.attrValues defaultModules;
      mcsimw-wlroots.imports = builtins.attrValues wlroots;
    };
}
