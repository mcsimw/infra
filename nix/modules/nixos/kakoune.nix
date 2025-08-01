{ moduleWithSystem, ... }:
{
  flake.modules.nixos.kakoune = moduleWithSystem (
    _:
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    let
      cfg = config.programs.kakoune;
    in
    {
      options.programs.kakoune = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether to enable Kakoune.";
        };
        defaultEditor = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Set Kakoune as the default editor.";
        };
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Kakoune, can be overridden.";
          default = pkgs.kakoune-unwrapped.overrideAttrs {
            version = inputs.kakoune.rev;
            src = inputs.kakoune;
            postPatch = ''
              echo "${inputs.kakoune.rev}" >.version
            '';
          };
        };
      };
      config = lib.mkIf cfg.enable {
        environment = {
          systemPackages = [ cfg.package ];
          variables.EDITOR = lib.mkIf cfg.defaultEditor (lib.mkOverride 999 "kak");
        };
      };
    }
  );
}
