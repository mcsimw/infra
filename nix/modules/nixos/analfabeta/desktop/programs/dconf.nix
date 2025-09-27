{
  flake.modules.nixos.analfabeta =
    { config, lib, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        programs = {
          dconf = {
            enable = true;
            profiles.user.databases = [
              {
                lockAll = true;
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
    };
}
