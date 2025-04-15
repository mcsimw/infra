{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myShit.programs.starship;
in
{

  options.myShit.programs.starship.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether to enable Kakoune.";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = lib.mkDefault true;
      settings = lib.mkDefault (pkgs.lib.importTOML ./starship.toml);
    };
    environment.systemPackages = with pkgs; [ starship ];
  };
}
