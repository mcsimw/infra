{ inputs, ... }:
{
  imports = [
    inputs.disk-abstractions.nixosModules.zfsonix
  ];
  zfsonix = {
    enable = true;
    diskName = "lemon";
    device = "/dev/nvme0n1";
    ashift = "12";
    swapSize = "8G";
  };
  services = {
    fstrim.enable = true;
    zfs = {
      trim.enable = true;
      autoScrub.enable = true;
    };
  };
}
