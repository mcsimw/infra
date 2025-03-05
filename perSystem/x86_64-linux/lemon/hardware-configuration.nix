{
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "ehci_pci"
    "ahci"
    "nvme"
    "sr_mod"
  ];
  virtualisation.vmware.guest.enable = true;
}
