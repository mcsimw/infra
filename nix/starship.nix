{ config, ... }:
{
  flake.modules.nixos = {
    default =
      { lib, ... }:
      {
        imports = [ config.flake.modules.nixos.starship ];
        programs.starship.enable = lib.mkDefault true;
      };
    starship =
      { lib, ... }:
      {
        programs.starship.settings.add_newline = lib.mkDefault false;
      };
    maor =
      { config, lib, ... }:
      let
        inherit (lib) mkDefault;
      in
      {
        hjem.users.mcsimw.rum.programs.starship = {
          enable = config.programs.starship.enable;
          settings.add_newline = mkDefault false;
          integrations = {
            fish.enable = mkDefault true;
            nushell.enable = mkDefault true;
            zsh.enable = mkDefault true;
          };
          transience.enable = mkDefault true;
        };
      };
  };
}
