{ config, desktops, ... }:
let
  inherit (config) sources;
  systems = import sources.default-linux;
in
{
  nixpkgs.overlays = [
    {
      overlay = _: prev: {
        quickshell = prev.callPackage "${sources.quickshell}/default.nix" { };
      };
      inherit systems;
    }
  ];
  flake.modules.nixos = {
    default = config.flake.modules.nixos.quickshell;
    quickshell =
      {
        lib,
        pkgs,
        config,
        ...
      }:
      let
        inherit (desktops) byType byProtocol;
        inherit (builtins) filter elem any;
        inherit (lib) types mkEnableOption mkOption;
        waylandWMs = filter (n: elem n byProtocol.wayland) byType.wm;
        default = any (name: desktops.byName.${name}.check config) waylandWMs;
        cfg = config.programs.quickshell;
      in
      {
        options.programs.quickshell = {
          enable = mkEnableOption "quickshell" // {
            inherit default;
          };
          package = mkOption {
            default = pkgs.quickshell;
            type = types.package;
            description = "Quickshell package to use";
          };
        };
        config = lib.mkIf cfg.enable {
          environment.systemPackages = [
            cfg.package
            pkgs.kdePackages.qtdeclarative
          ];
        };
      };
  };
}
