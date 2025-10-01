{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { pkgs }:
    { config, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        environment.systemPackages = [ pkgs.nur.repos.Ev357.helium ];
      };
    }
  );
}
