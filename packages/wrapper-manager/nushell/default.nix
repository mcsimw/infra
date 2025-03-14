{ pkgs, inputs, ... }:
{
  wrappers.nushell = {
    basePackage = pkgs.nushell;
    flags = [
      "--env-config"
      "${inputs.dotfiles-legacy.outPath}/.config/nushell/env.nu"
      "--config"
      "${inputs.dotfiles-legacy.outPath}/.config/nushell/config.nu"
    ];
  };
}
