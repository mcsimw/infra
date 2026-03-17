{
  desktops,
  config,
  lib,
  ...
}:
let
  inherit (config) sources;
  apple-emoji-linux =
    _: pkgs:
    pkgs.stdenvNoCC.mkDerivation {
      pname = "apple-emoji-linux";
      version = "macos-26-20260219-2aa12422";
      src = pkgs.fetchurl {
        url = "https://github.com/samuelngs/apple-emoji-ttf/releases/download/macos-26-20260219-2aa12422/AppleColorEmoji-Linux.ttf";
        hash = "sha256-U1oEOvBHBtJEcQWeZHRb/IDWYXraLuo0NdxWINwPUxg=";
      };
      dontUnpack = true;
      installPhase = ''
        runHook preInstall
        mkdir -p $out/share/fonts/truetype
        cp $src $out/share/fonts/truetype/AppleColorEmoji.ttf
        runHook postInstall
      '';
    };
in
{
  flake = {
    packages = lib.genAttrs config.nixpkgs.systems (system: {
      apple-emoji-linux = apple-emoji-linux system (import sources.nixpkgs { inherit system; });
    });
    modules.nixos = {
      default = config.flake.modules.nixos.fonts;
      fonts =
        {
          lib,
          pkgs,
          config,
          ...
        }:
        {
          fonts =
            let
              inherit (lib)
                mkForce
                mkDefault
                mkIf
                ;
              inherit (builtins) any attrNames;
              anyDesktop = cfg: any (name: desktops.byName.${name}.check cfg) (attrNames desktops.byName);
              cfg = anyDesktop config;
            in
            {
              enableDefaultPackages = mkForce false;
              fontconfig = {
                enable = cfg;
                useEmbeddedBitmaps = mkDefault true;
                antialias = mkDefault false;
                hinting = {
                  enable = mkDefault false;
                  style = mkDefault "none";
                };
                subpixel = {
                  lcdfilter = mkDefault "none";
                  rgba = mkDefault "none";
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
              packages = mkIf cfg (
                with pkgs;
                [
                  spleen
                  terminus_font
                  nerd-fonts.symbols-only
                  inter
                  fraunces
                  (pkgs.cascadia-code.override { useVariableFont = true; })
                  corefonts
                  vista-fonts
                  vista-fonts-cht
                  vista-fonts-chs
                  noto-fonts
                  noto-fonts-color-emoji
                  noto-fonts-cjk-serif
                  noto-fonts-cjk-sans
                  noto-fonts-lgc-plus
                  geist-font
                  (apple-emoji-linux pkgs.stdenv.hostPlatform.system pkgs)
                ]
              );
            };
        };
    };
  };
}
