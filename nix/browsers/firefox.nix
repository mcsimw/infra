{
  config,
  lib,
  desktops,
  ...
}:
let
  anyDesktop = cfg: lib.any (name: desktops.byName.${name}.check cfg) (lib.attrNames desktops.byName);
  inherit (config) sources;
  supportedSystems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
  callFlakeWithInputs =
    flakeSrc: overrideInputs:
    let
      flake = import (flakeSrc + "/flake.nix");
      outputs = flake.outputs (overrideInputs // { self = outputs; });
    in
    outputs;
  flakeUtilsOutputs = callFlakeWithInputs sources.flake-utils {
    systems = sources.default-linux;
  };
  libAggregateOutputs = callFlakeWithInputs sources.lib-aggregate {
    nixpkgs-lib = { inherit lib; };
    flake-utils = flakeUtilsOutputs;
  };
  firefoxOutputs = callFlakeWithInputs sources.flake-firefox-nightly {
    inherit (sources) nixpkgs;
    lib-aggregate = libAggregateOutputs;
    flake-compat = null;
  };
in
{
  flake = {
    packages = lib.genAttrs supportedSystems (system: {
      firefox-nightly = firefoxOutputs.packages.${system}.firefox-nightly-bin;
    });
    modules.nixos = {
      default =
        { lib, pkgs, ... }:
        let
          inherit (lib) mkIf mkDefault;
          system = pkgs.stdenv.hostPlatform.system;
          isSupported = builtins.elem system supportedSystems;
        in
        {
          imports = [ config.flake.modules.nixos.firefox ];
          programs.firefox.package = mkIf isSupported (
            mkDefault config.flake.packages.${system}.firefox-nightly
          );
        };
      firefox =
        { lib, config, ... }:
        {
          programs.firefox.enable = lib.mkDefault (anyDesktop config);
        };
    };
  };
}
