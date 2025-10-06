{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      programs.dconf = {
        inherit (config.programs.niri) enable;
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
}
