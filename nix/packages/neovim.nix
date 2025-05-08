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
      packages.neovim = inputs.mnw.lib.wrap pkgs (
        { pkgs, ... }:
        {
          appName = "moo";
          initLua = builtins.readFile ./init.lua;
          aliases = [ "vi" ];
          plugins = {
            start =
              (
                with pkgs.vimPlugins;
                [
                  lz-n
                  modus-themes-nvim
                  nvim-treesitter
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
                  src = self + "/neovim";
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
