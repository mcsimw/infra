args@{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib)
    mkMerge
    mapAttrsToList
    fileset
    mkEnableOption
    mkIf
    ;
  inherit (builtins) mapAttrs;
  treefmt-nix = import "${inputs.treefmt-nix}";
  root = ../.;
  projectSrc = fileset.toSource {
    inherit root;
    fileset = fileset.unions [
      (fileset.fileFilter (file: file.hasExt "nix") root)
      ../flake.nix
    ];
  };
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
      statix = inputs.statix.packages.${system}.default;
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
