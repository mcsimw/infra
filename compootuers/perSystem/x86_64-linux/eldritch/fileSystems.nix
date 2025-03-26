{
  preservation.enable = false;
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "size=3G"
      "mode=755"
    ];
  };
  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/7d0f99e1-c064-47a2-95ae-098d179ccc50";
    fsType = "xfs";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B1BE-ED34";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    { 
      device = "/dev/disk/by-path/pci-0000:03:00.0-nvme-1-part2"; 
      randomEncryption.enable = true;
    }
  ];
}
