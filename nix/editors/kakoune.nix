args@{ config, inputs, ... }:
{
  flake = {
    modules.nixos = {
      default =
        { lib, ... }:
        {
          imports = [ config.flake.modules.nixos.kakoune ];
          programs.kakoune.enable = lib.mkDefault true;
        };
      kakoune =
        {
          lib,
          pkgs,
          config,
          ...
        }:
        {
          options.programs.kakoune = {
            enable = lib.mkEnableOption "enable kakoune editor";
            package = lib.mkOption {
              type = lib.types.package;
              default = args.config.flake.packages.${pkgs.stdenv.hostPlatform.system}.kakoune;
              description = "The kakoune package to use";
            };
          };
          config = lib.mkIf config.programs.kakoune.enable {
            environment.systemPackages = [
              config.programs.kakoune.package
            ];
          };
        };
    };
    packages = builtins.mapAttrs (_: pkgs: {
      kakoune = pkgs.kakoune-unwrapped.overrideAttrs {
        src = inputs.kakoune;
        version = inputs.kakoune.rev or "unknown";
        postPatch = ''
          echo "${inputs.kakoune.rev or "unknown"}" > .version
        '';
      };
    }) config.nixpkgs.pkgs;
  };
}
