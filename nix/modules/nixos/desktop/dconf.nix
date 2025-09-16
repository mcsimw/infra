{
  flake.modules.nixos.infra =
    { lib, config, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {

        programs.dconf.profiles.user.databases = [
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
}
