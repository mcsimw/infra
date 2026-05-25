{ inputs, ... }:
{
  config._module.args = {
    flake-parts-lib = inputs.flake-parts.lib;
    moduleLocation = ./../../.;
  };
  imports = [
    "${inputs.flake-parts}/modules/flake.nix"
    "${inputs.flake-parts}/modules/nixosConfigurations.nix"
    inputs.flake-parts.flakeModules.modules
  ];
}
