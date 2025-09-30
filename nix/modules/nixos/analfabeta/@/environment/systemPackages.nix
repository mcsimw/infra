{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { pkgs, inputs', ... }:
    _:
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
          pandoc
          fd
          ripgrep
          fzf
        ]
        ++ [ inputs'.typst.packages.default ];
    }
  );
}
