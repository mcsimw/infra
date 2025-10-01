{
  lib,
  pkgs,
  ...
}:
{

  hardware = {
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

  networking.wireless.iwd.enable = true;

  environment.variables.RUSTICL_ENABLE = "radeonsi";

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

  services = {
    scx = {
      enable = true;
      scheduler = "scx_lavd";
      package = pkgs.scx_git.full;
    };
    pipewire = {
      enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  systemd.targets = lib.genAttrs [ "sleep" "suspend" "hibernate" "hybrid-sleep" ] (_: {
    enable = lib.mkForce false;
  });
}
