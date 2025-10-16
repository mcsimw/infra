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


      "Mod+Ctrl+H".action = "move-column-left";
      "Mod+Ctrl+J".action = "move-window-down";
      "Mod+Ctrl+K".action = "move-window-up";
      "Mod+Ctrl+L".action = "move-column-right";

      "Mod+Shift+Ctrl+K".action = "move-column-to-monitor-up";
      "Mod+Shift+Ctrl+L".action = "move-column-to-monitor-right";

      "Mod+M".action = "maximize-column";
      "F11".action = "fullscreen-window";

      "Mod+C".action = "center-column";
      "Mod+Ctrl+C".action = "center-visible-columns";

      "Mod+H".action = "focus-column-left";
      "Mod+J".action = "focus-window-down";
      "Mod+K".action = "focus-window-up";
      "Mod+L".action = "focus-column-right";


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

      "Mod+BracketLeft".action = "consume-or-expel-window-left";
      "Mod+BracketRight".action = "consume-or-expel-window-right";

      "Mod+Comma".action = "consume-window-into-column";
      "Mod+Period".action = "expel-window-from-column";

      "Mod+Ctrl+1".action = "move-column-to-workspace 1";
      "Mod+Ctrl+2".action = "move-column-to-workspace 2";
      "Mod+Ctrl+3".action = "move-column-to-workspace 3";
      "Mod+Ctrl+4".action = "move-column-to-workspace 4";
      "Mod+Ctrl+5".action = "move-column-to-workspace 5";
      "Mod+Ctrl+6".action = "move-column-to-workspace 6";
      "Mod+Ctrl+7".action = "move-column-to-workspace 7";
      "Mod+Ctrl+8".action = "move-column-to-workspace 8";
      "Mod+Ctrl+9".action = "move-column-to-workspace 9";

      "Mod+Ctrl+F".action = "expand-column-to-available-width";


      "Mod+V".action = "toggle-window-floating";
      "Mod+Shift+V".action = "switch-focus-between-floating-and-tiling";


      "Mod+WheelScrollDown" = {
        action = "focus-workspace-down";
        parameters.cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action = "focus-workspace-up";
        parameters.cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        action = "move-column-to-workspace-down";
        parameters.cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        action = "move-column-to-workspace-up";
        parameters.cooldown-ms = 150;
      };


      "Mod+WheelScrollRight".action = "focus-column-right";
      "Mod+WheelScrollLeft".action = "focus-column-left";
      "Mod+Ctrl+WheelScrollRight".action = "move-column-right";
      "Mod+Ctrl+WheelScrollLeft".action = "move-column-left";

      "Mod+Shift+WheelScrollDown".action = "focus-column-right";
      "Mod+Shift+WheelScrollUp".action = "focus-column-left";
      "Mod+Ctrl+Shift+WheelScrollDown".action = "move-column-right";
      "Mod+Ctrl+Shift+WheelScrollUp".action = "move-column-left";

      "Mod+O".spawn = [ "emoji-fuzzel" ];

      "Print".action = "screenshot-screen";
      "Ctrl+Print".action = "screenshot";
      "Alt+Print".action = "screenshot-window";

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
