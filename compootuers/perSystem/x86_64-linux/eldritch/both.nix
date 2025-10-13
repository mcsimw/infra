{ config, ... }:
{
  imports = [
    ./hardware.nix
  ];

  system.stateVersion = "25.11";

  services.openssh.enable = true;

  programs = {
    niri.enable = true;
    helium.enable = true;
  };

  hjem.users.mcsimw.rum.desktops.niri = {
    inherit (config.programs.niri) enable;
    config = builtins.readFile ./config.kdl;
    binds = {
      "Mod+Shift+H".action = "focus-monitor-left";
      "Mod+Shift+J".action = "focus-monitor-down";
      "Mod+Shift+K".action = "focus-monitor-up";
      "Mod+Shift+L".action = "focus-monitor-right";

      "Mod+Shift+Ctrl+K".action = "move-column-to-monitor-up";
      "Mod+Shift+Ctrl+L".action = "move-column-to-monitor-right";

      "Mod+M".action = "maximize-column";
      "F11".action = "fullscreen-window";

      "Mod+H".action = "focus-column-left";
      "Mod+J".action = "focus-window-down";
      "Mod+K".action = "focus-window-up";
      "Mod+L".action = "focus-column-right";

      "Mod+O".spawn = [ "emoji-fuzzel" ];

      "Mod+Z".action = "focus-workspace-previous";

      "Mod+Tab".action = "toggle-overview";

      "Mod+1".action = "focus-workspace 1";
      "Mod+2".action = "focus-workspace 2";
      "Mod+3".action = "focus-workspace 3";
      "Mod+4".action = "focus-workspace 4";
      "Mod+5".action = "focus-workspace 5";
      "Mod+6".action = "focus-workspace 6";
      "Mod+7".action = "focus-workspace 7";
      "Mod+8".action = "focus-workspace 8";
      "Mod+9".action = "focus-workspace 9";

      "Print".action = "screenshot";

      "Ctrl+Alt+Delete" = {
        parameters = {
          allow-when-locked = true;
          cooldown-ms = 150;
        };
        spawn = [
          "foot"
          "btop"
        ];
      };

      "Mod+E".spawn = [ "nautilus" ];

      "Alt+F2".spawn = [ "fuzzel" ];

      "Ctrl+Alt+T" = {
        parameters = {
          allow-when-locked = true;
          cooldown-ms = 150;
        };
        spawn = [
          "foot"
        ];
      };

      "Alt+F4" = {
        action = "close-window";
        parameters = {
          repeat = false;
        };
      };
    };
  };

  users.users.mcsimw.enable = true;
}
