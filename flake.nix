{
  description = "A very basic flake";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }:
      {
        imports = [
          inputs.genesis-nix.flakeModules.compootuers
          inputs.treefmt-nix.flakeModule
          inputs.vaultix.flakeModules.default
          ./nixosModules
          ./packages
        ];

        compootuers = {
          perSystem = ./compootuers/perSystem;
          allSystems = ./compootuers/allSystems;
        };

        systems = ["aarch64-linux" "x86_64-linux"];

        perSystem =
          { system, ... }:
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;

              config.allowUnfree = true;

              overlays = [
                inputs.nix.overlays.default
                inputs.neovim-nightly-overlay.overlays.default
                inputs.emacs-overlay.overlays.default
                inputs.nixpkgs-wayland.overlays.default
                inputs.nyx.overlays.cache-friendly
              ];
            };

            treefmt = {
              projectRootFile = "flake.nix";

              programs = {
                nixfmt.enable = true;
                deadnix.enable = true;
                statix.enable = true;
                dos2unix.enable = true;
              };
            };
          };
      }
    );

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
    nyx = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.home-manager.follows = "";
    };
    vaultix = {
      url = "github:milieuim/vaultix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    dotfiles-legacy = {
      url = "github:mcsimw/.dotfiles-legacy";
      flake = false;
    };
    browser-previews.url = "github:nix-community/browser-previews";
    flake-firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "";
      };
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
      };
    };
    apple-emoji-linux = {
      url = "github:samuelngs/apple-emoji-linux";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "nixpkgs";
      };
    };
  };
}
