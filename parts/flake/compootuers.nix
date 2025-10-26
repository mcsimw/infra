{ self, ... }:
{
  flake.compootuers = {
    perSystem = self + /compootuers/perSystem;
    allSystems = self + /compootuers/allSystems;
    perArch = self + /compootuers/perArch;
  };
}
