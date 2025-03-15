{
  self',
  inputs',
}:
{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.myShit.dwl.enable;
in
{
  options.myShit.dwl.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "Whether to enable dwl.";
  };

  config =
    lib.mkIf cfg {
      environment.systemPackages = [
        self'.packages.dwl
      ];
    }
    // (import ./base.nix { inherit inputs' pkgs; })
    // (import ./wlroots.nix { inherit inputs pkgs; });
}
