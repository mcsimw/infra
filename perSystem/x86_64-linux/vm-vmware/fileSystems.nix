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
}
