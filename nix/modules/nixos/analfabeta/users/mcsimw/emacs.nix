{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { pkgs }:
    {
      config,
      lib,
      ...
    }:
    {
      config = lib.mkIf (config.analfabeta.users.mcsimw.enable && config.hardware.graphics.enable) {
        users.users.mcsimw.packages = with pkgs; [
          ((emacsPackagesFor emacs-igc-pgtk).emacsWithPackages (epkgs: [
            epkgs.eat
            epkgs.treesit-grammars.with-all-grammars
            epkgs.lsp-mode
            epkgs.haskell-mode
            epkgs.ef-themes
          ]))
        ];
      };
    }
  );
}
