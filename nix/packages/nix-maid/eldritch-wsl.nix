{
  inputs,
  self,
  ...
}:
{
  perSystem =
    { pkgs, self', ... }:
    {
      packages.eldritch-wsl = inputs.nix-maid pkgs {
        packages = [
          self'.packages.nvim
          pkgs.onefetch
          pkgs.fastfetch
          pkgs.tmux
        ];
        imports = with self.modules.maid; [
          git
        ];
      };
    };
}
