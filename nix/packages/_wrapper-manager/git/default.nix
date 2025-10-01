{
  pkgs,
  self,
  ...
}:
{
  wrappers.git = {
    basePackage = pkgs.gitFull;
    extraPackages = with pkgs; [
      git-extras
      gitFull
    ];
    env.GIT_CONFIG_GLOBAL.value = "${self}/stow/git/.config/git/config";
  };
}
