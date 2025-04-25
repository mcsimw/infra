pkgs: {
  appName = "nvim";

  desktopEntry = false;

  providers = {
    python3.enable = false;
    ruby.enable = false;
    perl.enable = false;
    nodeJs.enable = false;
  };

  initLua = builtins.readFile ./init.lua;

  plugins = with pkgs.vimPlugins; [
    ./.
    modus-themes-nvim
  ];

  extraBinPath = builtins.attrValues {
    inherit (pkgs)
      ripgrep
      fd
      ;
  };

  aliases = [ "vi" ];
}
