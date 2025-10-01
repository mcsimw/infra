{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { pkgs }:
    { config, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        programs.foot = {
          enable = true;
          package = lib.mkDefault pkgs.foot;
          settings = {
            main = {
              font = "Spleen:size=12, Symbols Nerd Font Mono:size=9, Apple Color Emoji:size=9";
              font-size-adjustment = 6;
              bold-text-in-bright = true;
              pad = "40x40";
            };

            colors = {
              background = "000000";
              foreground = "ffffff";
              cursor = "ffffff cc0077";

              regular0 = "000000";
              regular1 = "ee2a2a";
              regular2 = "00ff5f";
              regular3 = "ffdd00";
              regular4 = "2f8fff";
              regular5 = "ff5fae";
              regular6 = "00d7d7";
              regular7 = "d0d0d0";

              bright0 = "3a3a3a";
              bright1 = "ff5555";
              bright2 = "00ffaa";
              bright3 = "ffff66";
              bright4 = "7ab7ff";
              bright5 = "ff85d7";
              bright6 = "7fffff";
              bright7 = "ffffff";

              "16" = "ffae00";
              "17" = "ff7755";

              selection-background = "cc0077";
              selection-foreground = "000000";

              urls = "88ccff";
            };

          };
        };
      };
    }
  );
}
