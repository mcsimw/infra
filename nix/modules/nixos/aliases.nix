{
  flake.modules.nixos.aliases =
    {
      lib,
      config,
      pkgs,
      ...
    }:

    let
      cfg = config.myShit.rebuilder;
      dotfilesPath = lib.escapeShellArg (toString cfg.dotfiles);
    in
    {
      options.myShit.rebuilder = {
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
            runtimeInputs = [ ];
            text = ''
              nixos-rebuild switch --flake "''${DOTFILES:-${dotfilesPath}}#$(hostname)" --show-trace --verbose --sudo
            '';
          })

          (writeShellApplication {
            name = "boot";
            runtimeInputs = [ ];
            text = ''
              nixos-rebuild boot --flake "''${DOTFILES:-${dotfilesPath}}#$(hostname)" --show-trace --verbose --sudo
            '';
          })

          (writeShellApplication {
            name = "update";
            runtimeInputs = [ nix ];
            text = ''
              nix flake update --flake "''${DOTFILES:-${dotfilesPath}}"
            '';
          })
        ];
      };
    };
}
