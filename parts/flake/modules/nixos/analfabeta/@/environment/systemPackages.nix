{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    {
      pkgs,
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
          yt-dlp_git
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
        ]
        ++ (lib.optionals config.programs.niri.enable [
          mako
          wmenu
          adwaita-icon-theme
          zathura
          imv
          wl-clipboard-rs
          ani-cli
          nur.repos.Ev357.helium
          mpv
        ])
        ++ (lib.optional (config.programs.niri.enable && config.services.pipewire.enable) pwvucontrol_git)
        ++ (lib.optional (config.programs.niri.enable && config.programs.wireshark.enable) wireshark);
    }
  );
}
