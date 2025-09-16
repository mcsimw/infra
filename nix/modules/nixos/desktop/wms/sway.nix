{ moduleWithSystem, ... }:
{
  flake.modules.nixos.infra = moduleWithSystem (
    { pkgs, ... }:
    {
      config,
      lib,
      ...
    }:
    {
      config =
        lib.mkIf
          (config.analfabeta.desktop.enable && (builtins.elem "sway" config.analfabeta.desktop.compositors))
          {
            analfabeta.desktop = {
              wlroots = true;
              minimal = true;
            };
            programs.sway = {
              enable = true;
              package = pkgs.sway_git;
              wrapperFeatures.gtk = true;
              #export WLR_RENDERER=vulkan
              extraSessionCommands = ''
                export SDL_VIDEODRIVER=wayland
                export QT_QPA_PLATFORM=wayland
                export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
                export JAVA_AWT_WM_NONREPARENTING=1
                export MOZ_ENABLE_WAYLAND=1
                export MOZ_WEBRENDER=1
                export XDG_SESSION_TYPE=wayland
                export XDG_CURRENT_DESKTOP=dwl
                export GDK_BACKEND=wayland
                export NIXOS_OZONE_WL=1
                export ELECTRON_OZONE_PLATFORM_HINT=wayland
              '';
            };
          };
    }
  );
}
