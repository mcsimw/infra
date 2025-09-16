{ moduleWithSystem, ... }:
{
  flake.modules.nixos.infra = moduleWithSystem (
    {
      pkgs,
      ...
    }:
    { config, lib, ... }:
    let
      cfg = config.analfabeta.desktop;
    in
    {
      options.analfabeta.desktop.minimal = lib.mkEnableOption "minimal";
      config = lib.mkIf (cfg.enable && cfg.minimal) {
        programs.foot.enable = true;
        environment.systemPackages = with pkgs; [
          imv
          mako
          zathura
          wmenu
          pwvucontrol_git
          mpv
        ];
      };
    }
  );
}
