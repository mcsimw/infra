{ moduleWithSystem, ... }:
{
  flake.modules.nixos.infra = moduleWithSystem (
    { pkgs, ... }:
    {
      config,
      lib,
      ...
    }:
    let
      cfg = config.analfabeta.programs.dwl;

      buildInputsToRemove = with pkgs; [
        wlroots
        wayland-protocols
      ];

      nativeBuildInputsToRemove = with pkgs; [
        wayland-scanner
      ];

      replacementBuildInputs = with pkgs; [
        wlroots_0_19
        new-wayland-protocols
      ];

      replacementNativeBuildInputs = with pkgs; [
        wayland-scanner_git
      ];

      filterBuildInputs = pkg: !builtins.elem pkg buildInputsToRemove;
      filterNativeBuildInputs = pkg: !builtins.elem pkg nativeBuildInputsToRemove;

      package = pkgs.dwl.overrideAttrs (oldAttrs: rec {
        version = "main";
        src = pkgs.fetchFromGitea {
          domain = "codeberg.org";
          owner = "dwl";
          repo = "dwl";
          rev = "main";
          hash = "sha256-AvhGE0PGlwtX+wn59kw+9cH3vHa3S+REEOD9IIzHNxU=";
        };
        buildInputs = (lib.filter filterBuildInputs oldAttrs.buildInputs) ++ replacementBuildInputs;
        nativeBuildInputs =
          (lib.filter filterNativeBuildInputs oldAttrs.nativeBuildInputs) ++ replacementNativeBuildInputs;
      });
    in
    {
      options.analfabeta.programs.dwl.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable some feature (enabled by default)";
      };
      config = lib.mkIf cfg.enable {
        programs.dwl = {
          enable = true;
          inherit package;
          extraSessionCommands = ''
            export SDL_VIDEODRIVER=wayland
            export QT_QPA_PLATFORM=wayland
            export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
            export JAVA_AWT_WM_NONREPARENTING=1
            export MOZ_ENABLE_WAYLAND=1
            export MOZ_WEBRENDER=1
            export XDG_SESSION_TYPE=wayland
            export XDG_CURRENT_DESKTOP=dwl
            export WLR_RENDERER=vulkan
            export GDK_BACKEND=wayland
            export NIXOS_OZONE_WL=1
            export ELECTRON_OZONE_PLATFORM_HINT=wayland
          '';
        };
      };
    }
  );
}
