{ moduleWithSystem, ... }:
{
  flake.modules.nixos.users = moduleWithSystem (
    { self', ... }:
    {
      config,
      lib,
      self,
      ...
    }:
    let
      cfg = config.analfabeta.users.mcsimw.enable;
    in
    {
      options.analfabeta.users.mcsimw.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };

      config = lib.mkIf cfg {
        analfabeta.enabledUsers = [ "mcsimw" ];
        preservation.preserveAt."/persist".users.mcsimw = {
          commonMountOptions = [ "x-gvfs-hide" ];
          directories = [
            {
              directory = ".ssh";
              mode = "0700";
            }
          ]
          ++ lib.optionals config.programs.steam.enable [
            ".local/share/Steam"
            ".steam"
          ];
        };

        hjem.users.mcsimw = {
          files = {
            ".config/niri/config.kdl".source = "${self}/dotfiles/niri/config.kdl";
            ".config/mpd/mpd.conf".source =
              lib.mkIf config.analfabeta.programs.mpd.enable "${self}/dotfiles/mpd.conf";
          };
        };

        users.users.mcsimw = {
          description = "Maor Haimovitz";
          isNormalUser = true;
          linger = true;
          extraGroups = [ "wheel" ] ++ (import ../_extraGroups.nix { inherit config lib; });
          uid = 1000;
          initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
          packages = with self'.packages; [
            git
            nvim
          ];
        };
      };
    }
  );
}
