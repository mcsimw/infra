{ lib, ... }:
{
  hardware = {
    bluetooth.enable = true;
    xpadneo.enable = true;
    cpu.intel.updateMicrocode = true;
    amdgpu = {
      initrd.enable = true;
    };
    enableAllFirmware = true;
  };

  powerManagement.cpuFreqGovernor = "performance";

  boot = {
    kernel.sysctl."vm.swapiness" = 10;
    kernelModules = [ "kvm_intel" ];
    kernelParams = [ "zfs.zfs_arc_max=12884901888" ];
    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
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
