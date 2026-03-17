{ config, lib, ... }:
let
  inherit (lib)
    genAttrs
    mkOption
    types
    mkDefault
    ;
  inherit (builtins) isFunction filter elem;
  inherit (config) sources;
  overlayType = types.submodule {
    options = {
      overlay = mkOption {
        type = types.unspecified;
        description = "The overlay function (final: prev: { ... })";
      };
      systems = mkOption {
        type = types.nullOr (types.listOf types.str);
        default = null;
        description = ''
          Systems to apply this overlay to (e.g., [ "x86_64-linux" "aarch64-linux" ]).
          null means all systems.
        '';
      };
    };
  };
  normalizeOverlay =
    overlay:
    if isFunction overlay then
      {
        inherit overlay;
        systems = null;
      }
    else
      overlay;
  appliesTo = system: cfg: cfg.systems == null || elem system cfg.systems;
  overlaysFor =
    system: overlays:
    overlays |> map normalizeOverlay |> filter (appliesTo system) |> map (cfg: cfg.overlay);
in
{
  options.nixpkgs = {
    systems = mkOption {
      type = types.listOf types.str;
      default = import sources.default;
      description = "Systems to generate pkgs instances for";
      example = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
    config = mkOption {
      type = types.attrs;
      default.allowUnfree = mkDefault true;
      description = "Nixpkgs config to apply to all pkgs instances";
      example = {
        allowUnfree = true;
        allowBroken = false;
      };
    };
    overlays = mkOption {
      type = types.listOf (types.either types.unspecified overlayType);
      description = ''
        Overlays to apply to pkgs instances.

        Can be either:
        - A plain overlay function (applies to all systems)
        - An attrset with { overlay, systems } to filter by system
      '';
      default = [ ];
      example = lib.literalExpression ''
        [
          # Applies to all systems
          (final: prev: { myPackage = ...; })
          
          # Only x86_64 systems
          {
            overlay = (final: prev: { cachyKernel = ...; });
            systems = [ "x86_64-linux" "x86_64-darwin" ];
          }
        ]
      '';
    };
    pkgs = mkOption {
      type = types.lazyAttrsOf types.attrs;
      description = "Nixpkgs instances per system (generated automatically)";
      default = { };
    };
  };
  config.nixpkgs.pkgs = genAttrs config.nixpkgs.systems (
    system:
    import sources.nixpkgs {
      inherit system;
      config = config.nixpkgs.config;
      overlays = overlaysFor system config.nixpkgs.overlays;
    }
  );
}
