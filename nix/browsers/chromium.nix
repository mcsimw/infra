{
  config,
  lib,
  desktops,
  ...
}:
let
  inherit (config) sources;
  callFlakeWithInputs =
    flakeSrc: overrideInputs:
    let
      flake = import (flakeSrc + "/flake.nix");
      outputs = flake.outputs (overrideInputs // { self = outputs; });
    in
    outputs;
  parseFlakeInput =
    flakeSrc: inputName:
    let
      lock = builtins.fromJSON (builtins.readFile (flakeSrc + "/flake.lock"));
      namedNode = lock.nodes.${lock.nodes.root.inputs.${inputName}}.locked;
    in
    fetchTarball {
      url = "https://github.com/${namedNode.owner}/${namedNode.repo}/archive/${namedNode.rev}.tar.gz";
      sha256 = namedNode.narHash;
    };
  browserPreviewsSystems = parseFlakeInput sources.browser-previews "systems";
  supportedSystems = import browserPreviewsSystems;
  browserPreviewsFlakeUtils = parseFlakeInput sources.browser-previews "flake-utils";
  flakeUtilsSystems = parseFlakeInput browserPreviewsFlakeUtils "systems";
  flake-utils = callFlakeWithInputs browserPreviewsFlakeUtils {
    systems = flakeUtilsSystems;
  };
  browserPreviewsOutputs = callFlakeWithInputs sources.browser-previews {
    inherit (sources) nixpkgs;
    inherit flake-utils;
  };
in
{
  flake = {
    packages = lib.genAttrs supportedSystems (system: {
      google-chrome-dev =
        browserPreviewsOutputs.packages.${system}.google-chrome-dev.overrideAttrs
          (oldAttrs: {
            postInstall = (oldAttrs.postInstall or "") + ''
              rm -f $out/share/applications/com.google.Chrome.unstable.desktop
            '';
          });
    });
    modules.nixos = {
      default =
        { pkgs, lib, ... }:
        let
          inherit (lib) mkDefault;
          system = pkgs.stdenv.hostPlatform.system;
          isSupported = builtins.elem system supportedSystems;
        in
        {
          imports = [ config.flake.modules.nixos.chromium ];
          programs.chromium.extraPackages = mkDefault (
            if isSupported then [ config.flake.packages.${system}.google-chrome-dev ] else [ pkgs.chromium ]
          );
        };
      chromium =
        {
          lib,
          config,
          pkgs,
          ...
        }:
        let
          inherit (lib)
            mkDefault
            mkIf
            mkMerge
            ;
          cfg = config.programs.chromium;
          anyDesktop = builtins.any (name: desktops.byName.${name}.check config) (
            lib.attrNames desktops.byName
          );
        in
        {
          options.programs.chromium.extraPackages = lib.mkOption {
            type = lib.types.listOf lib.types.package;
            default = [ pkgs.chromium ];
            description = "Browser packages to install";
            example = lib.literalExpression "[ pkgs.firefox pkgs.brave ]";
          };

          config = mkMerge [
            { programs.chromium.enable = mkDefault anyDesktop; }
            (mkIf cfg.enable {
              environment.systemPackages = cfg.extraPackages;
            })
          ];
        };
    };
  };
}
