{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.dconf;
    dconf =
      { lib, ... }:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.dconf.profiles.user.databases = [
          {
            lockAll = mkDefault false;
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
}
