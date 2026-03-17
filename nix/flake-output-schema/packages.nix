{ lib, ... }:
{
  options.flake.packages = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.lazyAttrsOf lib.types.package);
    default = { };
    description = "Packages per system";
  };
}
