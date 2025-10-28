{ inputs, ... }:
{
  perSystem =
    { pkgs, self', ... }:
    {
      packages.tmux = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = self'.packages.tmux-unwrapped;
        flags = {
          "-f" = pkgs.writeText "tmux.conf" ''
            set -g status-position top
            set -g base-index 1
            setw -g mode-keys vi
            set -g focus-events on
          '';
        };
      };
    };
}
