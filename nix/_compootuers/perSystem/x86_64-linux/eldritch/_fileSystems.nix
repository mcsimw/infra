{
  boot = {
    kernelParams = [ "nohibernate" ];
    tmp.cleanOnBoot = true;
  };

  preservation = {
    enable = true;
    preserveAt."/persist".commonMountOptions = [
      "x-gvfs-hide"
      "x-gdu.hide"
    ];
  };

  analfabeta.services.zfs-rollback = {
    enable = true;
    snapshot = "blank";
    volume = "nyx/faketmpfs";
  };

  fileSystems = {
    "/" = {
      device = "nyx/faketmpfs";
      fsType = "zfs";
      neededForBoot = true;
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/nix" = {
      device = "nyx/nix";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/mnt/nyx" = {
      device = "nyx/self";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/tmp" = {
      device = "nyx/tmp";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/persist" = {
      device = "nyx/persist";
      fsType = "zfs";
      neededForBoot = true;
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-partuuid/1842a05b-a2fa-4e8e-aa1c-a21d684f7087";
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
      device = "/dev/disk/by-partuuid/69b2fba8-5e1a-444c-b065-f15cf7382bee";
      randomEncryption = {
        enable = true;
        allowDiscards = true;
      };
      discardPolicy = "both";
    }
  ];

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
}
