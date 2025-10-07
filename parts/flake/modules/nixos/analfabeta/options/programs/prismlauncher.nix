{ lib, self, ... }:
let
  sources = import (self + /npins);
in
{
  flake.modules.nixos.analfabeta =
    { pkgs, ... }:
    {
      options.programs.prismlauncher = {
        enable = lib.mkEnableOption "Install Prism Launcher";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for PrismLauncher can be overridden.";
          inherit ((import sources.PrismLauncher).packages.${pkgs.system}) default;
        };
      };
    };
}
