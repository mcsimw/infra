{ moduleWithSystem, self, ... }:
{
  flake.modules.nixos.infra =
    (
      { self }:
      moduleWithSystem (
        {
          inputs',
          pkgs,
          ...
        }:
        { config, lib, ... }:
        let
          vars = import (self + /nix/modules/nixos/desktop/_vars.nix) config;
        in
        {
          config = lib.mkIf vars.desktop {
            fonts = {
              enableDefaultPackages = lib.mkForce false;
              fontconfig = {
                useEmbeddedBitmaps = true;
                antialias = false;
                hinting = {
                  enable = false;
                  style = "none";
                };
                subpixel.lcdfilter = "none";
                defaultFonts = {
                  serif = [
                    "Fraunces"
                    "Symbols Nerd Font"
                  ];
                  sansSerif = [
                    "Inter Variable"
                    "Symbols Nerd Font"
                  ];
                  monospace = [
                    "Cascadia Code"
                    "Symbols Nerd Font Mono"
                  ];
                  emoji = [ "Apple Color Emoji" ];
                };
              };
              packages = with pkgs; [
                spleen
                terminus_font
                nerd-fonts.symbols-only
                inputs'.apple-emoji-linux.packages.default
                noto-fonts
                noto-fonts-cjk-sans
                noto-fonts-cjk-serif
                corefonts
                vista-fonts
                inter
                fraunces
                (pkgs.cascadia-code.override { useVariableFont = true; })
                pixel-code
              ];
            };
          };
        }
      )
    )
      { inherit self; };
}
