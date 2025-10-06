{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self' }:
    {
      options.programs.kakoune = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "whether to enable Kakoune.";
        };
        defaultEditor = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Set Kakoune as the default editor.";
        };
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Kakoune, can be overridden.";
          default = self'.packages.kakoune;
        };
      };
    }
  );
}
