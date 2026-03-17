args@{ config, desktops, ... }:
{
  nixpkgs.overlays = [
    (import "${config.sources.nixpkgs-wayland}/overlay.nix")
  ];
  flake.modules.nixos = {
    default = config.flake.modules.nixos.desktop-packages;
    desktop-packages =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      let
        inherit (lib)
          mkIf
          optionals
          optional
          ;
        inherit (builtins) any attrNames;
        inherit (desktops) byName;
        isWaylandWM =
          cfg: name:
          let
            desktop = byName.${name};
          in
          desktop.check cfg && desktop.protocol == "wayland" && desktop.type == "wm";
        hasWaylandWM = cfg: any (isWaylandWM cfg) (attrNames byName);
        hasAnyDesktop = cfg: any (name: byName.${name}.check cfg) (attrNames byName);
        hasWayland =
          cfg:
          any (name: byName.${name}.check cfg && byName.${name}.protocol == "wayland") (attrNames byName);
        hasAnyWM =
          cfg: any (name: byName.${name}.check cfg && byName.${name}.type == "wm") (attrNames byName);
      in
      {
        environment.systemPackages = mkIf (hasAnyDesktop config) (
          with pkgs;
          [
            mpv
            ani-cli
            adwaita-icon-theme
            signal-desktop
            #krita
            gimp
            #libreoffice-fresh
            vesktop
            bitwarden-desktop
            obs-studio
            blender
            zoom-us
            telegram-desktop
            (pkgs.callPackage (import "${args.config.sources.vicinae}/nix/vicinae.nix") { })
          ]
          ++ optionals (hasWaylandWM config) [
            nautilus
            imv
            swaybg
          ]
          ++ optional (hasWayland config) wl-clipboard-rs
          ++ optional (hasAnyWM config) zathura
          ++ optional config.services.pipewire.enable pwvucontrol
        );
      };
  };
}
