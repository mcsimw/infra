{
  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      nixfmt.enable = true;
      deadnix.enable = true;
      statix.enable = true;
      dos2unix.enable = true;
      stylua.enable = true;
    };
  };
}
