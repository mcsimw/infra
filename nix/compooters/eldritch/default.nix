{ config, sources, ... }:
{
  configurations.nixos.eldritch = {
    reportPath = ./facter.json;
    usePkgsFromSystem = true;
    module =
      args@{ lib, pkgs, ... }:
      {
        services = {
          transmission.enable = true;
          scx = {
            enable = true;
            scheduler = "scx_lavd";
          };
          zfs = {
            autoScrub.enable = true;
            trim.enable = true;
            #rollback = {
            #  enable = true;
            #  snapshot = "blank";
            #  volume = "nyx/faketmpfs";
            #};
          };
          fstrim.enable = true;
          flatpak.enable = true;
          udev.extraRules = ''
            ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlan0", RUN+="${pkgs.iw}/bin/iw dev wlan0 set power_save off"
          '';
        };
        imports = [
          (sources.nix-flatpak + "/modules/nixos.nix")
        ];
        xdg.mime = {
          defaultApplications = {
            "application/pdf" = "org.pwmt.zathura.desktop";
            "image/png" = "imv.desktop";
            "image/jpeg" = "imv.desktop";
          };
          addedAssociations = {
            "application/pdf" = [ "org.pwmt.zathura.desktop" ];
          };
        };
        environment = {
          systemPackages = with pkgs; [
            wmenu
            rmpc
            mpd
            mpc
            emacs-igc-pgtk
            whitesur-cursors
            cemu
            ryubing
            pcsx2
            mangohud
            iw
            fooyin
            wireguard-tools
            claude-code
            havoc
          ];
          localBinInPath = true;
        };
        preservation.preserveAt."/persist" = {
          directories = [
            "/var/lib/bluetooth"
            "/var/lib/iwd"
            "/var/lib/flatpak"
            "/var/cache/flatpak"
            "/var/lib/transmission"
          ];
          users.mcsimw.directories = [
            ".com.wurmonline.client.launcherfx.WurmMain"
            ".local/share/Bay 12 Games"
            ".local/share/HotlineMiami"
            ".config/unity3d"
            ".config/UNDERTALE"
            ".config/mozilla"
            ".cache/mozilla"
            ".local/share/Cemu"
            ".cache/Cemu"
            ".config/Cemu"
            ".config/WiiUDownloader"
            ".cache/appimage-run"
            ".var"
            ".local/share/flatpak"
            ".config/Ryujinx"
            ".local/state/Heroic"
            ".config/heroic"
          ];
        };
        facter.reportPath = config.configurations.nixos.eldritch.reportPath;
        fileSystems = {
          "/" = {
            device = "none";
            fsType = "tmpfs";
            neededForBoot = true;
            options = [
              "size=3G"
              "mode=755"
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
        system = {
          stateVersion = "26.05";
          etc.overlay.enable = true;
          nixos-init.enable = true;
        };
        programs = {
          localsend.enable = true;
          niri = {
            enable = true;
            settings.outputs = {
              "DP-1" = {
                focus-at-startup = true;
                scale = 1;
                position = {
                  x = 0;
                  y = 0;
                };
                transform.rotation = 0;
                variable-refresh-rate = false;
              };
              "DP-2" = {
                scale = 1;
                position = {
                  x = 3840;
                  y = 0;
                };
                transform.rotation = 90;
              };
            };
          };
          steam = {
            enable = true;
            extraPackages = with pkgs; [
              openal
            ];
          };
        };
        security.pam.loginLimits = [
          {
            domain = "*";
            type = "soft";
            item = "nofile";
            value = "65536";
          }
          {
            domain = "*";
            type = "hard";
            item = "nofile";
            value = "1048576";
          }
        ];
        preservation = {
          enable = true;
          defaultPreservationPath = "/persist";
        };
        boot = {
          kernelParams = [
            "zfs.zfs_arc_max=12884901888"
            "iwlwifi.power_save=0"
          ];
          zfs.package = lib.mkForce args.config.boot.kernelPackages.zfs_cachyos;
          kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
          tmp.cleanOnBoot = true;
          initrd.systemd.enable = true;
          kernel.sysctl."vm.swapiness" = 10;
          loader = {
            systemd-boot = {
              enable = true;
              editor = false;
            };
            efi.canTouchEfiVariables = true;
          };
        };
        hjem.users = {
          mcsimw.enable = true;
        };
        users.users.mcsimw = {
          enable = true;
          linger = true;
          uid = 1000;
          packages = [ pkgs.heroic ];
        };
        networking = {
          wireless.iwd = {
            enable = true;
            settings = {
              Settings.PowerSave = false;
              General.RetryConnections = true;
              Scan.DisablePeriodicScan = true;
            };
          };
          useNetworkd = true;
        };
        hardware = {
          cpu.x86.msr.enable = true;
          amdgpu = {
            initrd.enable = true;
            opencl.enable = true;
          };
          bluetooth.settings.General.Experimental = true;
        };
        systemd.oomd = {
          enable = true;
          enableRootSlice = true;
          enableSystemSlice = true;
          enableUserSlices = true;
          settings.OOM.DefaultMemoryPressureDurationSec = "20s";
        };
      };
  };
}
