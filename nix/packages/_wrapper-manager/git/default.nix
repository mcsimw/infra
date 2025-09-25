{
  pkgs,
  dotfiles,
  ...
}:
{
  wrappers.git = {
    basePackage = pkgs.gitFull;
    extraPackages = with pkgs; [
      git-extras
      gitFull
    ];
    env.GIT_CONFIG_GLOBAL.value = "${dotfiles}/git/config.ini";
  };
}
