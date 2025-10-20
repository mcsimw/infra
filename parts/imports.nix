{ inputs, ... }:
{
  imports = with inputs; [
    flake-parts.flakeModules.modules
    compootuers.flakeModule
    treefmt-nix.flakeModule
  ];
}
