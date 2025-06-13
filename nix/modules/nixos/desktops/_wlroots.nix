{
  pkgs,
  lib,
  config,
  ...
}:

lib.mkMerge [
  {
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
  (import ./_tilingwm.nix { inherit pkgs config; })
]
