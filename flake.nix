{
  description = "MCSIMW's personal nix dotfiles";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { self, lib, ... }:
      {
        imports = [
          (lib.modules.importApply ./nix/flakeModules/default.nix { localFlake = self; })
          inputs.treefmt-nix.flakeModule
          inputs.vaultix.flakeModules.default
          inputs.home-manager.flakeModules.home-manager
          inputs.flake-parts.flakeModules.modules
          ./nix/nixosModules
          ./nix/homeModules
          ./nix/packages
        ];

        compootuers = {
          perSystem = ./nix/compootuers/perSystem;
          allSystems = ./nix/compootuers/allSystems;
        };

        flake.modules.flake = lib.modules.importApply ./nix/flakeModules/default.nix { localFlake = self; };

        perSystem =
          { system, pkgs, ... }:
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
                stylua.enable = true;
                shfmt.enable = true;
                clang-format.enable = true;
                shellcheck.enable = true;
              };
            };
          };
      }
    );

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    nix = {
      url = "github:nixos/nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-23-11.follows = "nixpkgs";
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
      };
    };

    home-manager = {
      url = "github:mcsimw/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation.url = "github:nix-community/preservation";

    mnw.url = "github:Gerg-L/mnw";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
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

    nixos-search = {
      url = "github:diamondburned/nix-search";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
