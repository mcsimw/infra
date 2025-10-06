{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs' }:
    {
      options.programs.prismlauncher = {
        enable = lib.mkEnableOption "Install Prism Launcher";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for PrismLauncher, can be overridden.";
          inherit (inputs'.prismlauncher.packages) default;
        };
      };
    }
  );
}
