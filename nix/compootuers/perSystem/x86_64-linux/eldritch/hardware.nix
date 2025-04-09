{ lib, pkgs, ... }:
{

  hardware = {
    graphics = with lib; {
      package = mkForce pkgs.mesa_git;
      package32 = mkForce pkgs.mesa32_git;
      extraPackages = with pkgs; [
        mesa_git.opencl
        mesa_git
        vulkanPackages_latest.vulkan-loader
        vulkanPackages_latest.vulkan-validation-layers
        libva
        libvdpau-va-gl
      ];
    };
    bluetooth.enable = true;
    xpadneo.enable = true;
    cpu.intel.updateMicrocode = true;
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };

    enableAllFirmware = true;
  };

  powerManagement.cpuFreqGovernor = "performance";

  boot = {
    kernel.sysctl."vm.swapiness" = 10;
    kernelModules = [ "kvm_intel" ];
    kernelParams = [
      "zfs.zfs_arc_max=12884901888"
      "mitigations=off"
      "nopti"
      "tsx=on"

      # Laptops and dekstops don't need Watchdog
      "nowatchdog"

      # https://www.phoronix.com/news/Linux-Splitlock-Hurts-Gaming
      "split_lock_detect=off"
    ];
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
