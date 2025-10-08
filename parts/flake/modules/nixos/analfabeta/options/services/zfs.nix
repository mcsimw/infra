# Stolen from https://github.com/chaotic-cx/nyx/blob/main/modules/nixos/zfs-impermanence-on-shutdown.nix
{ lib, ... }:
{
  flake.modules.nixos.analfabeta.options.services.zfs.rollback = {
    enable = lib.mkEnableOption "Impermanence on safe-shutdown through ZFS snapshots";
    volume = lib.mkOption {
      type = lib.types.str;
      default = null;
      example = "zroot/ROOT/empty";
      description = ''
        Full description to the volume including pool.
        This volume must have a snapshot to an "empty" state.
        WARNING: The volume will be rolled back to the snapshot on every safe-shutdown.
      '';
    };
    snapshot = lib.mkOption {
      type = lib.types.str;
      default = null;
      example = "start";
      description = ''
        Snapshot of the volume in an "empty" state to roll back to.
      '';
    };
  };
}
