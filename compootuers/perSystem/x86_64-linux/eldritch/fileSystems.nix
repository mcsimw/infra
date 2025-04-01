{ self, ... }:
{
  imports = [
    self.nixosModules.zfs-rollback
  ];

  boot = {
    kernelParams = [ "nohibernate" ];
    tmp.cleanOnBoot = true;
  };

  zfs-rollback = {
    enable = true;
    snapshot = "blank";
    volume = "lemon/faketmpfs";
  };

  preservation.enable = false;

  fileSystems = {
    "/" = {
      device = "lemon/faketmpfs";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/nix" = {
      device = "lemon/nix";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/mnt/lemon" = {
      device = "lemon/self";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/tmp" = {
      device = "lemon/tmp";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/persist" = {
      device = "lemon/persist";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-id/nvme-eui.a4142fc7459aa04f000c29699a5f1235-part1";
      fsType = "vfat";
      options = [
        "dmask=0022"
        "fmask=0022"
        "umask=0077"
      ];
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-id/nvme-eui.a4142fc7459aa04f000c29699a5f1235-part2";
      randomEncryption = {
        enable = true;
        allowDiscards = true;
      };
      discardPolicy = "both";
    }
  ];
}
