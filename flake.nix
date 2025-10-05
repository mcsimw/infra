{
  description = "MCSIMW's personal nix dotfiles";

  inputs = {
    compootuers = {
      url = "github:mcsimw/compootuers";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    nixpkgs.url = "github:nixos/nixpkgs";
    nix = {
      url = "github:nixos/nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "";
        nixpkgs-23-11.follows = "";
        flake-compat.follows = "";
        git-hooks-nix.follows = "";
      };
    };
    tmux = {
      url = "github:tmux/tmux";
      flake = false;
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrapper-manager.url = "github:viperML/wrapper-manager";
    kakoune = {
      url = "github:mawww/kakoune";
      flake = false;
    };
    apple-emoji-linux = {
      url = "github:samuelngs/apple-emoji-linux";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    preservation.url = "github:nix-community/preservation";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } { imports = [ (inputs.import-tree ./parts) ]; };
}
