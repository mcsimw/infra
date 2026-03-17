{ lib, ... }:
{
  options.flake.checks = lib.mkOption {
    type = lib.types.attrsOf (lib.types.attrsOf lib.types.package);
    default = { };
    description = "Flake checks per system";
  };
}
