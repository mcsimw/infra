{
  symlinkJoin,
  gitFull,
  git-extras,
  makeWrapper,
}:
symlinkJoin {
  inherit (gitFull)
    name
    meta
    passthru
    ;

  paths = [
    gitFull
    git-extras
  ];

  nativeBuildInputs = [ makeWrapper ];

  postBuild = ''
    for file in $out/bin/*; do
      wrapProgram $file \
        --set GIT_CONFIG_GLOBAL "${./../../mcsimw/git/.config/git/config}" \
        --set GIT_CLONE_FLAGS "--recursive --filter=blob:none"
    done
  '';
}
