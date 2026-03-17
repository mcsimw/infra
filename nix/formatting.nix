args@{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkMerge
    mapAttrsToList
    fileset
    mkEnableOption
    mkIf
    genAttrs
    ;
  inherit (builtins) mapAttrs;
  inherit (config) sources;
  treefmt-nix = import sources.treefmt-nix;
  root = ../.;
  projectSrc = fileset.toSource {
    inherit root;
    fileset = fileset.unions [
      (fileset.fileFilter (file: file.hasExt "nix") root)
      ../flake.nix
    ];
  };
  callFlakeWithInputs =
    flakeSrc: overrideInputs: revision:
    let
      flake = import (flakeSrc + "/flake.nix");
      outputs = flake.outputs (
        overrideInputs
        // {
          self = outputs // {
            outPath = flakeSrc;
            __toString = _: flakeSrc;
            inputs = overrideInputs;
            rev = revision;
            shortRev = builtins.substring 0 7 revision;
            lastModified = 0;
            lastModifiedDate = "19700101";
          };
        }
      );
    in
    outputs;
  mkNixpkgsInput = systems: {
    _type = "flake";
    inherit lib;
    legacyPackages = genAttrs systems (system: config.nixpkgs.pkgs.${system});
    outPath = sources.nixpkgs;
    __toString = _: sources.nixpkgs;
  };
  mkStatixPackage =
    system:
    let
      nixpkgsInput = mkNixpkgsInput config.nixpkgs.systems;
      flakePartsOutputs = callFlakeWithInputs sources.flake-parts {
        nixpkgs-lib = { inherit lib; };
      } sources.flake-parts.revision;
      statixOutputs = callFlakeWithInputs sources.statix {
        nixpkgs = nixpkgsInput;
        flake-parts = flakePartsOutputs;
        systems = sources.default; # This is the nix-systems/default repo
      } sources.statix.revision;
    in
    statixOutputs.packages.${system}.default;
  treefmt = mapAttrs (
    _: pkgs:
    (treefmt-nix.evalModule pkgs {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        deadnix.enable = true;
        statix.enable = true;
        stylua.enable = true;
      };
    }).config
  ) config.nixpkgs.pkgs;
in
{
  flake = {
    packages = mapAttrs (system: _: {
      statix = mkStatixPackage system;
    }) config.nixpkgs.pkgs;
    modules.nixos = {
      default =
        { lib, ... }:
        {
          imports = [ config.flake.modules.nixos.formatters ];
          programs.formatters.enable = lib.mkDefault true;
        };
      formatters =
        { config, pkgs, ... }:
        {
          options.programs.formatters.enable = mkEnableOption "Install all Formatters";
          config = mkIf config.programs.formatters.enable {
            environment.systemPackages = with pkgs; [
              nixfmt
              deadnix
              args.config.flake.packages.${pkgs.stdenv.hostPlatform.system}.statix
              stylua
            ];
          };
        };
    };
    formatter = mapAttrs (_: cfg: cfg.build.wrapper) treefmt;
    checks =
      treefmt
      |> mapAttrsToList (
        system: cfg: {
          ${system}.treefmt = cfg.build.check projectSrc;
        }
      )
      |> mkMerge;
  };
  nixpkgs.overlays = [
    (final: _: {
      statix = config.flake.packages.${final.stdenv.hostPlatform.system}.statix;
    })
  ];
}
