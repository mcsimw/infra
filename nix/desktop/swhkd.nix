{
  config,
  lib,
  desktops,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    optionals
    types
    ;
  inherit (builtins)
    any
    mapAttrs
    elem
    filter
    ;
  inherit (config) sources;
  version = sources.swhkd.revision or "unknown";
  mkSwhkdPackage =
    system:
    let
      pkgs = config.nixpkgs.pkgs.${system};
      inherit (pkgs)
        rustPlatform
        pkg-config
        udev
        stdenv
        ;
      inherit (stdenv) isDarwin;
      inherit (pkgs.darwin.apple_sdk.frameworks) IOKit;
    in
    rustPlatform.buildRustPackage {
      pname = "swhkd";
      src = sources.swhkd;
      inherit version;
      cargoLock = {
        lockFile = "${sources.swhkd}/Cargo.lock";
        outputHashes."sweet-0.4.0" = "sha256-Ky2afQ5HyO1a6YT8Jjl6az1jczq+MBKeuRmFwmcvg6U=";
      };
      nativeBuildInputs = [ pkg-config ];
      buildInputs = [ udev ] ++ optionals isDarwin [ IOKit ];
      meta = {
        description = "Sxhkd clone for Wayland (works on TTY and X11 too)";
        homepage = "https://github.com/waycrate/swhkd";
        changelog = "https://github.com/waycrate/swhkd/blob/${version}/CHANGELOG.md";
        license = lib.licenses.bsd2;
        mainProgram = "swhkd";
      };
    };
  swhkdPackages = mapAttrs (system: _: mkSwhkdPackage system) config.nixpkgs.pkgs;
in
{
  flake = {
    packages = mapAttrs (_: pkg: { swhkd = pkg; }) swhkdPackages;
    modules.nixos.swhkd =
      { config, pkgs, ... }:
      let
        inherit (desktops) byType byProtocol;
        inherit (pkgs.stdenv.hostPlatform) system;
        cfg = config.programs.swhkd;
        waylandWMs = byType.wm;
        waylandDEs = filter (n: elem n byProtocol.wayland) byType.de;
        allWaylandDesktops = waylandWMs ++ waylandDEs;
        hasWaylandWM = any (name: desktops.byName.${name}.check config) allWaylandDesktops;
      in
      {
        options.programs.swhkd = {
          enable = mkOption {
            type = types.bool;
            default = hasWaylandWM;
            description = "Enable swhkd hotkey daemon (automatically enabled for Wayland WMs)";
          };
          package = mkOption {
            type = types.package;
            default = swhkdPackages.${system};
            description = "The swhkd package to use";
          };
        };
        config = mkIf cfg.enable {
          environment.systemPackages = [ cfg.package ];
          security.wrappers.swhkd = {
            owner = "root";
            group = "root";
            setuid = true;
            source = "${cfg.package}/bin/swhkd";
          };
        };
      };
    modules.nixos.default = config.flake.modules.nixos.swhkd;
  };
}
