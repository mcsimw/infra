{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myShit.programs.kakoune;
in
{
  options.myShit.programs.kakoune = {
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
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ kakoune ];
    environment.variables.EDITOR = lib.mkIf cfg.defaultEditor (lib.mkOverride 999 "kak");
  };
}
