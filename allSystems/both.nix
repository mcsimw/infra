{
  lib,
  inputs,
  pkgs,
  config,
  inputs',
  options,
  self',
  ...
}:
{
  imports = with inputs; [
    hjem.nixosModules.default
    emoji-picker-nix.nixosModules.default
    walker.nixosModules.default
  ];

  disabledModules = [ "hardware/facter/system.nix" ];

  options = {
    # Stolen from https://github.com/chaotic-cx/nyx/blob/main/modules/nixos/zfs-impermanence-on-shutdown.nix
    services.zfs.rollback = {
      enable = lib.mkEnableOption "Impermanence on safe-shutdown through ZFS snapshots";
      volume = lib.mkOption {
        type = lib.types.str;
        default = null;
        example = "zroot/ROOT/empty";
        description = ''
          Full description to the volume including pool.
          This volume must have a snapshot to an "empty" state.
          WARNING: The volume will be rolled back to the snapshot on every safe-shutdown.
        '';
      };
      snapshot = lib.mkOption {
        type = lib.types.str;
        default = null;
        example = "start";
        description = ''
          Snapshot of the volume in an "empty" state to roll back to.
        '';
      };
    };
    programs = {
      google-chrome = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "whether to enable Google Chrome.";
        };
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Google Chrome, can be overridden.";
          default = inputs'.browser-previews.packages.google-chrome-dev;
        };
      };
      kakoune = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "whether to enable Kakoune.";
        };
        defaultEditor = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Set Kakoune as the default editor.";
        };
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for Kakoune, can be overridden.";
          default = self'.packages.kakoune;
        };
      };
    };
  };

  config =
    let
      existingUsers = builtins.attrNames config.users.users;
      normalUsers = lib.filter (user: config.users.users.${user}.isNormalUser or false) existingUsers;
      hasPreservation = options ? preservation;
    in
    lib.mkMerge [
      {

        hjem = {
          clobberByDefault = lib.mkDefault true;
          linker = inputs'.hjem.packages.smfh;
          extraModules = [ inputs.hjem-rum.hjemModules.default ];
        };

        time.timeZone = lib.mkDefault "Canada/Eastern";

        i18n = {
          defaultLocale = lib.mkDefault "en_CA.UTF-8";
          extraLocaleSettings.LC_TIME = lib.mkDefault "C.UTF-8";
        };

        systemd.oomd = {
          enable = true;
          enableRootSlice = true;
          enableSystemSlice = true;
          enableUserSlices = true;
          settings.OOM.DefaultMemoryPressureDurationSec = "20s";
        };

        hardware.graphics = {
          enable = lib.mkForce config.programs.niri.enable;
          enable32Bit = lib.mkForce config.programs.niri.enable;
        };

        networking = {
          useDHCP = lib.mkDefault true;
          networkmanager = {
            enable = lib.mkForce false;
            wifi.powersave = lib.mkDefault false;
          };
          wireless.enable = lib.mkForce false;
          useNetworkd = lib.mkDefault true;
        };

        nix = {
          registry.nixpkgs.flake = inputs.nixpkgs;
          nixPath = [ "nixpkgs=flake:nixpkgs" ];
          channel.enable = lib.mkForce false;
          settings = {
            auto-allocate-uids = true;
            trusted-users = [ "@wheel" ];
            allowed-users = lib.mapAttrsToList (_: u: u.name) (
              lib.filterAttrs (_: user: user.isNormalUser) config.users.users
            );
            "flake-registry" = "/etc/nix/registry.json";
            warn-dirty = false;
            keep-derivations = true;
            keep-outputs = true;
            accept-flake-config = false;
            allow-import-from-derivation = false;
            builders-use-substitutes = true;
            use-xdg-base-directories = true;
            use-cgroups = true;
            log-lines = 30;
            keep-going = true;
            connect-timeout = 5;
            sandbox = true;
            http-connections = 0;
            max-substitution-jobs = 128;
            system-features = [ "uid-range" ];
            extra-experimental-features = [
              "nix-command"
              "flakes"
              "cgroups"
              "auto-allocate-uids"
              "fetch-closure"
              "dynamic-derivations"
              "pipe-operators"
              "recursive-nix"
            ];
          };
        };

        users = {
          mutableUsers = lib.mkForce false;
          users.mcsimw = {
            enable = lib.mkDefault false;
            description = "Maor Haimovitz";
            isNormalUser = true;
            linger = true;
            extraGroups = [
              "wheel"
              "libvirtd"
              "networkmanager"
              "video"
              "adbusers"
              "docker"
              "audio"
              "wireshark"
            ];
            uid = lib.mkDefault 1000;
            initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
            packages = [
              self'.packages.git
              self'.packages.tmux
              inputs'.nvim.packages.default
            ];
          };
        };

        environment = {
          defaultPackages = lib.mkForce [ ];
          variables = {
            NIXPKGS_CONFIG = lib.mkDefault "";
            EDITOR = lib.mkIf config.programs.kakoune.defaultEditor (lib.mkOverride 900 "kak");
          };
          systemPackages =
            with pkgs;
            [
              npins
              btop
              unzip
              unrar
              p7zip
              texliveFull
              typst
              wget
              nethack
              unnethack
              neomutt
              file
              shpool
              exfatprogs
              amfora
              parted
              cryptsetup
              btrfs-progs
              xfsprogs
              f2fs-tools
              rsync
              entr
              xdg-user-dirs
              openvi
              pandoc
              sc-im
              fastfetch
              onefetch
              eza
              figlet
              toilet
              cowsay
              fd
              ripgrep
              fzf
              yt-dlp_git
              shpool
              tree
              nvfetcher
            ]
            ++ (lib.optionals config.programs.niri.enable [
              mako
              wmenu
              adwaita-icon-theme
              zathura
              imv
              wl-clipboard-rs
              ani-cli
              mpv
              pkgs.nautilus
              inputs'.xwayland-satellite.packages.default
              fuzzel
              discord
              signal-desktop
              obs-studio
            ])
            ++ (lib.optionals config.programs.kakoune.enable [ config.programs.kakoune.package ])
            ++ (lib.optionals config.programs.chromium.enable [ config.programs.google-chrome.package ])
            ++ (lib.optional (config.programs.niri.enable && config.services.pipewire.enable) pwvucontrol)
            ++ (lib.optional (config.programs.niri.enable && config.programs.wireshark.enable) wireshark);
        };

        services = {
          udisks2.enable = lib.mkDefault true;
          pulseaudio.enable = lib.mkForce false;
          userborn.enable = lib.mkForce true;
          openssh.hostKeys = [
            {
              path = "/etc/ssh/ssh_host_ed25519_key";
              type = "ed25519";
            }
          ];
          gpm.enable = lib.mkDefault true;
          dbus = {
            implementation = lib.mkForce "broker";
            packages = [ pkgs.dconf ];
          };
        };

        documentation = lib.genAttrs [ "doc" "nixos" "info" ] (_: {
          enable = lib.mkDefault false;
        });

        programs = {
          command-not-found.enable = lib.mkForce false;
          google-chrome.enable = config.programs.niri.enable;
          emoji-fuzzel = {
            inherit (config.programs.niri) enable;
            src = "unicode";
          };
          wireshark.enable = lib.mkDefault true;
          starship = {
            enable = lib.mkDefault config.programs.niri.enable;
            settings.add_newline = lib.mkDefault false;
          };
          chromium = {
            inherit (config.programs.google-chrome) enable;
            extraOpts = {
              "SmoothScrollingEnabled" = false;
            };
            extensions = [
              "nngceckbapebfimnlniiiahkandclblb"
            ];
          };
          appimage = {
            enable = lib.mkDefault true;
            binfmt = lib.mkDefault true;
          };
          firefox = {
            inherit (config.programs.niri) enable;
            package = lib.mkDefault inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
          };
          zoxide.enable = lib.mkDefault true;
          direnv.enable = lib.mkDefault true;
          gnupg.agent = {
            enable = lib.mkDefault true;
            pinentryPackage = lib.mkDefault pkgs.pinentry-curses;
          };
          dconf = {
            inherit (config.programs.niri) enable;
            profiles.user.databases = [
              {
                lockAll = false;
                settings = {
                  "org/gnome/desktop/interface" = {
                    accent-color = "pink";
                    color-scheme = "prefer-dark";
                  };
                  "org/gnome/desktop/wm/preferences" = {
                    button-layout = "";
                  };
                };
              }
            ];
          };
          uwsm = {
            inherit (config.programs.niri) enable;
            waylandCompositors.niri = {
              prettyName = "Niri";
              comment = "Niri compositor managed by UWSM";
              # https://github.com/YaLTeR/niri/issues/254
              binPath = pkgs.writeShellScript "niri" ''
                ${lib.getExe config.programs.niri.package} --session
              '';
            };
          };
          niri.package = inputs'.niri.packages.default;
          fuse.userAllowOther = true;
          nano.enable = lib.mkForce false;
          bat.enable = true;
          git = {
            enable = lib.mkForce true;
            lfs.enable = lib.mkDefault true;
          };
          foot = {
            inherit (config.programs.niri) enable;
            package = lib.mkDefault pkgs.foot;
            settings = {
              main = {
                font = "Spleen:size=12, Symbols Nerd Font Mono:size=9, Apple Color Emoji:size=9";
                font-size-adjustment = 6;
                bold-text-in-bright = true;
                pad = "40x40";
              };

              colors = {
                background = "000000";
                foreground = "ffffff";
                cursor = "ffffff cc0077";

                regular0 = "000000";
                regular1 = "ee2a2a";
                regular2 = "00ff5f";
                regular3 = "ffdd00";
                regular4 = "2f8fff";
                regular5 = "ff5fae";
                regular6 = "00d7d7";
                regular7 = "d0d0d0";

                bright0 = "3a3a3a";
                bright1 = "ff5555";
                bright2 = "00ffaa";
                bright3 = "ffff66";
                bright4 = "7ab7ff";
                bright5 = "ff85d7";
                bright6 = "7fffff";
                bright7 = "ffffff";

                "16" = "ffae00";
                "17" = "ff7755";

                selection-background = "cc0077";
                selection-foreground = "000000";

                urls = "88ccff";
              };

            };
          };
        };

        xdg.portal = {
          inherit (config.programs.niri) enable;
          xdgOpenUsePortal = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-gnome
          ];
          config = {
            common.default = [ "gtk" ];
            niri = {
              default = [
                "gnome"
                "gtk"
              ];
              "org.freedesktop.impl.portal.Access" = "gtk";
              "org.freedesktop.impl.portal.Notification" = "gtk";
              "org.freedesktop.portal.RemoteDesktop" = "none";
              "org.freedesktop.portal.Wallpaper" = "none";
            };
          };
        };

        security = {
          polkit.enable = lib.mkDefault true;
          rtkit.enable = lib.mkDefault true;
          sudo = {
            wheelNeedsPassword = lib.mkDefault false;
            execWheelOnly = lib.mkForce true;
          };
          pam.loginLimits = [
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
        };

      }

      (
        let
          cfg = config.services.zfs.rollback;
          cfgZfs = config.boot.zfs;
        in
        lib.mkIf cfg.enable {
          systemd.shutdownRamfs = {
            contents."/etc/systemd/system-shutdown/zpool".source = lib.mkForce (
              pkgs.writeShellScript "zpool-sync-shutdown" ''
                ${cfgZfs.package}/bin/zfs rollback -r "${cfg.volume}@${cfg.snapshot}"
                exec ${cfgZfs.package}/bin/zpool sync
              ''
            );
            storePaths = [ "${cfgZfs.package}/bin/zfs" ];
          };
        }
      )

      (lib.mkIf config.programs.niri.enable {
        fonts = {
          enableDefaultPackages = lib.mkForce false;

          fontconfig = {
            useEmbeddedBitmaps = true;

            antialias = false;

            hinting = {
              enable = false;
              style = "none";
            };

            subpixel = {
              lcdfilter = "none";
              rgba = "none";
            };

            defaultFonts = {
              serif = [
                "Fraunces"
                "Apple Color Emoji"
                "Noto Sans Symbols"
                "Symbols Nerd Font"
              ];
              sansSerif = [
                "Inter Variable"
                "Apple Color Emoji"
                "Noto Sans Symbols"
                "Symbols Nerd Font"
              ];
              monospace = [
                "Cascadia Code"
                "Apple Color Emoji"
                "Noto Sans Symbols"
                "Symbols Nerd Font Mono"
              ];
              emoji = [ "Apple Color Emoji" ];
            };
          };

          packages =
            with pkgs;
            [
              spleen
              terminus_font
              nerd-fonts.symbols-only
              inter
              fraunces
              (pkgs.cascadia-code.override { useVariableFont = true; })
              corefonts
              vista-fonts
              vista-fonts-cht
              vista-fonts-chs
              noto-fonts
              noto-fonts-color-emoji
              noto-fonts-cjk-serif
              noto-fonts-cjk-sans
              noto-fonts-lgc-plus
            ]
            ++ (
              with inputs';
              [ apple-emoji-linux.packages.default ]
              ++ (with apple-fonts.packages; [
                sf-pro
                sf-compact
                sf-mono
                sf-arabic
                sf-armenian
                sf-georgian
                sf-hebrew
                ny
              ])
            );
        };
      })

      (lib.optionalAttrs hasPreservation {
        preservation.preserveAt."/persist" = {
          files = [
            {
              file = "/etc/ssh/ssh_host_ed25519_key";
              how = "symlink";
              configureParent = true;
            }
            {
              file = "/etc/ssh/ssh_host_ed25519_key.pub";
              how = "symlink";
              configureParent = true;
            }
          ];
          users = lib.genAttrs normalUsers (_user: {
            directories = [
              {
                directory = ".ssh";
                mode = "0700";
              }
            ];
          });
        };
      })
    ];
}
