{ moduleWithSystem, ... }:
{
  flake.modules.nixos.mcsimw = moduleWithSystem (
    { self', ... }:
    {
      config,
      lib,
      pkgs,
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
        preservation.preserveAt."/persist".users.mcsimw = {
          commonMountOptions = [ "x-gvfs-hide" ];
          directories = [
            {
              directory = ".ssh";
              mode = "0700";
            }
          ];
        };

        users.users.mcsimw = {
          description = "Maor Haimovitz";
          isNormalUser = true;
          linger = true;
          extraGroups = [ "wheel" ] ++ (import ./_extraGroups.nix { inherit config lib; });
          uid = 1000;
          initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
          packages =
            (with self'.packages; [
              nvim
              git
            ])
            ++ lib.optionals config.programs.foot.enable [ self'.packages.foot ]
            ++ (with pkgs; [
              ((emacsPackagesFor emacs-igc-pgtk).emacsWithPackages (epkgs: [
                epkgs.eat
                epkgs.treesit-grammars.with-all-grammars
                epkgs.lsp-mode
                epkgs.haskell-mode
                epkgs.ef-themes
              ]))
            ])
            ++ lib.optionals config.programs.kakoune.enable [
              (config.programs.kakoune.package.overrideAttrs (_oldAttrs: {
                plugins = with pkgs.kakounePlugins; [ parinfer-rust ];
              }))
            ];
        };

        systemd.tmpfiles.settings.preservation = {
          "/home/mcsimw/.config".d = {
            user = "mcsimw";
            group = "users";
            mode = "0755";
          };
          "/home/mcsimw/.local".d = {
            user = "mcsimw";
            group = "users";
            mode = "0755";
          };
          "/home/mcsimw/.local/share".d = {
            user = "mcsimw";
            group = "users";
            mode = "0755";
          };
          "/home/mcsimw/.local/state".d = {
            user = "mcsimw";
            group = "users";
            mode = "0755";
          };
        };
      };
    }
  );
}
