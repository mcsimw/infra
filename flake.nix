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
      };
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nix-maid.url = "github:viperML/nix-maid";
    flake-compat.url = "github:edolstra/flake-compat";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    preservation.url = "github:nix-community/preservation";
    wrapper-manager.url = "github:viperML/wrapper-manager";
    nyx = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.home-manager.follows = "";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };
    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
        crane.follows = "crane";
      };
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
    mnw.url = "github:Gerg-L/mnw";
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
    nixos-search = {
      url = "github:diamondburned/nix-search";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };
    alsa-ucm-conf = {
      url = "github:geoffreybennett/alsa-ucm-conf";
      flake = false;
    };
    systems.url = "github:nix-systems/default";
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
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    nix-filter.url = "github:numtide/nix-filter";
    dwl = {
      flake = false;
      url = "git+https://codeberg.org/dwl/dwl?ref=main";
    };
    blink-cmp = {
      url = "github:Saghen/blink.cmp";
      inputs = {
        flake-parts.follows = "flake-parts";
        fenix.follows = "fenix";
      };
    };
    nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
        nixpkgs-25_05.follows = "";
      };
    };
    center = {
      url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/alwayscenter/alwayscenter.patch";
      flake = false;
    };
    smartborders = {
      flake = false;
      url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/smartborders/smartborders.patch";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ (inputs.import-tree ./nix) ];
    };
}
