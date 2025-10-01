{ lib, ... }:
{
  flake.modules.nixos.analfabeta.options.analfabeta.desktop = {
    enable = lib.mkEnableOption "niri";

    users = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = { };
    };
  };
}
