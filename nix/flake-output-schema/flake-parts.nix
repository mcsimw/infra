{ lib, sources, ... }:
{
  config._module.args = {
    flake-parts-lib = import "${sources.flake-parts}/lib.nix" { inherit lib; };
    moduleLocation = ./../../.;
  };
  imports = [
    "${sources.flake-parts}/modules/flake.nix"
    "${sources.flake-parts}/modules/nixosConfigurations.nix"
    "${sources.flake-parts}/extras/modules.nix"
  ];
}
