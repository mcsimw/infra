{ inputs, self, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];
}
