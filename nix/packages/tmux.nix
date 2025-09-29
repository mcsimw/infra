{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.tmux = pkgs.tmux.overrideAttrs {
        version = inputs.tmux.rev;
        src = inputs.tmux;
      };
    };
}
