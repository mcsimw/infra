{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self', ... }:
    {
      config,
      lib,
      ...
    }:
    let
      cfg = config.analfabeta.programs.kakoune;
    in
    {
      options.analfabeta.programs.kakoune = {
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
      config = lib.mkIf cfg.enable {
        environment = {
          systemPackages = [ cfg.package ];
          variables.EDITOR = lib.mkIf cfg.defaultEditor (lib.mkOverride 900 "kak");
        };
      };
    }
  );
}
