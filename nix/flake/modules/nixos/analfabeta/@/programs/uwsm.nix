{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { config, pkgs, ... }:
    {
      programs.uwsm = {
        inherit (config.programs.niri) enable;
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
}
