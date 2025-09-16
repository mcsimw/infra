{ moduleWithSystem, ... }:
{
  flake.modules.nixos.infra = moduleWithSystem (
    {
      pkgs,
      ...
    }:
    { lib, config, ... }:
    let
      cfg = config.analfabeta.desktop;
    in
    {
      options.analfabeta.desktop.wlroots = lib.mkEnableOption "wlroots stuff";
      config = lib.mkIf (cfg.enable && cfg.wlroots) {
        environment.systemPackages = with pkgs; [
          sway-contrib.grimshot
          slurp
          swaybg
        ];
      };
    }
  );
}
