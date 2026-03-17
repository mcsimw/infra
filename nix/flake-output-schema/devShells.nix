{ lib, ... }:
{
  options.flake.devShells = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.lazyAttrsOf lib.types.package);
    default = { };
    description = "Development shells per system";
  };
}
