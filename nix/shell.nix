{ config, ... }:
{
  flake.devShells = builtins.mapAttrs (_: pkgs: {
    default = pkgs.mkShell { packages = [ pkgs.npins ]; };
  }) config.nixpkgs.pkgs;
}
