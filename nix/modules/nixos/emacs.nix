{
  flake.modules.nixos.emacs =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.programs.emacs;
    in
    {
      options.programs.emacs = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to enable Emacs.";
        };
        defaultEditor = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Set Emacs as the default editor.";
        };
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Emacs, can be overridden.";
          default = pkgs.emacs-igc-pgtk;
        };
      };

      config = lib.mkIf cfg.enable {
        environment = {
          systemPackages = [ cfg.package ];
          variables.EDITOR = lib.mkIf cfg.defaultEditor (lib.mkOverride 999 "emacs");
        };
      };
    };
}
