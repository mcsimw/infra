{
  lib,
  config,
  desktops,
  ...
}:
let
  anyDesktop = cfg: lib.any (name: desktops.byName.${name}.check cfg) (lib.attrNames desktops.byName);
in
{
  flake.modules.nixos = {
    default =
      { lib, ... }:
      {
        imports = [ config.flake.modules.nixos.wireshark ];
        programs.wireshark.enable = lib.mkDefault true;
      };
    wireshark =
      { pkgs, config, ... }:
      {
        environment.systemPackages = lib.mkIf (anyDesktop config) [ pkgs.wireshark ];
      };
  };
}
