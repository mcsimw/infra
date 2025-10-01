{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.compootuers.modules.flake.compootuers
  ];
}
