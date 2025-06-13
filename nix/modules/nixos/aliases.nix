{
  flake.modules.nixos.aliases =
    {
      lib,
      config,
      pkgs,
      ...
    }:

    let
      cfg = config.analfabeta.rebuilder;
      dotfilesPath = lib.escapeShellArg (toString cfg.dotfiles);
    in
    {
      options.analfabeta.rebuilder = {
        enable = lib.mkEnableOption "installs switch/boot/update tools";

        dotfiles = lib.mkOption {
          type = lib.types.path;
          description = "Path to the flake-based dotfiles directory.";
          example = "/etc/nixos";
        };
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          (writeShellApplication {
            name = "switch";
            text = ''nixos-rebuild switch --flake "${dotfilesPath}#$(hostname)" --show-trace --verbose --sudo'';
          })

          (writeShellApplication {
            name = "boot";
            text = ''nixos-rebuild boot --flake "${dotfilesPath}#$(hostname)" --show-trace --verbose --sudo'';
          })

          (writeShellApplication {
            name = "update";
            text = ''nix flake update --flake "${dotfilesPath}"'';
          })
        ];
      };
    };
}
