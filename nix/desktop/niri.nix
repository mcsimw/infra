{ config, lib, ... }:
let
  inherit (config) sources;
  inherit (lib) genAttrs;
  fakeNixpkgs = {
    _type = "flake";
    inherit lib;
    packages = genAttrs systems (system: config.nixpkgs.pkgs.${system});
    legacyPackages = genAttrs systems (system: config.nixpkgs.pkgs.${system});
    outPath = sources.nixpkgs;
    __toString = _: sources.nixpkgs;
  };
  callFlakeWithInputs =
    flakeSrc: overrideInputs: revision:
    let
      flake = import (flakeSrc + "/flake.nix");
      outputs = flake.outputs (
        overrideInputs
        // {
          self = outputs // {
            outPath = flakeSrc;
            __toString = _: flakeSrc;
            inputs = overrideInputs;
            rev = revision;
            shortRev = builtins.substring 0 7 revision;
            lastModified = 0;
            lastModifiedDate = "19700101";
          };
        }
      );
    in
    outputs;
  systems = import sources.default-linux;
  niriOutputs = callFlakeWithInputs sources.niri {
    inherit (sources) nixpkgs rust-overlay;
  } sources.niri.revision;
  xwaylandSatelliteOutputs = callFlakeWithInputs sources.xwayland-satellite {
    nixpkgs = fakeNixpkgs;
    inherit (sources) rust-overlay;
  } sources.xwayland-satellite.revision;

  niriFlakeOutputs = callFlakeWithInputs sources.niri-flake {
    nixpkgs = {
      _type = "flake";
      inherit lib;
      legacyPackages = genAttrs systems (system: config.nixpkgs.pkgs.${system});
      outPath = sources.nixpkgs;
      __toString = _: sources.nixpkgs;
    };
    nixpkgs-stable = {
      _type = "flake";
      inherit lib;
      legacyPackages = genAttrs systems (system: config.nixpkgs.pkgs.${system});
      outPath = sources.nixpkgs;
      __toString = _: sources.nixpkgs;
    };
    niri-stable = sources.niri;
    niri-unstable = sources.niri;
    xwayland-satellite-stable = sources.xwayland-satellite;
    xwayland-satellite-unstable = sources.xwayland-satellite;
  } sources.niri-flake.revision;
in
{
  nixpkgs.overlays = [
    niriOutputs.overlays.default
    (final: _: {
      xwayland-satellite = xwaylandSatelliteOutputs.packages.${final.stdenv.hostPlatform.system}.default;
    })
  ];
  flake = {
    packages = genAttrs systems (system: {
      xwayland-satellite = xwaylandSatelliteOutputs.packages.${system}.default;
    });
    modules.nixos = {
      default =
        { lib, ... }:
        let
          inherit (lib) mkDefault;
        in
        {
          imports = [ config.flake.modules.nixos.niri ];
          programs.niri.settings = {
            input = {
              keyboard.numlock = mkDefault true;
              touchpad = {
                tap = mkDefault true;
                natural-scroll = mkDefault true;
                accel-profile = mkDefault "flat";
              };
              mouse.accel-profile = mkDefault "flat";
            };
            layout = {
              gaps = mkDefault 0;
              background-color = mkDefault "#CC0077";
              center-focused-column = mkDefault "never";
              preset-column-widths = mkDefault [
                { proportion = 0.33333; }
                { proportion = 0.5; }
                { proportion = 0.66667; }
              ];
              default-column-width = mkDefault { proportion = 0.5; };
              focus-ring = {
                enable = mkDefault false;
                width = mkDefault 4;
                active.color = mkDefault "#ffffff";
                inactive.color = mkDefault "#505050";
              };
            };
            hotkey-overlay.skip-at-startup = mkDefault true;
            prefer-no-csd = mkDefault true;
            screenshot-path = mkDefault "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
            animations.enable = mkDefault false;
            cursor = {
              size = 14;
              theme = "WhiteSur Cursors";
            };
            binds = {
              "Mod+Shift+Slash" = mkDefault {
                action.show-hotkey-overlay = [ ];
              };
              "Mod+T" = mkDefault {
                action.spawn = "foot";
                hotkey-overlay.title = "Open a Terminal: foot";
              };
              "Mod+E" = mkDefault {
                action.spawn = "nautilus";
                hotkey-overlay.title = "Open a File Manager: nautilus";
              };
              "Mod+D" = mkDefault {
                action.spawn = "wmenu-run";
                hotkey-overlay.title = "Run an Application: wmenu";
              };
              "Super+Alt+L" = mkDefault {
                action.spawn = "swaylock";
                hotkey-overlay.title = "Lock the Screen: swaylock";
              };
              "Super+Alt+S" = mkDefault {
                action.spawn-sh = "pkill orca || exec orca";
                allow-when-locked = true;
                hotkey-overlay.hidden = true;
              };
              "Mod+O" = mkDefault {
                action.toggle-overview = [ ];
                repeat = false;
              };
              "Mod+Q" = mkDefault {
                action.close-window = [ ];
                repeat = false;
              };
              "Alt+F4" = mkDefault {
                action.close-window = [ ];
                repeat = false;
              };
              "Mod+Left" = mkDefault { action.focus-column-left = [ ]; };
              "Mod+Down" = mkDefault { action.focus-window-down = [ ]; };
              "Mod+Up" = mkDefault { action.focus-window-up = [ ]; };
              "Mod+Right" = mkDefault { action.focus-column-right = [ ]; };
              "Mod+H" = mkDefault { action.focus-column-left = [ ]; };
              "Mod+J" = mkDefault { action.focus-window-down = [ ]; };
              "Mod+K" = mkDefault { action.focus-window-up = [ ]; };
              "Mod+L" = mkDefault { action.focus-column-right = [ ]; };
              "Mod+Ctrl+Left" = mkDefault { action.move-column-left = [ ]; };
              "Mod+Ctrl+Down" = mkDefault { action.move-window-down = [ ]; };
              "Mod+Ctrl+Up" = mkDefault { action.move-window-up = [ ]; };
              "Mod+Ctrl+Right" = mkDefault { action.move-column-right = [ ]; };
              "Mod+Ctrl+H" = mkDefault { action.move-column-left = [ ]; };
              "Mod+Ctrl+J" = mkDefault { action.move-window-down = [ ]; };
              "Mod+Ctrl+K" = mkDefault { action.move-window-up = [ ]; };
              "Mod+Ctrl+L" = mkDefault { action.move-column-right = [ ]; };
              "Mod+Home" = mkDefault { action.focus-column-first = [ ]; };
              "Mod+End" = mkDefault { action.focus-column-last = [ ]; };
              "Mod+Ctrl+Home" = mkDefault { action.move-column-to-first = [ ]; };
              "Mod+Ctrl+End" = mkDefault { action.move-column-to-last = [ ]; };
              "Mod+Shift+Left" = mkDefault { action.focus-monitor-left = [ ]; };
              "Mod+Shift+Down" = mkDefault { action.focus-monitor-down = [ ]; };
              "Mod+Shift+Up" = mkDefault { action.focus-monitor-up = [ ]; };
              "Mod+Shift+Right" = mkDefault { action.focus-monitor-right = [ ]; };
              "Mod+Shift+H" = mkDefault { action.focus-monitor-left = [ ]; };
              "Mod+Shift+J" = mkDefault { action.focus-monitor-down = [ ]; };
              "Mod+Shift+K" = mkDefault { action.focus-monitor-up = [ ]; };
              "Mod+Shift+L" = mkDefault { action.focus-monitor-right = [ ]; };
              "Mod+Shift+Ctrl+Left" = mkDefault { action.move-column-to-monitor-left = [ ]; };
              "Mod+Shift+Ctrl+Down" = mkDefault { action.move-column-to-monitor-down = [ ]; };
              "Mod+Shift+Ctrl+Up" = mkDefault { action.move-column-to-monitor-up = [ ]; };
              "Mod+Shift+Ctrl+Right" = mkDefault { action.move-column-to-monitor-right = [ ]; };
              "Mod+Shift+Ctrl+H" = mkDefault { action.move-column-to-monitor-left = [ ]; };
              "Mod+Shift+Ctrl+J" = mkDefault { action.move-column-to-monitor-down = [ ]; };
              "Mod+Shift+Ctrl+K" = mkDefault { action.move-column-to-monitor-up = [ ]; };
              "Mod+Shift+Ctrl+L" = mkDefault { action.move-column-to-monitor-right = [ ]; };
              "Mod+Page_Down" = mkDefault { action.focus-workspace-down = [ ]; };
              "Mod+Page_Up" = mkDefault { action.focus-workspace-up = [ ]; };
              "Mod+U" = mkDefault { action.focus-workspace-down = [ ]; };
              "Mod+I" = mkDefault { action.focus-workspace-up = [ ]; };
              "Mod+Ctrl+Page_Down" = mkDefault { action.move-column-to-workspace-down = [ ]; };
              "Mod+Ctrl+Page_Up" = mkDefault { action.move-column-to-workspace-up = [ ]; };
              "Mod+Ctrl+U" = mkDefault { action.move-column-to-workspace-down = [ ]; };
              "Mod+Ctrl+I" = mkDefault { action.move-column-to-workspace-up = [ ]; };
              "Mod+Shift+Page_Down" = mkDefault { action.move-workspace-down = [ ]; };
              "Mod+Shift+Page_Up" = mkDefault { action.move-workspace-up = [ ]; };
              "Mod+Shift+U" = mkDefault { action.move-workspace-down = [ ]; };
              "Mod+Shift+I" = mkDefault { action.move-workspace-up = [ ]; };
              "Mod+WheelScrollDown" = mkDefault {
                action.focus-workspace-down = [ ];
                cooldown-ms = 150;
              };
              "Mod+WheelScrollUp" = mkDefault {
                action.focus-workspace-up = [ ];
                cooldown-ms = 150;
              };
              "Mod+Ctrl+WheelScrollDown" = mkDefault {
                action.move-column-to-workspace-down = [ ];
                cooldown-ms = 150;
              };
              "Mod+Ctrl+WheelScrollUp" = mkDefault {
                action.move-column-to-workspace-up = [ ];
                cooldown-ms = 150;
              };
              "Mod+WheelScrollRight" = mkDefault { action.focus-column-right = [ ]; };
              "Mod+WheelScrollLeft" = mkDefault { action.focus-column-left = [ ]; };
              "Mod+Ctrl+WheelScrollRight" = mkDefault { action.move-column-right = [ ]; };
              "Mod+Ctrl+WheelScrollLeft" = mkDefault { action.move-column-left = [ ]; };
              "Mod+Shift+WheelScrollDown" = mkDefault { action.focus-column-right = [ ]; };
              "Mod+Shift+WheelScrollUp" = mkDefault { action.focus-column-left = [ ]; };
              "Mod+Ctrl+Shift+WheelScrollDown" = mkDefault { action.move-column-right = [ ]; };
              "Mod+Ctrl+Shift+WheelScrollUp" = mkDefault { action.move-column-left = [ ]; };
              "Mod+1" = mkDefault { action.focus-workspace = 1; };
              "Mod+2" = mkDefault { action.focus-workspace = 2; };
              "Mod+3" = mkDefault { action.focus-workspace = 3; };
              "Mod+4" = mkDefault { action.focus-workspace = 4; };
              "Mod+5" = mkDefault { action.focus-workspace = 5; };
              "Mod+6" = mkDefault { action.focus-workspace = 6; };
              "Mod+7" = mkDefault { action.focus-workspace = 7; };
              "Mod+8" = mkDefault { action.focus-workspace = 8; };
              "Mod+9" = mkDefault { action.focus-workspace = 9; };
              "Mod+Ctrl+1" = mkDefault { action.move-column-to-workspace = 1; };
              "Mod+Ctrl+2" = mkDefault { action.move-column-to-workspace = 2; };
              "Mod+Ctrl+3" = mkDefault { action.move-column-to-workspace = 3; };
              "Mod+Ctrl+4" = mkDefault { action.move-column-to-workspace = 4; };
              "Mod+Ctrl+5" = mkDefault { action.move-column-to-workspace = 5; };
              "Mod+Ctrl+6" = mkDefault { action.move-column-to-workspace = 6; };
              "Mod+Ctrl+7" = mkDefault { action.move-column-to-workspace = 7; };
              "Mod+Ctrl+8" = mkDefault { action.move-column-to-workspace = 8; };
              "Mod+Ctrl+9" = mkDefault { action.move-column-to-workspace = 9; };
              "Mod+BracketLeft" = mkDefault { action.consume-or-expel-window-left = [ ]; };
              "Mod+BracketRight" = mkDefault { action.consume-or-expel-window-right = [ ]; };
              "Mod+Comma" = mkDefault { action.consume-window-into-column = [ ]; };
              "Mod+Period" = mkDefault { action.expel-window-from-column = [ ]; };
              "Mod+R" = mkDefault { action.switch-preset-column-width = [ ]; };
              "Mod+Shift+R" = mkDefault { action.switch-preset-window-height = [ ]; };
              "Mod+Ctrl+R" = mkDefault { action.reset-window-height = [ ]; };
              "Mod+F" = mkDefault { action.maximize-column = [ ]; };
              "Mod+Shift+F" = mkDefault { action.fullscreen-window = [ ]; };
              "Mod+Ctrl+F" = mkDefault { action.expand-column-to-available-width = [ ]; };
              "Mod+C" = mkDefault { action.center-column = [ ]; };
              "Mod+Ctrl+C" = mkDefault { action.center-visible-columns = [ ]; };
              "Mod+Minus" = mkDefault { action.set-column-width = "-10%"; };
              "Mod+Equal" = mkDefault { action.set-column-width = "+10%"; };
              "Mod+Shift+Minus" = mkDefault { action.set-window-height = "-10%"; };
              "Mod+Shift+Equal" = mkDefault { action.set-window-height = "+10%"; };
              "Mod+V" = mkDefault { action.toggle-window-floating = [ ]; };
              "Mod+Shift+V" = mkDefault { action.switch-focus-between-floating-and-tiling = [ ]; };
              "Mod+W" = mkDefault { action.toggle-column-tabbed-display = [ ]; };
              "Print" = mkDefault { action.screenshot = [ ]; };
              "Ctrl+Print" = mkDefault { action.screenshot-screen = [ ]; };
              "Alt+Print" = mkDefault { action.screenshot-window = [ ]; };
              "Mod+Escape" = mkDefault {
                action.toggle-keyboard-shortcuts-inhibit = [ ];
                allow-inhibiting = false;
              };
              "Mod+Shift+E" = mkDefault { action.quit = [ ]; };
              "Ctrl+Alt+Delete" = mkDefault { action.quit = [ ]; };
              "Mod+Shift+P" = mkDefault { action.power-off-monitors = [ ]; };
            };
          };
        };
      niri =
        {
          lib,
          config,
          pkgs,
          ...
        }:
        let
          inherit (lib)
            mkIf
            mkMerge
            mkOption
            mkDefault
            getExe
            ;
          cfg = config.programs.niri;
          niri-flake-lib = niriFlakeOutputs.lib;
          validatedConfig =
            let
              niri-cfg-modules = lib.evalModules {
                modules = [
                  niri-flake-lib.internal.settings-module
                  { programs.niri.settings = cfg.settings; }
                ];
              };
            in
            niri-flake-lib.internal.validated-config-for pkgs cfg.package
              niri-cfg-modules.config.programs.niri.finalConfig;
        in
        {
          options.programs.niri = {
            settings = mkOption {
              type = lib.types.submodule {
                freeformType = (pkgs.formats.json { }).type;
              };
              default = { };
              description = "Global niri settings";
            };
          };
          config = mkMerge [
            { programs.niri.package = mkDefault pkgs.niri; }
            (mkIf cfg.enable {
              programs.uwsm = {
                enable = mkDefault true;
                waylandCompositors.niri = {
                  prettyName = "Niri";
                  comment = "Niri compositor managed by UWSM";
                  binPath = pkgs.writeShellScript "niri" ''
                    ${getExe cfg.package} --session
                  '';
                };
              };
              xdg.portal.config.niri.default = mkDefault [
                "gnome"
                "gtk"
              ];
              environment.systemPackages = [ pkgs.xwayland-satellite ];
              environment.etc."niri/config.kdl".source = validatedConfig;
            })
          ];
        };
    };
  };
}
