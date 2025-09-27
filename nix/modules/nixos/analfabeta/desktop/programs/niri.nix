{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs', ... }:
    { config, lib, ... }:
    let
      cfg = config.analfabeta.desktop;
    in
    {
      config = lib.mkIf cfg.enable {
        programs.niri = {
          enable = true;
          package = inputs'.niri.packages.default;
        };

        hjem.users = lib.mapAttrs (_username: dotfilePath: {
          files.".config/niri/config.kdl".source = dotfilePath;
        }) cfg.users;
      };
    }
  );
}
