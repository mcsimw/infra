{ self' }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myShit.users.mcsimw.enable;
  dwlEnabled = lib.attrByPath [ "myShit" "dwl" "enable" ] false config;
  dwl = pkgs.writeShellApplication {
    name = "dwl";
    runtimeInputs = [
      self'.packages.dwl
      pkgs.swaybg
    ];
    text = ''
      dwl -s "
        dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP=dwl;
        systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_SESSION_TYPE;
        systemctl --user start yes.target;
        swaybg -c '#CC0077'
      "
    '';
  };
in
{
  options.myShit.users.mcsimw.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "Whether to enable mcsimw.";
  };

  config = lib.mkIf cfg {
    systemd.user.targets.yes = {
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
    };

    preservation.preserveAt."/persist".users.mcsimw = {
      commonMountOptions = [
        "x-gvfs-hide"
      ];
      directories = [
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".mozilla"
      ];
    };

    users.users.mcsimw = {
      description = "Maor Haimovitz";
      isNormalUser = true;
      linger = true;
      extraGroups = [ "wheel" ] ++ (import ./_extraGroups.nix { inherit config lib; });
      uid = 1000;
      initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
      packages = [ self'.packages.neovim ] ++ lib.optionals dwlEnabled [ dwl ];
    };

    home-manager.users.mcsimw = {
      home.username = "mcsimw";
      home.homeDirectory = "/home/mcsimw";
      home.stateVersion = "25.05";
      programs = {
        eza.enable = true;
        bat = {
          enable = true;
          config = {
            theme = "modus_vivendi";
          };
          themes = {
            modus_vivendi = {
              src = pkgs.fetchFromGitHub {
                owner = "miikanissi";
                repo = "modus-themes.nvim";
                rev = "b6c46f8066b2d96cb75d5bc7202a9a4c097b5e9f";
                sha256 = "sha256-mAJoh6SuS4PKCXJw3t3aLkdoGI/CB4qZ7xl4OB3TWJc=";
              };
              file = "extras/bat/modus_vivendi.tmTheme";
            };
          };
        };
        git = {
          enable = true;
          userName = "Maor Haimovitz";
          userEmail = "maor@mcsimw.com";
        };
      };
    };

    systemd.tmpfiles.settings.preservation = {
      "/home/mcsimw/.config".d = {
        user = "mcsimw";
        group = "users";
        mode = "0755";
      };
      "/home/mcsimw/.local".d = {
        user = "mcsimw";
        group = "users";
        mode = "0755";
      };
      "/home/mcsimw/.local/share".d = {
        user = "mcsimw";
        group = "users";
        mode = "0755";
      };
      "/home/mcsimw/.local/state".d = {
        user = "mcsimw";
        group = "users";
        mode = "0755";
      };
    };
  };
}
