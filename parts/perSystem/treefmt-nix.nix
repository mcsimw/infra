{
  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    settings.global.excludes = [
      ".envrc"
    ];
    programs = {
      nixfmt.enable = true;
      deadnix.enable = true;
      statix.enable = true;
      dos2unix.enable = true;
      stylua.enable = true;
      shfmt.enable = true;
      shellcheck.enable = true;
    };
  };
}
