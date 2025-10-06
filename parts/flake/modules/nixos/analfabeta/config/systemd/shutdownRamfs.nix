{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { config, pkgs, ... }:
    let
      cfg = config.services.zfs.rollback;
      cfgZfs = config.boot.zfs;
    in
    {
      config = lib.mkIf cfg.enable {
        systemd.shutdownRamfs = {
          contents."/etc/systemd/system-shutdown/zpool".source = lib.mkForce (
            pkgs.writeShellScript "zpool-sync-shutdown" ''
              ${cfgZfs.package}/bin/zfs rollback -r "${cfg.volume}@${cfg.snapshot}"
              exec ${cfgZfs.package}/bin/zpool sync
            ''
          );
          storePaths = [ "${cfgZfs.package}/bin/zfs" ];
        };
      };
    };
}
