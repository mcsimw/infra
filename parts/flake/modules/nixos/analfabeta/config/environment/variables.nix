{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {

      environment.variables = {
        NIXPKGS_CONFIG = lib.mkDefault "";
        EDITOR = lib.mkIf config.programs.kakoune.defaultEditor (lib.mkOverride 900 "kak");
      };
    };
}
