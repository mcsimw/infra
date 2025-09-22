config:
let
  prog = config.analfabeta.programs;
in
rec {
  desktop = prog.dwl.enable || prog.sway.enable;
  wlroots = prog.dwl.enable || prog.sway.enable;
  minimalWayland = prog.dwl.enable || prog.sway.enable;
  minimal = minimalWayland;
  wayland = wlroots;
}
