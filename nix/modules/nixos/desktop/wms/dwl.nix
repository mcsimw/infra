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
      # Packages to filter out from original buildInputs
      packagesToRemove = with pkgs; [
        wlroots
        wayland-protocols
      ];

      # Replacement packages
      replacementPackages = with pkgs; [
        wlroots_0_19
        new-wayland-protocols
      ];

      # Filter function to exclude unwanted packages
      filterPackages = pkg: !builtins.elem pkg packagesToRemove;

      package = pkgs.dwl.overrideAttrs (oldAttrs: rec {
        version = "main";

        src = pkgs.fetchFromGitea {
          domain = "codeberg.org";
          owner = "dwl";
          repo = "dwl";
          rev = "main";
          hash = "sha256-AvhGE0PGlwtX+wn59kw+9cH3vHa3S+REEOD9IIzHNxU=";
        };

        buildInputs = (lib.filter filterPackages oldAttrs.buildInputs) ++ replacementPackages;
      });
    in
    {
      config =
        lib.mkIf
          (config.analfabeta.desktop.enable && (builtins.elem "dwl" config.analfabeta.desktop.compositors))
          {
            analfabeta.desktop = {
              wlroots = true;
              minimal = true;
            };
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
