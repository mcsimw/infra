{ lib, self, ... }:
let
  sources = import (self + /npins);
in
{
  flake.modules.nixos.analfabeta =
    { pkgs, ... }:
    {
      options.programs.ghostty = {
        enable = lib.mkEnableOption "Install Ghostty Terminal";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Ghostty can be overridden.";
          inherit ((import sources.ghostty).packages.${pkgs.system}) default;
        };
      };
    };
}
