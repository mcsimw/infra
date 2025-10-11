{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { pkgs }:
    {
      options.programs.helium = {
        enable = lib.mkEnableOption "Install Helium Browswer";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Helium can be overridden.";
          default = pkgs.nur.repos.Ev357.helium;
        };
      };
    }
  );
}
