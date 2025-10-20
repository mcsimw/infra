{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs' }:
    {
      options.programs.google-chrome = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "whether to enable Google Chrome.";
        };
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Google Chrome, can be overridden.";
          default = inputs'.browser-previews.packages.google-chrome-dev;
        };
      };
    }
  );
}
