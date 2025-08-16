{
  inputs,
  self,
  ...
}:
{
  perSystem =
    {
      pkgs,
      self',
      inputs',
      ...
    }:
    {
      packages.eldritch = inputs.nix-maid pkgs {
        packages = [
          self'.packages.nvim
          self'.packages.kakoune
        ]
        ++ (import (self + "/nix/misc/_pkgs.nix") { inherit pkgs inputs'; });
        imports = with self.modules.maid; [
          git
        ];
      };
    };
}
