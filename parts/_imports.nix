{ inputs, ... }:
{
  imports = with inputs; [
    (import-tree ./.)
    flake-parts.flakeModules.modules
    compootuers.modules.flake.compootuers
    treefmt-nix.flakeModule
  ];
}
