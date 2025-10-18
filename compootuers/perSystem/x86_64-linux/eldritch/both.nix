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
      # Show hotkey overlay
      "Mod+Shift+Slash" = {
        action = "show-hotkey-overlay";
      };

      # Program launchers
      "Mod+T" = {
        spawn = [ "foot" ];
        parameters = {
          hotkey-overlay-title = "Open a Terminal: foot";
        };
      };

      "Mod+D" = {
        spawn = [ "fuzzel" ];
        parameters = {
          hotkey-overlay-title = "Run an Application: fuzzel";
        };
      };

      "Super+Alt+L" = {
        spawn = [ "swaylock" ];
        parameters = {
          hotkey-overlay-title = "Lock the Screen: swaylock";
        };
      };

      # Screen reader toggle
      "Super+Alt+S" = {
        spawn = [
          "sh"
          "-c"
          "pkill orca || exec orca"
        ];
        parameters = {
          allow-when-locked = true;
          hotkey-overlay-title = null;
        };
      };

      # Volume controls
      "XF86AudioRaiseVolume" = {
        spawn = [
          "sh"
          "-c"
          "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      "XF86AudioLowerVolume" = {
        spawn = [
          "sh"
          "-c"
          "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      "XF86AudioMute" = {
        spawn = [
          "sh"
          "-c"
          "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      "XF86AudioMicMute" = {
        spawn = [
          "sh"
          "-c"
          "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      # Media controls
      "XF86AudioPlay" = {
        spawn = [
          "sh"
          "-c"
          "playerctl play-pause"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      "XF86AudioStop" = {
        spawn = [
          "sh"
          "-c"
          "playerctl stop"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      "XF86AudioPrev" = {
        spawn = [
          "sh"
          "-c"
          "playerctl previous"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      "XF86AudioNext" = {
        spawn = [
          "sh"
          "-c"
          "playerctl next"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      # Brightness controls
      "XF86MonBrightnessUp" = {
        spawn = [
          "brightnessctl"
          "--class=backlight"
          "set"
          "+10%"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      "XF86MonBrightnessDown" = {
        spawn = [
          "brightnessctl"
          "--class=backlight"
          "set"
          "10%-"
        ];
        parameters = {
          allow-when-locked = true;
        };
      };

      # Overview
      "Mod+O" = {
        action = "toggle-overview";
        parameters = {
          repeat = false;
        };
      };

      # Window management
      "Mod+Q" = {
        action = "close-window";
        parameters = {
          repeat = false;
        };
      };

      # Focus navigation - Arrow keys
      "Mod+Left" = {
        action = "focus-column-left";
      };

      "Mod+Down" = {
        action = "focus-window-down";
      };

      "Mod+Up" = {
        action = "focus-window-up";
      };

      "Mod+Right" = {
        action = "focus-column-right";
      };

      # Focus navigation - Vim keys
      "Mod+H" = {
        action = "focus-column-left";
      };

      "Mod+J" = {
        action = "focus-window-down";
      };

      "Mod+K" = {
        action = "focus-window-up";
      };

      "Mod+L" = {
        action = "focus-column-right";
      };

      # Move windows - Arrow keys
      "Mod+Ctrl+Left" = {
        action = "move-column-left";
      };

      "Mod+Ctrl+Down" = {
        action = "move-window-down";
      };

      "Mod+Ctrl+Up" = {
        action = "move-window-up";
      };

      "Mod+Ctrl+Right" = {
        action = "move-column-right";
      };

      # Move windows - Vim keys
      "Mod+Ctrl+H" = {
        action = "move-column-left";
      };

      "Mod+Ctrl+J" = {
        action = "move-window-down";
      };

      "Mod+Ctrl+K" = {
        action = "move-window-up";
      };

      "Mod+Ctrl+L" = {
        action = "move-column-right";
      };

      # Alternative movement commands (commented in original)
      # "Mod+J" = {
      #   action = "focus-window-or-workspace-down";
      # };
      # "Mod+K" = {
      #   action = "focus-window-or-workspace-up";
      # };
      # "Mod+Ctrl+J" = {
      #   action = "move-window-down-or-to-workspace-down";
      # };
      # "Mod+Ctrl+K" = {
      #   action = "move-window-up-or-to-workspace-up";
      # };

      # Column position
      "Mod+Home" = {
        action = "focus-column-first";
      };

      "Mod+End" = {
        action = "focus-column-last";
      };

      "Mod+Ctrl+Home" = {
        action = "move-column-to-first";
      };

      "Mod+Ctrl+End" = {
        action = "move-column-to-last";
      };

      # Monitor focus - Arrow keys
      "Mod+Shift+Left" = {
        action = "focus-monitor-left";
      };

      "Mod+Shift+Down" = {
        action = "focus-monitor-down";
      };

      "Mod+Shift+Up" = {
        action = "focus-monitor-up";
      };

      "Mod+Shift+Right" = {
        action = "focus-monitor-right";
      };

      # Monitor focus - Vim keys
      "Mod+Shift+H" = {
        action = "focus-monitor-left";
      };

      "Mod+Shift+J" = {
        action = "focus-monitor-down";
      };

      "Mod+Shift+K" = {
        action = "focus-monitor-up";
      };

      "Mod+Shift+L" = {
        action = "focus-monitor-right";
      };

      # Move to monitor - Arrow keys
      "Mod+Shift+Ctrl+Left" = {
        action = "move-column-to-monitor-left";
      };

      "Mod+Shift+Ctrl+Down" = {
        action = "move-column-to-monitor-down";
      };

      "Mod+Shift+Ctrl+Up" = {
        action = "move-column-to-monitor-up";
      };

      "Mod+Shift+Ctrl+Right" = {
        action = "move-column-to-monitor-right";
      };

      # Move to monitor - Vim keys
      "Mod+Shift+Ctrl+H" = {
        action = "move-column-to-monitor-left";
      };

      "Mod+Shift+Ctrl+J" = {
        action = "move-column-to-monitor-down";
      };

      "Mod+Shift+Ctrl+K" = {
        action = "move-column-to-monitor-up";
      };

      "Mod+Shift+Ctrl+L" = {
        action = "move-column-to-monitor-right";
      };

      # Alternative monitor movement (commented in original)
      # "Mod+Shift+Ctrl+Left" = {
      #   action = "move-window-to-monitor-left";
      # };

      # Workspace movement (commented in original)
      # "Mod+Shift+Ctrl+Left" = {
      #   action = "move-workspace-to-monitor-left";
      # };

      # Workspace navigation
      "Mod+Page_Down" = {
        action = "focus-workspace-down";
      };

      "Mod+Page_Up" = {
        action = "focus-workspace-up";
      };

      "Mod+U" = {
        action = "focus-workspace-down";
      };

      "Mod+I" = {
        action = "focus-workspace-up";
      };

      "Mod+Ctrl+Page_Down" = {
        action = "move-column-to-workspace-down";
      };

      "Mod+Ctrl+Page_Up" = {
        action = "move-column-to-workspace-up";
      };

      "Mod+Ctrl+U" = {
        action = "move-column-to-workspace-down";
      };

      "Mod+Ctrl+I" = {
        action = "move-column-to-workspace-up";
      };

      # Alternative workspace movement (commented in original)
      # "Mod+Ctrl+Page_Down" = {
      #   action = "move-window-to-workspace-down";
      # };

      "Mod+Shift+Page_Down" = {
        action = "move-workspace-down";
      };

      "Mod+Shift+Page_Up" = {
        action = "move-workspace-up";
      };

      "Mod+Shift+U" = {
        action = "move-workspace-down";
      };

      "Mod+Shift+I" = {
        action = "move-workspace-up";
      };

      # Mouse wheel workspace navigation
      "Mod+WheelScrollDown" = {
        action = "focus-workspace-down";
        parameters = {
          cooldown-ms = 150;
        };
      };

      "Mod+WheelScrollUp" = {
        action = "focus-workspace-up";
        parameters = {
          cooldown-ms = 150;
        };
      };

      "Mod+Ctrl+WheelScrollDown" = {
        action = "move-column-to-workspace-down";
        parameters = {
          cooldown-ms = 150;
        };
      };

      "Mod+Ctrl+WheelScrollUp" = {
        action = "move-column-to-workspace-up";
        parameters = {
          cooldown-ms = 150;
        };
      };

      # Mouse wheel column navigation
      "Mod+WheelScrollRight" = {
        action = "focus-column-right";
      };

      "Mod+WheelScrollLeft" = {
        action = "focus-column-left";
      };

      "Mod+Ctrl+WheelScrollRight" = {
        action = "move-column-right";
      };

      "Mod+Ctrl+WheelScrollLeft" = {
        action = "move-column-left";
      };

      "Mod+Shift+WheelScrollDown" = {
        action = "focus-column-right";
      };

      "Mod+Shift+WheelScrollUp" = {
        action = "focus-column-left";
      };

      "Mod+Ctrl+Shift+WheelScrollDown" = {
        action = "move-column-right";
      };

      "Mod+Ctrl+Shift+WheelScrollUp" = {
        action = "move-column-left";
      };

      # Touchpad scroll bindings (commented in original)
      # "Mod+TouchpadScrollDown" = {
      #   spawn = [ "sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02+" ];
      # };
      # "Mod+TouchpadScrollUp" = {
      #   spawn = [ "sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02-" ];
      # };

      # Workspace index navigation
      "Mod+1" = {
        action = "focus-workspace 1";
      };

      "Mod+2" = {
        action = "focus-workspace 2";
      };

      "Mod+3" = {
        action = "focus-workspace 3";
      };

      "Mod+4" = {
        action = "focus-workspace 4";
      };

      "Mod+5" = {
        action = "focus-workspace 5";
      };

      "Mod+6" = {
        action = "focus-workspace 6";
      };

      "Mod+7" = {
        action = "focus-workspace 7";
      };

      "Mod+8" = {
        action = "focus-workspace 8";
      };

      "Mod+9" = {
        action = "focus-workspace 9";
      };

      "Mod+Ctrl+1" = {
        action = "move-column-to-workspace 1";
      };

      "Mod+Ctrl+2" = {
        action = "move-column-to-workspace 2";
      };

      "Mod+Ctrl+3" = {
        action = "move-column-to-workspace 3";
      };

      "Mod+Ctrl+4" = {
        action = "move-column-to-workspace 4";
      };

      "Mod+Ctrl+5" = {
        action = "move-column-to-workspace 5";
      };

      "Mod+Ctrl+6" = {
        action = "move-column-to-workspace 6";
      };

      "Mod+Ctrl+7" = {
        action = "move-column-to-workspace 7";
      };

      "Mod+Ctrl+8" = {
        action = "move-column-to-workspace 8";
      };

      "Mod+Ctrl+9" = {
        action = "move-column-to-workspace 9";
      };

      # Alternative single window movement (commented in original)
      # "Mod+Ctrl+1" = {
      #   action = "move-window-to-workspace 1";
      # };

      # Previous workspace (commented in original)
      # "Mod+Tab" = {
      #   action = "focus-workspace-previous";
      # };

      # Column window management
      "Mod+BracketLeft" = {
        action = "consume-or-expel-window-left";
      };

      "Mod+BracketRight" = {
        action = "consume-or-expel-window-right";
      };

      "Mod+Comma" = {
        action = "consume-window-into-column";
      };

      "Mod+Period" = {
        action = "expel-window-from-column";
      };

      # Window sizing
      "Mod+R" = {
        action = "switch-preset-column-width";
      };

      # Alternative reverse cycling (commented in original)
      # "Mod+R" = {
      #   action = "switch-preset-column-width-back";
      # };

      "Mod+Shift+R" = {
        action = "switch-preset-window-height";
      };

      "Mod+Ctrl+R" = {
        action = "reset-window-height";
      };

      "Mod+F" = {
        action = "maximize-column";
      };

      "Mod+Shift+F" = {
        action = "fullscreen-window";
      };

      "Mod+Ctrl+F" = {
        action = "expand-column-to-available-width";
      };

      # Centering
      "Mod+C" = {
        action = "center-column";
      };

      "Mod+Ctrl+C" = {
        action = "center-visible-columns";
      };

      # Width adjustments
      "Mod+Minus" = {
        action = "set-column-width \"-10%\"";
      };

      "Mod+Equal" = {
        action = "set-column-width \"+10%\"";
      };

      # Height adjustments
      "Mod+Shift+Minus" = {
        action = "set-window-height \"-10%\"";
      };

      "Mod+Shift+Equal" = {
        action = "set-window-height \"+10%\"";
      };

      # Floating windows
      "Mod+V" = {
        action = "toggle-window-floating";
      };

      "Mod+Shift+V" = {
        action = "switch-focus-between-floating-and-tiling";
      };

      # Tabbed display
      "Mod+W" = {
        action = "toggle-column-tabbed-display";
      };

      # Layout switching (commented in original)
      # "Mod+Space" = {
      #   action = "switch-layout \"next\"";
      # };
      # "Mod+Shift+Space" = {
      #   action = "switch-layout \"prev\"";
      # };

      # Screenshots
      "Print" = {
        action = "screenshot";
      };

      "Ctrl+Print" = {
        action = "screenshot-screen";
      };

      "Alt+Print" = {
        action = "screenshot-window";
      };

      # Keyboard shortcuts inhibit toggle
      "Mod+Escape" = {
        action = "toggle-keyboard-shortcuts-inhibit";
        parameters = {
          allow-inhibiting = false;
        };
      };

      # Quit
      "Mod+Shift+E" = {
        action = "quit";
      };

      "Ctrl+Alt+Delete" = {
        action = "quit";
      };

      # Power off monitors
      "Mod+Shift+P" = {
        action = "power-off-monitors";
      };
    };
  };

  users.users.mcsimw.enable = true;
}
