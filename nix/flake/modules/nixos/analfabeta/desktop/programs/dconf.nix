{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        programs.dconf = {
          enable = true;
          profiles.user.databases = [
            {
              lockAll = false;
              settings = {
                "org/gnome/desktop/interface" = {
                  accent-color = "pink";
                  color-scheme = "prefer-dark";
                };
                "org/gnome/desktop/wm/preferences" = {
                  button-layout = "";
                };
              };
            }
          ];
        };
      };
    };
}
