{ moduleWithSystem, ... }:
{
  flake.modules.nixos.infra = moduleWithSystem (
    { pkgs, inputs', ... }:
    {
      config,
      lib,
      ...
    }:
    let
      cfg = config.analfabeta.programs.niri;
    in
    {
      options.analfabeta.programs.niri.enable = lib.mkEnableOption "niri";

      config = lib.mkIf cfg.enable {
        programs = {
          niri.enable = true;
          uwsm.waylandCompositors.niri = {
            prettyName = "Niri";
            comment = "Niri compositor managed by UWSM";
            # https://github.com/YaLTeR/niri/issues/254
            binPath = pkgs.writeShellScript "niri" ''
              ${lib.getExe config.programs.niri.package} --session
            '';
          };
        };
        environment.systemPackages = [ inputs'.xwayland-satellite.packages.default ];
      };
    }
  );
}
