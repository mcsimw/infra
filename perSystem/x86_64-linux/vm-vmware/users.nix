{ self, ... }:
{
  imports = [
    self.nixosModules.git-user
  ];
  lemon.git.users.mcsimw = {
    enable = true;
    gitconfigFile = ./gitconfig;
  };
}
