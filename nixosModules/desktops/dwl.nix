{ self', inputs' }:
{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  options.myShit.dwl.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "Whether to enable dwl.";
  };

  config = lib.mkMerge [
    (import ./base.nix { inherit inputs' pkgs; })
    (import ./wlroots.nix { inherit inputs' pkgs inputs; })
    (lib.mkIf config.myShit.dwl.enable {
      environment.systemPackages = [ self'.packages.dwl ];
    })
  ];
}
