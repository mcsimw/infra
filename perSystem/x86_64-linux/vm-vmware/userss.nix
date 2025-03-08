{ pkgs, inputs, ... }:
{
  users.users.mcsimw.packages = [
    (inputs.wrapper-manager.lib.build {
      inherit pkgs;
      modules = [
        {
          wrappers.user-git = {
            basePackage = pkgs.gitFull;
            extraPackages = [
              pkgs.git-extras
              pkgs.gitFull
            ];
            env.GIT_CONFIG_GLOBAL.value = ./gitconfig;
          };
        }
      ];
    })
  ];
}
