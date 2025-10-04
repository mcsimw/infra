{ inputs, ... }:
{
  imports = with inputs; [
    flake-parts.flakeModules.modules
    compootuers.modules.flake.compootuers
    treefmt-nix.flakeModule
  ];
}
