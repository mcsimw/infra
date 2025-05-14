{
  lib,
  pkgs,
  inputs,
  ...
}:
{

  hardware = {
    graphics = {
      package = lib.mkForce pkgs.mesa_git;
      package32 = lib.mkForce pkgs.mesa32_git;
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

  environment.variables.ALSA_CONFIG_UCM2 = "${
    pkgs.alsa-ucm-conf.overrideAttrs (_old: {
      src = inputs.alsa-ucm-conf;
    })
  }/share/alsa/ucm2";

  boot = {
    kernel.sysctl = {
      "vm.swapiness" = 10;
      "net.ipv6.conf.enp7s0.disable_ipv6" = true;
    };
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
    package = pkgs.scx_git.full;
  };

  systemd.targets = lib.genAttrs [ "sleep" "suspend" "hibernate" "hybrid-sleep" ] (_: {
    enable = lib.mkForce false;
  });
}
