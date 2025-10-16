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
            set -g status-left-length 100
            set -g status-style "fg=#FFFFFF,bg=#000000"

            set -g mouse on
            set -g mode-keys vi

            set  -g base-index 1
            setw -g pane-base-index 1
          '';
        };
      };
    };
}
