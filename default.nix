let
  inherit (builtins) currentSystem;
  outputs = (import ./nix/_eval.nix).flake;
in
outputs
// {
  inherit (outputs) nixosConfigurations;
  checks = outputs.checks.${currentSystem} or { };
  packages = outputs.packages.${currentSystem} or { };
  devShells = outputs.devShells.${currentSystem} or { };
  shell = outputs.devShells.${currentSystem}.default or null;
  formatter = outputs.formatter.${currentSystem} or null;
}
// (outputs.packages.${currentSystem} or { })
