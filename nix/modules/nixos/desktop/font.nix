{ moduleWithSystem, ... }:
{
  flake.modules.nixos.infra = moduleWithSystem (
    { inputs', pkgs, ... }:
    { config, lib, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
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
          ];
        };
      };
    }
  );
}
