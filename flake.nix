{
  description = "MCSIMW's personal nix dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix = {
      url = "github:nixos/nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-23-11.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
        git-hooks-nix.follows = "git-hooks";
      };
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
      };
    };
    niri = {
      url = "github:YaLTeR/niri";
      inputs = {
        #    nixpkgs.follows = "nixpkgs";
        #rust-overlay.follows = "rust-overlay";
      };
    };
    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
        flake-utils.follows = "flake-utils";
      };
    };
    xlibre-overlay = {
      url = "git+https://codeberg.org/takagemacoed/xlibre-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    nyx = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "";
      };
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        lib-aggregate.follows = "lib-aggregate";
      };
    };
    typst = {
      url = "github:typst/typst";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        fenix.follows = "fenix";
        systems.follows = "systems";
        crane.follows = "crane";
      };
    };
    systems.url = "github:nix-systems/default";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nix-maid.url = "github:viperML/nix-maid";
    wrapper-manager.url = "github:viperML/wrapper-manager";
    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    flake-firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        lib-aggregate.follows = "lib-aggregate";
      };
    };
    mnw.url = "github:Gerg-L/mnw";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
        git-hooks.follows = "git-hooks";
      };
    };
    blink-cmp = {
      url = "github:Saghen/blink.cmp";
      inputs = {
        flake-parts.follows = "flake-parts";
        fenix.follows = "fenix";
      };
    };
    kakoune = {
      url = "github:mawww/kakoune";
      flake = false;
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
      };
    };
    apple-emoji-linux = {
      url = "github:samuelngs/apple-emoji-linux";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    preservation.url = "github:nix-community/preservation";
    rust-analyzer-src = {
      url = "github:rust-lang/rust-analyzer/nightly";
      flake = false;
    };
    crane.url = "github:ipetkov/crane";
    fenix = {
      url = "github:nix-community/fenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-analyzer-src.follows = "rust-analyzer-src";
      };
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lib-aggregate = {
      url = "github:nix-community/lib-aggregate";
      inputs = {
        nixpkgs-lib.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ (inputs.import-tree ./nix) ];
    };
}
