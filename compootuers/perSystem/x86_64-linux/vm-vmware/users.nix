{ self, inputs, ... }:
{
  imports = [
    self.nixosModules.git-user
  ];
  lemon.git.users.mcsimw = {
    enable = true;
    config = "${inputs.dotfiles-legacy.outPath}/.config/git/config";
  };
}
