{ inputs, self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.dwl = pkgs.callPackage (
        {
          lib,
          installShellFiles,
          libinput,
          libxcb,
          libxkbcommon,
          pixman,
          pkg-config,
          stdenv,
          nixosTests,
          testers,
          wayland,
          wayland-protocols,
          wayland-scanner,
          wlroots,
          libX11,
          xcbutilwm,
          xwayland,
          enableXWayland ? true, # for some reason kinda broken in dwl
        }:

        stdenv.mkDerivation (finalAttrs: {
          pname = "dwl";
          version = inputs.dwl.rev;

          src = inputs.dwl;

          nativeBuildInputs = [
            installShellFiles
            pkg-config
            wayland-scanner
          ];

          buildInputs =
            [
              libinput
              libxcb
              libxkbcommon
              pixman
              wayland
              wayland-protocols
              wlroots
            ]
            ++ lib.optionals enableXWayland [
              libX11
              xcbutilwm
              xwayland
            ];

          outputs = [
            "out"
            "man"
          ];

          patches = [
            inputs.center
            (self + "/dwl/today.patch")
          ];

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

          __structuredAttrs = true;

          passthru.tests = {
            version = testers.testVersion {
              package = finalAttrs.finalPackage;
              command = "dwl -v 2>&1; return 0";
            };
            basic = nixosTests.dwl;
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
            inherit (wayland.meta) platforms;
            mainProgram = "dwl";
          };
        })
      ) { };
    };
}
