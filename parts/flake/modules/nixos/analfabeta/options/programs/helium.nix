{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self' }:
    {
      options.programs.helium = {
        enable = lib.mkEnableOption "Install Helium Browswer";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Helium can be overridden.";
          default = self'.packages.helium;
        };
      };
    }
  );
}
