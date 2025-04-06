{
  symlinkJoin,
  makeWrapper,
  inputs',
}:
symlinkJoin {
  inherit (inputs'.nixpkgs.legacyPackages.foot)
    name
    meta
    passthru
    ;

  paths = [ inputs'.nixpkgs.legacyPackages.foot ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/foot \
      --add-flags "--config=${./../../mcsimw/foot/.config/foot/foot.ini}"
  '';
}
