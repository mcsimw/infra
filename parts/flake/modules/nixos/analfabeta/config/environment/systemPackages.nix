{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    {
      pkgs,
      inputs',
      self',
    }:
    { config, ... }:
    {
      environment.systemPackages =
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
          self'.packages.ghostty
        ])
        ++ (lib.optionals config.programs.kakoune.enable [ config.programs.kakoune.package ])
        ++ (lib.optionals config.programs.ghostty.enable [ config.programs.ghostty.package ])
        ++ (lib.optionals config.programs.helium.enable [ config.programs.helium.package ])
        ++ (lib.optionals config.programs.prismlauncher.enable [ config.programs.prismlauncher.package ])
        ++ (lib.optional (config.programs.niri.enable && config.services.pipewire.enable) pwvucontrol)
        ++ (lib.optional (config.programs.niri.enable && config.programs.wireshark.enable) wireshark);
    }
  );
}
