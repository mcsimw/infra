{
  lib,
  pkgs,
  config,
  ...
}:
{

  hardware = {
    graphics = with lib; {
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs; [ nvidia-vaapi-driver ];
    };
    bluetooth.enable = true;
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  powerManagement.cpuFreqGovernor = "performance";

  boot = {
    kernel.sysctl = {
      "vm.swapiness" = 10;
    };
    kernelModules = [ "kvm_intel" ];
    kernelParams = [
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
        "usb_storage"
        "sd_mod"
      ];
    };
  };

  services.scx = {
    enable = true;
    scheduler = "scx_bpfland";
  };

}
