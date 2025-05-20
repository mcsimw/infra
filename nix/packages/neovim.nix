{
  inputs,
  lib,
  self,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.nvim = inputs.mnw.lib.wrap pkgs (
        { pkgs, ... }:
        {
          appName = "moo";
          initLua = builtins.readFile ./init.lua;
          aliases = [ "vi" ];
          extraBinPath = with pkgs; [
            lua-language-server
          ];
          plugins = {
            start =
              (
                with pkgs.vimPlugins;
                [
                  lz-n
                  modus-themes-nvim
                  nvim-treesitter
                  lualine-nvim
                  nvim-lspconfig
                  lazydev-nvim
                ]
                ++ (
                  nvim-treesitter.grammarPlugins
                  |> lib.filterAttrs (n: _: !(builtins.elem n [ "comment" ]))
                  |> builtins.attrValues
                )
              )
              ++ [
                {
                  name = "nixos-local";
                  src = self + "/nvim";
                }
              ];
            opt = [
              pkgs.vimPlugins.oil-nvim
            ];
          };
        }
      );
    };
}
