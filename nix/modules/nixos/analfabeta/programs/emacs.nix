{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { pkgs, ... }:
    {
      config,
      lib,
      ...
    }:
    let
      cfg = config.analfabeta.programs.emacs;
    in
    {
      options.analfabeta.programs.emacs = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "whether to enable emacs.";
        };
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for emacs, can be overridden.";
          default = pkgs.emacs-igc-pgtk;
        };
        defaultEditor = lib.mkEnableOption "emacs as the default editor";
      };
      config = lib.mkIf cfg.enable {
        environment = {
          systemPackages = [ cfg.package ];
          variables.EDITOR = lib.mkIf cfg.defaultEditor (lib.mkOverride 900 "emacs");
        };
      };
    }
  );
}
