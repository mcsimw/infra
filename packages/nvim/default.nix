{
  symlinkJoin,
  neovim-unwrapped,
  makeWrapper,
  runCommandLocal,
  vimPlugins,
  lib,
}:
let
  packageName = "mypackage";

  startPlugins = [
    vimPlugins.telescope-nvim
    vimPlugins.modus-themes-nvim
    vimPlugins.nvim-treesitter.withAllGrammars
  ];

  foldPlugins = builtins.foldl' (
    acc: next:
    acc
    ++ [
      next
    ]
    ++ (foldPlugins (next.dependencies or [ ]))
  ) [ ];

  startPluginsWithDeps = lib.unique (foldPlugins startPlugins);

  packpath = runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/${packageName}/{start,opt}

    ${lib.concatMapStringsSep "\n" (
      plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}"
    ) startPluginsWithDeps}
  '';
in
symlinkJoin {
  name = "nvim";
  paths = [ neovim-unwrapped ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/nvim \
      --add-flags '-u' \
      --add-flags '${./init.lua}' \
      --add-flags '--cmd' \
      --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
      --set-default NVIM_APPNAME nvim
  '';

  passthru = {
    inherit packpath;
  };
}
