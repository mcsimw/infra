{
  pkgs,
  config,
  lib,
  ...
}:

lib.mkMerge [
  {
    services.blueman.enable = config.hardware.bluetooth.enable;
    environment.systemPackages = with pkgs; [
      sway-contrib.grimshot
      slurp
      swaybg
    ];
    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };
  }
  (import ./_wayland.nix { inherit pkgs; })
  (import ./_tilingwm.nix { inherit pkgs; })
]
