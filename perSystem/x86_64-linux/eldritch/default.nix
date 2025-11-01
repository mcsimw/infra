{
  config,
  inputs,
  pkgs,
  ...
}:
let
  niri = config.programs.niri.enable;
in
{
  imports = [
    ./shared.nix
    inputs.preservation.nixosModules.default
  ];

  programs = {
    openmw.enable = true;
    steam = {
      enable = niri;
      extraCompatPackages = [ pkgs.proton-cachyos ];
    };
  };

  environment.systemPackages = with pkgs; [
    mangohud
    openmw
    gimp
    kdePackages.kdenlive
    (emacs-igc-pgtk.override { withTreeSitter = true; })
    krita
    efibootmgr
  ];

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  preservation = {
    enable = true;
    preserveAt."/persist".commonMountOptions = [
      "x-gvfs-hide"
      "x-gdu.hide"
    ];
  };

  fileSystems = {
    "/" = {
      device = "nyx/faketmpfs";
      fsType = "zfs";
      neededForBoot = true;
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/nix" = {
      device = "nyx/nix";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/mnt/nyx" = {
      device = "nyx/self";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/tmp" = {
      device = "nyx/tmp";
      fsType = "zfs";
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/persist" = {
      device = "nyx/persist";
      fsType = "zfs";
      neededForBoot = true;
      options = [
        "zfsutil"
        "X-mount.mkdir"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-partuuid/1842a05b-a2fa-4e8e-aa1c-a21d684f7087";
      fsType = "vfat";
      options = [
        "dmask=0022"
        "fmask=0022"
        "umask=0077"
      ];
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-partuuid/69b2fba8-5e1a-444c-b065-f15cf7382bee";
      randomEncryption = {
        enable = true;
        allowDiscards = true;
      };
      discardPolicy = "both";
    }
  ];

  services = {
    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
      rollback = {
        enable = true;
        snapshot = "blank";
        volume = "nyx/faketmpfs";
      };
    };
    fstrim.enable = true;
  };
}
