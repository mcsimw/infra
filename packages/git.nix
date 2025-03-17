{
  symlinkJoin,
  gitFull,
  git-extras,
  makeWrapper,
  inputs,
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
        --set GIT_CONFIG_GLOBAL "${inputs.dotfiles-legacy.outPath}/.config/git/config" \
        --set GIT_CLONE_FLAGS "--recursive --filter=blob:none"
    done
  '';
}
