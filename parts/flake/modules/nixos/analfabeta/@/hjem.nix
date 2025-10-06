{
  inputs,
  moduleWithSystem,
  lib,
  ...
}:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs' }:
    {
      hjem = {
        clobberByDefault = lib.mkDefault true;
        linker = inputs'.hjem.packages.smfh;
        extraModules = [ inputs.hjem-rum.hjemModules.default ];
      };
    }
  );
}
