{ config, desktops, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.foot;
    foot =
      { config, ... }:
      let
        inherit (builtins) any filter elem;
        waylandWMs = filter (n: elem n desktops.byProtocol.wayland) desktops.byType.wm;
        hasWaylandWM = any (name: desktops.byName.${name}.check config) waylandWMs;
      in
      {
        programs = {
          foot = {
            enable = hasWaylandWM;
            settings = {
              main = {
                font = "Spleen:size=12,Terminus:size=12, Symbols Nerd Font Mono:size=9, Apple Color Emoji:size=9";
                font-size-adjustment = 6;
                bold-text-in-bright = true;
                pad = "40x40";
              };
              colors-dark = {
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
      };
  };
}
