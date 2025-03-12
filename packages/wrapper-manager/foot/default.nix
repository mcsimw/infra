{ inputs, inputs', ... }:
{
  wrappers.foot = {
    basePackage = inputs'.nixpkgs.legacyPackages.foot; # foot won't compile on nixpkgs-wayland :(
    flags = [ "--config=${inputs.dotfiles-legacy.outPath}/.config/foot/foot.ini" ];
  };
}
