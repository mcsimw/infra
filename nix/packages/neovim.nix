{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.neovim = inputs.mnw.lib.wrap pkgs {
        appName = "moo";
        initLua =
          #lua
          ''
            vim.loader.enable(true)
          '';
      };
    };
}
