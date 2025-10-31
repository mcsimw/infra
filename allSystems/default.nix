{
  inputs,
  lib,
  config,
  options,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixpkgs.nixosModules.readOnlyPkgs
  ];
  # Stolen from https://github.com/chaotic-cx/nyx/blob/main/modules/nixos/zfs-impermanence-on-shutdown.nix
  options.services.zfs.rollback = {
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
  config =
    let
      existingUsers = builtins.attrNames config.users.users;
      normalUsers = lib.filter (user: config.users.users.${user}.isNormalUser or false) existingUsers;
      hasPreservation = options ? preservation;
    in
    lib.mkMerge [
      (
        let
          cfg = config.services.zfs.rollback;
          cfgZfs = config.boot.zfs;
        in
        lib.mkIf cfg.enable {
          systemd.shutdownRamfs = {
            contents."/etc/systemd/system-shutdown/zpool".source = lib.mkForce (
              pkgs.writeShellScript "zpool-sync-shutdown" ''
                ${cfgZfs.package}/bin/zfs rollback -r "${cfg.volume}@${cfg.snapshot}"
                exec ${cfgZfs.package}/bin/zpool sync
              ''
            );
            storePaths = [ "${cfgZfs.package}/bin/zfs" ];
          };
        }
      )
      (lib.optionalAttrs hasPreservation {
        preservation.preserveAt."/persist" = {
          directories = [
            "/var/log"
            "/var/lib/systemd/coredump"
          ];
          files = [
            {
              file = "/var/lib/systemd/random-seed";
              how = "symlink";
              inInitrd = true;
              configureParent = true;
            }
            {
              file = "/etc/ssh/ssh_host_ed25519_key";
              how = "symlink";
              configureParent = true;
            }
            {
              file = "/etc/ssh/ssh_host_ed25519_key.pub";
              how = "symlink";
              configureParent = true;
            }
          ];
          users = lib.genAttrs normalUsers (_user: {
            directories = [
              {
                directory = ".ssh";
                mode = "0700";
              }
            ];
          });
        };
      })
    ];
}
