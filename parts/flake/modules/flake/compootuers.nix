{ self, ... }:
{
  flake.compootuers = {
    perSystem = self + /_compootuers/perSystem;
    allSystems = self + /_compootuers/allSystems;
  };
}
