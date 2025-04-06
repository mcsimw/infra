pkgs: {
  appName = "nvim-mcsimw";
  desktopEntry = false;
  providers = {
    python3.enable = false;
    ruby.enable = false;
    perl.enable = false;
    nodeJs.enable = false;
  };
  plugins = [
    ./init
    pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    pkgs.vimPlugins.modus-themes-nvim
    pkgs.vimPlugins.lualine-nvim
    pkgs.vimPlugins.telescope-nvim
    pkgs.vimPlugins.harpoon2
    pkgs.vimPlugins.vimtex
  ];
  extraBinPath = builtins.attrValues {
    inherit (pkgs)
      ripgrep
      fd
      zathura
      ;
  };
  aliases = [ "vi" ];
}
