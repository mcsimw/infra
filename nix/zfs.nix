{ config, lib, ... }:
{
  flake.modules.nixos = {
    default = {
      imports = with config.flake.modules.nixos; [
        zfs
        zfs-rollback
      ];
    };
    zfs.boot.zfs.forceImportRoot = lib.mkForce false;
    /*
      zfs-rollback implementation copied from Pedro Lara Campos https://github.com/PedroHLC
      https://github.com/chaotic-cx/nyx/blob/aacb796ccd42be1555196c20013b9b674b71df75/modules/nixos/zfs-impermanence-on-shutdown.nix#L3
    */
    zfs-rollback =
      {
        lib,
        config,
        pkgs,
        ...
      }:
      let
        cfg = config.services.zfs.rollback;
        cfgZfs = config.boot.zfs;
        inherit (lib)
          mkOption
          mkEnableOption
          mkIf
          types
          ;
      in
      {
        options = {
          services.zfs.rollback = {
            enable = mkEnableOption "Impermanence on safe-shutdown through ZFS snapshots";
            volume = mkOption {
              type = types.str;
              default = null;
              example = "zroot/ROOT/empty";
              description = ''
                Full description to the volume including pool.
                This volume must have a snapshot to an "empty" state.
                WARNING: The volume will be rolled back to the snapshot on every safe-shutdown.
              '';
            };
            snapshot = mkOption {
              type = types.str;
              default = null;
              example = "start";
              description = ''
                Snapshot of the volume in an "empty" state to roll back to.
              '';
            };
          };
        };
        config = mkIf cfg.enable {
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
  };
}
