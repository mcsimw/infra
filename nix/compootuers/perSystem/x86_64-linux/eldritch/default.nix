{ self, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];

    systemd.services.stow-dotfiles = {
    description = "Stow dotfiles for mcsimw from /mnt/lemon/stow";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "mcsimw";

      RequiresMountsFor = "/mnt/lemon /home/mcsimw";

      ExecStart = pkgs.writeShellScript "stow-dotfiles" ''
        set -e
        STOW_DIR="/mnt/nyx/.dotfiles/mcsimw"
        TARGET_DIR="/home/mcsimw"

        if [ ! -d "$STOW_DIR" ]; then
          echo "⚠️  $STOW_DIR does not exist. Skipping stow."
          exit 0
        fi

        echo "🔧 Running stow from $STOW_DIR to $TARGET_DIR"
        cd "$STOW_DIR"
        ${pkgs.stow}/bin/stow -t "$TARGET_DIR" -R *
      '';
    };
  };
}
