{ config, lib, ... }:
let
  inherit (builtins) mapAttrs;
  inherit (lib) mkEnableOption mkIf;
  npins = import ./_npins.nix;
  inherit (npins) sources;
  npinsPackages = mapAttrs (
    system: pkgs:
    import config.sources.npins {
      inherit system pkgs;
    }
  ) config.nixpkgs.pkgs;
in
{
  options.sources = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = sources;
    description = "Sources from npins, overridable";
  };
  config = {
    nixpkgs.overlays = [
      (final: _prev: {
        npins = npinsPackages.${final.stdenv.hostPlatform.system};
      })
    ];
    flake = {
      packages = mapAttrs (_: npinsPkg: {
        npins = npinsPkg;
      }) npinsPackages;
      modules.nixos = {
        default =
          { lib, ... }:
          {
            imports = [ config.flake.modules.nixos.npins ];
            programs.npins.enable = lib.mkDefault true;
          };
        npins =
          { config, pkgs, ... }:
          {
            options.programs.npins.enable = mkEnableOption "npins package manager";
            config = mkIf config.programs.npins.enable {
              environment.systemPackages = [ npinsPackages.${pkgs.stdenv.hostPlatform.system} ];
            };
          };
      };
    };
  };
}
