{ lib, pkgs, ... }:
{
  virtualisation.vmware.guest.enable = true;
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "nvme"
    "sr_mod"
  ];
  chaotic.mesa-git = {
    enable = true;
    fallbackSpecialisation = false;
  };
  hardware = {
    #    bluetooth.enable = true;
    #    xpadneo.enable = true;
    #    cpu.intel.updateMicrocode = true;
    #    amdgpu = {
    #      initrd.enable = true;
    #      opencl.enable = true;
    #    };
    enableAllFirmware = true;
  };
  powerManagement.cpuFreqGovernor = "performance";
  boot = {
    #    kernelModules = [ "kvm_intel" ];
    initrd = {
      systemd.enable = true;
      #      availableKernelModules = [
      #        "xhci_pci"
      #        "ahci"
      #        "nvme"
      #        "usbhid"
      #        "usb_storage"
      #        "sd_mod"
      #      ];
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
