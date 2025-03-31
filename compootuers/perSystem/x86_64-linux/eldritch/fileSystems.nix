{
  preservation.enable = false;

   fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=3G" "mode=755" ]; # mode=755 so only root can write to those files
    };
  fileSystems."/nix" = {
    device = "lemon/nix";
    fsType = "zfs";
    options = [ "zfsutil" "X-mount.mkdir" ];
  };

  fileSystems."/tmp" = {
    device = "lemon/tmp";
    fsType = "zfs";
    options = [ "zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/persist" = {
    device = "lemon/persist";
    fsType = "zfs";
    options = [ "zfsutil" "X-mount.mkdir"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-id/nvme-eui.fa50f69e53302a28000c296454310ffe-part1";
    fsType = "vfat";
  };

#  swapDevices = [
#    {
#      device = "nvme-eui.fa50f69e53302a28000c296454310ffe-part2";
#      randomEncryption = true;
#    }
#  ];
}
