{
  description = "A very basic flake";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      flake.nixosModules.systemd-bootloader = ./nixosModules/systemd-bootloader.nix;
      imports = [
        inputs.genesis-nix.flakeModules.compootuers
        inputs.treefmt-nix.flakeModule
        ./packages
      ];
      compootuers = {
        perSystem = ./perSystem;
        allSystems = ./allSystems;
      };
      perSystem.treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = true;
          deadnix.enable = true;
          statix.enable = true;
          dos2unix.enable = true;
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=master";
    nix = {
      url = "github:nixos/nix?ref=master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-23-11.follows = "nixpkgs";
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
      };
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disk-abstractions = {
      url = "github:mcsimw/disk-abstractions";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
        genesis-nix.follows = "genesis-nix";
      };
    };
    genesis-nix = {
      url = "github:mcsimw/genesis-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "flake-parts";
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
      };
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
      };
    };
    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };
}
