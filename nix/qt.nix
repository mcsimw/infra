{ config, desktops, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.qt;
    qt =
      { lib, config, ... }:
      let
        anyDesktop = cfg: lib.any (name: desktops.byName.${name}.check cfg) (lib.attrNames desktops.byName);
      in
      {
        qt.enable = lib.mkDefault (anyDesktop config);
      };
  };
}
