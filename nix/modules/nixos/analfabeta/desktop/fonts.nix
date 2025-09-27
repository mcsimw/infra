{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    {
      inputs',
      pkgs,
      ...
    }:
    { config, lib, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        fonts = {
          enableDefaultPackages = lib.mkForce false;
          fontconfig = {
            useEmbeddedBitmaps = true;
            antialias = true;
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
          packages = with pkgs; [
            spleen
            terminus_font
            nerd-fonts.symbols-only
            inputs'.apple-emoji-linux.packages.default
            inter
            fraunces
            (pkgs.cascadia-code.override { useVariableFont = true; })
            corefonts
            vista-fonts
            noto-fonts
            noto-fonts-color-emoji
            noto-fonts-cjk-serif
            noto-fonts-cjk-sans
            noto-fonts-lgc-plus
          ];
        };
      };
    }
  );
}
