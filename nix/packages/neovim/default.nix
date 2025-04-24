pkgs: {
  appName = "nvim-mcsimw";

  desktopEntry = false;

  providers = {
    python3.enable = false;
    ruby.enable = false;
    perl.enable = false;
    nodeJs.enable = false;
  };

  initLua = builtins.readFile ./init.lua;

  plugins = builtins.map (p: p // { optional = true; }) (
    (with pkgs.vimPlugins; [
      modus-themes-nvim
    ])
    ++ [
      (
        pkgs.vimUtils.buildVimPlugin {
          name = "yes";
          src = ./.;
          dontCheck = true;
        }
        // {
          optional = true;
        }
      )
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
