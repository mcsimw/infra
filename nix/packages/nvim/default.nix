{
  inputs,
  lib,
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
        ];
        plugins = {
          dev.mcsimw.pure = ../../../dotfiles/nvim;
          start = inputs.mnw.lib.npinsToPlugins pkgs ./start.json;
          opt = [
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars
            inputs'.blink-cmp.packages.default
          ] ++ inputs.mnw.lib.npinsToPlugins pkgs ./opt.json;
        };
      };
    };
}
