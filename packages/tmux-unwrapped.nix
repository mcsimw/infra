{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.tmux-unwrapped = pkgs.tmux.overrideAttrs {
        version = inputs.tmux.rev;
        src = inputs.tmux;
      };
    };
}
