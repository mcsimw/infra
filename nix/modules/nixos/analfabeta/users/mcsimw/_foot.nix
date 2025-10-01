{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self' }:
    {
      config,
      ...
    }:
    {
      config = lib.mkIf (config.analfabeta.users.mcsimw.enable && config.programs.foot.enable) {
        users.users.mcsimw.packages = [ self'.packages.foot ];
      };
    }
  );
}
