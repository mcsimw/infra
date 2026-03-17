args@{ config, wrappers, ... }:
{
  flake = {
    packages = builtins.mapAttrs (_: pkgs: {
      unnethack = wrappers.wrapPackage {
        inherit pkgs;
        package = pkgs.unnethack;
        env.TERM = "xterm";
      };
    }) config.nixpkgs.pkgs;
    modules.nixos = {
      default = config.flake.modules.nixos.unnethack;
      unnethack =
        {
          pkgs,
          lib,
          config,
          ...
        }:
        {
          options.programs.unnethack = {
            enable = lib.mkEnableOption "unnethack" // {
              default = true;
            };
            package = lib.mkOption {
              type = lib.types.package;
              default = args.config.flake.packages.${pkgs.stdenv.hostPlatform.system}.unnethack;
            };
          };
          config = lib.mkIf config.programs.unnethack.enable {
            environment.systemPackages = [
              config.programs.unnethack.package
            ];
          };
        };
    };
  };
}
