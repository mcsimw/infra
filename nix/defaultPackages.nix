{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.default-packages;
    default-packages =
      { lib, pkgs, ... }:
      {
        environment = {
          defaultPackages = lib.mkForce [ ];
          systemPackages = with pkgs; [
            unzip
            unrar
            p7zip
            btop
            fastfetch
            onefetch
            texliveFull
            typst
            pandoc
            groff
            file
            rsync
            tree
            entr
            fd
            ripgrep
            fzf
            eza
            xdg-user-dirs
            parted
            cryptsetup
            btrfs-progs
            xfsprogs
            f2fs-tools
            exfatprogs
            wget
            yt-dlp
            neomutt
            amfora
            openvi
            sc-im
            shpool
            tmux
            npins
            nix-diff
            nix-init
            nixfmt
            deadnix
            nethack
            figlet
            toilet
            cowsay
          ];
        };
      };
  };
}
