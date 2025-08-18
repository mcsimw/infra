{
  pkgs,
  ...
}:
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
