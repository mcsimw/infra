{ lib, config, ... }:
let
  inherit (lib)
    mkDefault
    mkMerge
    mkOption
    optional
    types
    mapAttrsToList
    ;
  inherit (builtins)
    pathExists
    mapAttrs
    ;
  nixosLib = import "${config.sources.nixpkgs}/nixos/lib" {
    featureFlags.minimalModules = { };
  };
  baseModules = import "${config.sources.nixpkgs}/nixos/modules/module-list.nix" ++ [
    "${config.sources.nixos-facter-modules}/modules/nixos/facter.nix"
  ];
  validateConfig =
    name: cfg:
    if cfg.system != null && cfg.reportPath != null then
      throw "Configuration '${name}': Cannot set both 'system' and 'reportPath'. Choose one."
    else
      cfg;
in
{
  options.configurations.nixos = mkOption {
    type = types.lazyAttrsOf (
      types.submodule {
        options = {
          module = mkOption { type = types.deferredModule; };
          system = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "System architecture (e.g., x86_64-linux). Mutually exclusive with reportPath.";
          };
          reportPath = mkOption {
            type = types.nullOr types.path;
            default = null;
            description = "Path to facter.json file. Mutually exclusive with system.";
          };
          usePkgsFromSystem = mkOption {
            type = types.bool;
            default = false;
            description = "Whether to set nixpkgs.pkgs from global nixpkgs instance. Requires system or reportPath.";
          };
        };
      }
    );
    default = { };
  };
  config.flake = {
    nixosConfigurations = mapAttrs (
      name: cfg:
      let
        validated = validateConfig name cfg;
        inherit (validated)
          module
          system
          reportPath
          usePkgsFromSystem
          ;
        hasExplicitSystem = system != null;
        hasReportPath = reportPath != null;
        facterData =
          if hasReportPath then
            if !pathExists reportPath then
              throw "Configuration '${name}': reportPath points to non-existent file: ${toString reportPath}"
            else
              lib.importJSON reportPath
          else
            null;
        actualSystem =
          if hasExplicitSystem then
            system
          else if hasReportPath then
            facterData.system
              or (throw "Configuration '${name}': facter.json at ${toString reportPath} is missing 'system' field")
          else if usePkgsFromSystem then
            throw "Configuration '${name}': usePkgsFromSystem is true but neither system nor reportPath was provided"
          else
            null;
      in
      nixosLib.evalModules {
        modules =
          baseModules
          ++ [
            {
              _module.args = {
                inherit baseModules;
                inherit (config) sources;
                modules = [
                  module
                  (config.flake.modules.nixos.default or { })
                ];
              };
            }
            module
            (config.flake.modules.nixos.default or { })
            { networking.hostName = mkDefault name; }
          ]
          ++ optional (usePkgsFromSystem && actualSystem != null) {
            nixpkgs.pkgs = config.nixpkgs.pkgs.${actualSystem};
          }
          ++ optional (!usePkgsFromSystem && actualSystem != null) {
            nixpkgs.hostPlatform = mkDefault actualSystem;
          };
      }
    ) config.configurations.nixos;
    checks =
      config.flake.nixosConfigurations
      |> mapAttrsToList (
        name: nixos: {
          ${
            if nixos.options.nixpkgs.hostPlatform.isDefined or false then
              nixos.config.nixpkgs.hostPlatform.system
            else
              nixos.config.nixpkgs.pkgs.stdenv.system
          }."configurations/nixos/${name}" =
            nixos.config.system.build.toplevel;
        }
      )
      |> mkMerge;
  };
}
