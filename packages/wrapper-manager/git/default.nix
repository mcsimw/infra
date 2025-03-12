{ pkgs, inputs, ... }:
{
  wrappers.git = {
    basePackage = pkgs.gitFull;
    extraPackages = [
      pkgs.git-extras
      pkgs.gitFull
    ];
    env.GIT_CONFIG_GLOBAL.value = "${inputs.dotfiles-legacy.outPath}/.config/git/config";
    env.GIT_CLONE_FLAGS.value = "--recursive --filter=blob:none";
  };
}
