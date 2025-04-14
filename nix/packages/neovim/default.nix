pkgs:
let
  opt = plugins: map (p: p // { optional = true; }) plugins;
in
{
  appName = "nvim-mcsimw";
  desktopEntry = false;

  providers = {
    python3.enable = false;
    ruby.enable = false;
    perl.enable = false;
    nodeJs.enable = false;
  };

  plugins =
    [ ./. ]
    ++ opt (
      with pkgs.vimPlugins;
      [
        lz-n
        nvim-treesitter.withAllGrammars
        lualine-nvim
        modus-themes-nvim
        blink-cmp
      ]
    );

  extraBinPath = builtins.attrValues {
    inherit (pkgs)
      ripgrep
      fd
      ;
  };

  aliases = [ "vi" ];
}
