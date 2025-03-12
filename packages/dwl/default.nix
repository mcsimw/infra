{
  lib,
  fetchFromGitea,
  installShellFiles,
  libinput,
  libxkbcommon,
  pixman,
  pkg-config,
  stdenv,
  testers,
  wayland,
  new-wayland-protocols,
  wayland-scanner,
  wlroots,
  writeText,
  xwayland,
  # Boolean flags
  enableXWayland ? true,
  withCustomConfigH ? (configH != null),
  # Configurable options
  configH ?
    if conf != null then
      lib.warn ''
        conf parameter is deprecated;
        use configH instead
      '' conf
    else
      null,
  # Deprecated options
  # Remove them before next version of either Nixpkgs or dwl itself
  conf ? null,
  pkgs,
}:

# If we set withCustomConfigH, let's not forget configH
assert withCustomConfigH -> (configH != null);
stdenv.mkDerivation (finalAttrs: {
  pname = "dwl";
  version = "master";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "dwl";
    repo = "dwl";
    rev = "aa69ed81b558f74e470e69cdcd442f9048ee624c";
    hash = "sha256-qO7k2Sj4nWrXrM2FwNkgnAK2D76bIWa2q625k3jDBUA";
  };

  nativeBuildInputs = [
    installShellFiles
    pkg-config
    wayland-scanner
  ];

  buildInputs =
    [
      libinput
      pkgs.xorg.libxcb
      libxkbcommon
      pixman
      wayland
      new-wayland-protocols
      wlroots
    ]
    ++ lib.optionals enableXWayland [
      pkgs.xorg.libX11
      pkgs.xorg.xcbutilwm
      xwayland
    ];

  outputs = [
    "out"
    "man"
  ];

  postPatch =
    let
      configFile =
        if lib.isDerivation configH || builtins.isPath configH then
          configH
        else
          writeText "config.h" configH;
    in
    lib.optionalString withCustomConfigH "cp ${configFile} config.h";

  makeFlags =
    [
      "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
      "WAYLAND_SCANNER=wayland-scanner"
      "PREFIX=$(out)"
      "MANDIR=$(man)/share/man"
    ]
    ++ lib.optionals enableXWayland [
      ''XWAYLAND="-DXWAYLAND"''
      ''XLIBS="xcb xcb-icccm"''
    ];

  strictDeps = true;

  # required for whitespaces in makeFlags
  __structuredAttrs = true;

  passthru = {
    tests.version = testers.testVersion {
      package = finalAttrs.finalPackage;
      # `dwl -v` emits its version string to stderr and returns 1
      command = "dwl -v 2>&1; return 0";
    };
  };

  meta = {
    homepage = "https://codeberg.org/dwl/dwl";
    changelog = "https://codeberg.org/dwl/dwl/src/branch/${finalAttrs.version}/CHANGELOG.md";
    description = "Dynamic window manager for Wayland";
    longDescription = ''
      dwl is a compact, hackable compositor for Wayland based on wlroots. It is
      intended to fill the same space in the Wayland world that dwm does in X11,
      primarily in terms of philosophy, and secondarily in terms of
      functionality. Like dwm, dwl is:

      - Easy to understand, hack on, and extend with patches
      - One C source file (or a very small number) configurable via config.h
      - Tied to as few external dependencies as possible
    '';
    license = lib.licenses.gpl3Only;
    maintainers = [ lib.maintainers.AndersonTorres ];
    inherit (wayland.meta) platforms;
    mainProgram = "dwl";
  };
})
# TODO: custom patches from upstream website
