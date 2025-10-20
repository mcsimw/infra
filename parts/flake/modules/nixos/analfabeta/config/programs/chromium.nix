{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      programs.chromium = {
        inherit (config.programs.google-chrome) enable;
        extraOpts = {
          "SmoothScrollingEnabled" = false;
        };
        extensions = [
          "nngceckbapebfimnlniiiahkandclblb"

        ];
      };
    };
}
