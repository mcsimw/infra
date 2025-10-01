{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { config, pkgs, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        programs.uwsm = {
          enable = true;
          waylandCompositors.niri = {
            prettyName = "Niri";
            comment = "Niri compositor managed by UWSM";
            # https://github.com/YaLTeR/niri/issues/254
            binPath = pkgs.writeShellScript "niri" ''
              ${lib.getExe config.programs.niri.package} --session
            '';
          };
        };

      };
    };
}
