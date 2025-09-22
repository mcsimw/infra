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
      cfg = config.analfabeta.programs.sway;
    in
    {
      options.analfabeta.programs.sway = {
        enable = lib.mkEnableOption "sway";
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.sway_git;
          description = "The sway package to use";
        };
      };

      config = lib.mkIf cfg.enable {
        programs.sway = {
          enable = true;
          inherit (cfg) package;
          wrapperFeatures.gtk = true;
          extraSessionCommands = ''
            export SDL_VIDEODRIVER=wayland
            export QT_QPA_PLATFORM=wayland
            export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
            export JAVA_AWT_WM_NONREPARENTING=1
            export MOZ_ENABLE_WAYLAND=1
            export MOZ_WEBRENDER=1
            export XDG_SESSION_TYPE=wayland
            export XDG_CURRENT_DESKTOP=sway
            export GDK_BACKEND=wayland
            export NIXOS_OZONE_WL=1
            export ELECTRON_OZONE_PLATFORM_HINT=wayland
          '';
        };
      };
    }
  );
}
