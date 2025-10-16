{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.git = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.gitFull;
        runtimeInputs = with pkgs; [
          gitFull
          git-extras
        ];
        env.GIT_CONFIG_GLOBAL = ./config;
      };
    };

}
