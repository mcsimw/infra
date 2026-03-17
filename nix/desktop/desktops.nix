# Yes this was AI generated!! I am not writing all that
{ lib, ... }:
let
  desktops = {
    hyprland = {
      protocol = "wayland";
      compositor = "wlroots";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.programs.hyprland.enable;
    };
    sway = {
      protocol = "wayland";
      compositor = "wlroots";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.programs.sway.enable;
    };
    river = {
      protocol = "wayland";
      compositor = "wlroots";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.programs.river-classic.enable;
    };
    wayfire = {
      protocol = "wayland";
      compositor = "wlroots";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.programs.wayfire.enable;
    };
    niri = {
      protocol = "wayland";
      compositor = "smithay";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.programs.niri.enable;
    };
    gnome = {
      protocol = "wayland";
      toolkit = "gtk";
      type = "de";
      check = cfg: cfg.services.desktopManager.gnome.enable;
    };
    plasma = {
      protocol = "wayland";
      toolkit = "qt";
      type = "de";
      check = cfg: cfg.services.desktopManager.plasma6.enable;
    };
    i3 = {
      protocol = "x11";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.services.xserver.windowManager.i3.enable;
    };
    awesome = {
      protocol = "x11";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.services.xserver.windowManager.awesome.enable;
    };
    bspwm = {
      protocol = "x11";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.services.xserver.windowManager.bspwm.enable;
    };
    dwm = {
      protocol = "x11";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.services.xserver.windowManager.dwm.enable;
    };
    xmonad = {
      protocol = "x11";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.services.xserver.windowManager.xmonad.enable;
    };
    qtile = {
      protocol = "x11";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.services.xserver.windowManager.qtile.enable;
    };
    herbstluftwm = {
      protocol = "x11";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.services.xserver.windowManager.herbstluftwm.enable;
    };
    openbox = {
      protocol = "x11";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.services.xserver.windowManager.openbox.enable;
    };
    fluxbox = {
      protocol = "x11";
      type = "wm";
      toolkit = null;
      check = cfg: cfg.services.xserver.windowManager.fluxbox.enable;
    };
    xfce = {
      protocol = "both";
      toolkit = "gtk";
      type = "de";
      check = cfg: cfg.services.xserver.desktopManager.xfce.enable;
    };
    cinnamon = {
      protocol = "both";
      toolkit = "gtk";
      type = "de";
      check = cfg: cfg.services.xserver.desktopManager.cinnamon.enable;
    };
    budgie = {
      protocol = "both";
      toolkit = "gtk";
      type = "de";
      check = cfg: cfg.services.desktopManager.budgie.enable;
    };
    mate = {
      protocol = "x11";
      toolkit = "gtk";
      type = "de";
      check = cfg: cfg.services.xserver.desktopManager.mate.enable;
    };
    pantheon = {
      protocol = "x11";
      toolkit = "gtk";
      type = "de";
      check = cfg: cfg.services.desktopManager.pantheon.enable;
    };
    lxqt = {
      protocol = "x11";
      toolkit = "qt";
      type = "de";
      check = cfg: cfg.services.xserver.desktopManager.lxqt.enable;
    };
    enlightenment = {
      protocol = "x11";
      toolkit = "other";
      type = "de";
      check = cfg: cfg.services.xserver.desktopManager.enlightenment.enable;
    };
    lumina = {
      protocol = "x11";
      toolkit = "other";
      type = "de";
      check = cfg: cfg.services.xserver.desktopManager.lumina.enable;
    };
  };
  filterBy = attr: value: lib.attrNames (lib.filterAttrs (_: d: d.${attr} or null == value) desktops);
  uniqueValues =
    attr: lib.unique (lib.filter (v: v != null) (lib.catAttrs attr (lib.attrValues desktops)));
  groupBy = attr: lib.genAttrs (uniqueValues attr) (value: filterBy attr value);
in
{
  _module.args.desktops = {
    byName = desktops;
    byProtocol = groupBy "protocol";
    byCompositor = groupBy "compositor";
    byToolkit = groupBy "toolkit";
    byType = groupBy "type";
  };
}
