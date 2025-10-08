{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self' }:
    {
      options.programs.ghostty = {
        enable = lib.mkEnableOption "Install Ghostty Terminal";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Ghostty can be overridden.";
          default = self'.packages.ghostty;
        };
      };
    }
  );
}
