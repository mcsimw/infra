{ lib, pkgs, ... }:
{
  chaotic.mesa-git = {
    enable = true;
    fallbackSpecialisation = false;
  };
  hardware = {
    cpu.intel.updateMicrocode = true;
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
    enableAllFirmware = true;
  };
  powerManagement.cpuFreqGovernor = "performance";
  boot = {
    kernelPackages = lib.mkOverride 99 pkgs.linuxPackages_cachyos-rc;
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
  systemd.targets = {
    sleep.enable = lib.mkForce false;
    suspend.enable = lib.mkForce false;
    hibernate.enable = lib.mkForce false;
    hybrid-sleep.enable = lib.mkForce false;
  };
}
