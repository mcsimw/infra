{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.documentation;
    documentation =
      { lib, ... }:
      {
        documentation = lib.genAttrs [ "doc" "nixos" "info" ] (_: {
          enable = lib.mkDefault false;
        });
      };
  };
}
