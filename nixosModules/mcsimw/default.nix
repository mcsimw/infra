{
  lib,
  inputs,
  ...
}:
{
  flake.nixosModules =
    let
      defaultModules = {
        mcsimw-git = lib.modules.importApply ./git.nix { inherit inputs; };
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
      mcsimw-mkUser = ./mkUser.nix;
    };
}
