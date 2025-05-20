{ pkgs, ... }:
{
  programs = {
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = true;
          settings = {
            "org/gnome/desktop/interface".color-scheme = "prefer-dark";
            "org/gnome/desktop/wm/preferences".button-layout = "";
          };
        }
      ];
    };
    foot.enable = true;
  };
  environment.systemPackages = with pkgs; [
    imv
    mako
    zathura
    wmenu
  ];

}
