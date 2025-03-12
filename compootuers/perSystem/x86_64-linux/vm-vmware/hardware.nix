{ lib, inputs', ... }:
{
  virtualisation.vmware.guest.enable = true;
  boot = {
    kernelPackages = lib.mkOverride 99 inputs'.nyx.legacyPackages.linuxPackages_cachyos-rc;
    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "ehci_pci"
        "ahci"
        "nvme"
        "sr_mod"
      ];
    };
  };
  services.scx = {
    enable = true;
    scheduler = "scx_bpfland";
  };
}
