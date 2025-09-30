{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self', ... }:
    {
      config,
      lib,
      ...
    }:
    {
      config = lib.mkIf (config.analfabeta.users.mcsimw.enable && config.programs.foot.enable) {
        users.users.mcsimw.packages = [ self'.packages.foot ];
      };
    }
  );
}
