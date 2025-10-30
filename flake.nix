{
  description = "MCSIMW's personal nix dotfiles";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      flake.compootuers = {
        perSystem = ./perSystem;
        allSystems = ./allSystems;
        perArch = ./perArch;
      };
      perSystem =
        { system, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = with inputs; [
              nixpkgs-wayland.overlay
              chaotic.overlays.cache-friendly
              emacs-overlay.overlays.default
              #nix.overlays.default
            ];
          };
          treefmt = {
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
        };
      imports = with inputs; [
        (import-tree ./packages)
        compootuers.flakeModule
        treefmt-nix.flakeModule
      ];
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    elephant = {
      url = "github:abenz1267/elephant";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    compootuers.url = "github:mcsimw/compootuers";

    nix = {
      url = "github:nixos/nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        git-hooks-nix.follows = "";
        flake-parts.follows = "";
        flake-compat.follows = "";
        nixpkgs-regression.follows = "";
      };
    };

    emoji-picker-nix.url = "github:mcsimw/emoji-picker-nix";

    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    flake-firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        lib-aggregate.follows = "lib-aggregate";
        flake-compat.follows = "";
      };
    };

    nvim.url = "github:mcsimw/nvim";

    kakoune = {
      url = "github:mawww/kakoune";
      flake = false;
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "";
      };
    };

    niri = {
      url = "github:YaLTeR/niri";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
    };

    tmux = {
      url = "github:tmux/tmux";
      flake = false;
    };

    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        rust-overlay.follows = "rust-overlay";
      };
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs = {
        lib-aggregate.follows = "lib-aggregate";
        nixpkgs.follows = "";
        flake-compat.follows = "";
      };
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "";
        rust-overlay.follows = "rust-overlay";
        flake-schemas.follows = "";
        jovian.follows = "";
      };
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hjem.follows = "hjem";
      };
    };

    wrappers.url = "github:lassulus/wrappers";

    apple-emoji-linux = {
      url = "github:samuelngs/apple-emoji-linux";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "";
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

    lib-aggregate = {
      url = "github:nix-community/lib-aggregate";
      inputs = {
        nixpkgs-lib.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    flake-utils.url = "github:numtide/flake-utils";

    walker = {
      url = "github:abenz1267/walker";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        elephant.follows = "elephant";
      };
    };
  };

}
