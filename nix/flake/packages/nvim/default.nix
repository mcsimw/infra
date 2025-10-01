{
  inputs,
  ...
}:
{
  perSystem =
    { pkgs, inputs', ... }:
    {
      packages.nvim = inputs.mnw.lib.wrap pkgs {
        appName = "moo";
        initLua = builtins.readFile ./init.lua;
        aliases = [ "vi" ];
        extraBinPath = with pkgs; [
          lua-language-server
          nixd
          deadnix
          statix
          ripgrep
          fd
        ];
        plugins = {
          dev.mcsimw.pure = ../../../../stow/nvim/.config/nvim;
          start = [
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars
            pkgs.vimPlugins.nvim-treesitter-context
            pkgs.vimPlugins.nvim-treesitter-textobjects
          ]
          ++ inputs.mnw.lib.npinsToPlugins pkgs ./start.json;
          opt = [
            inputs'.blink-cmp.packages.default
          ]
          ++ inputs.mnw.lib.npinsToPlugins pkgs ./opt.json;
        };
      };
    };
}
