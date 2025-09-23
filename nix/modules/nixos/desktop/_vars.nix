config:
let
  prog = config.analfabeta.programs;
in
rec {
  desktop = wlroots || smithay;
  wlroots = prog.dwl.enable || prog.sway.enable;
  smithay = prog.niri.enable;
  minimalWayland = prog.dwl.enable || prog.sway.enable || prog.niri.enable;
  minimal = minimalWayland;
  wayland = wlroots || smithay;
}
