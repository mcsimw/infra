{
  config,
  lib,
  npinsLoader,
  ...
}:
let
  inherit (lib) genAttrs;
  inherit (builtins) mapAttrs;
  inherit (config) sources;
  callFlakeWithInputs =
    flakeSrc: overrideInputs:
    let
      flake = import (flakeSrc + "/flake.nix");
      outputs = flake.outputs (
        overrideInputs
        // {
          self = outputs // {
            outPath = flakeSrc;
            __toString = _: flakeSrc;
            inputs = overrideInputs;
          };
        }
      );
    in
    outputs;
  mkNvimPackages =
    system:
    let
      pkgs = config.nixpkgs.pkgs.${system};
      overlaySources = npinsLoader { input = ./overlay.json; };
      nixpkgsInput = {
        inherit lib;
        legacyPackages.${system} = pkgs;
        outPath = sources.nixpkgs;
        __toString = _: sources.nixpkgs;
      };
      flakePartsOutputs = callFlakeWithInputs sources.flake-parts {
        nixpkgs-lib = { inherit lib; };
      };
      fenixOutputs =
        callFlakeWithInputs sources.fenix {
          nixpkgs = nixpkgsInput;
          rust-analyzer-src = sources.rust-analyzer;
        }
        // {
          _type = "flake";
        };
      blinkCmpOutputs = callFlakeWithInputs overlaySources."blink.cmp" {
        nixpkgs = nixpkgsInput;
        flake-parts = flakePartsOutputs;
        fenix = fenixOutputs;
      };
      blink-cmp = blinkCmpOutputs.packages.${system}.blink-cmp;
      npinsToPlugins = input: npinsLoader { inherit input; } |> mapAttrs (_: src: src { inherit pkgs; });
      aliases = [
        "neovim"
        "vi"
        "vim"
        "v"
      ];
      nvim = (import sources.mnw).lib.wrap pkgs {
        extraBinPath = with pkgs; [
          lua-language-server
          nixfmt
          deadnix
          haskell-language-server
          ghc
          config.flake.packages.${pkgs.stdenv.hostPlatform.system}.statix
          nixd
          pkgs.kdePackages.qtdeclarative
          tinymist
          ormolu
          fzf
        ];
        initLua = ''
          LZN = require("lz.n")
          LZN.load("lzn")
        '';
        plugins.dev.mcismw.pure =
          let
            fs = lib.fileset;
          in
          fs.toSource {
            root = ./.;
            fileset = fs.unions [
              ./lua
              ./after
              ./plugin
            ];
          };
        inherit aliases;
        plugins = {
          startAttrs = ./start.json |> npinsToPlugins;
          optAttrs = ./opt.json |> npinsToPlugins;
          opt = [
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars
            pkgs.vimPlugins.nvim-treesitter-textobjects
            blink-cmp
          ];
        };
      };
    in
    genAttrs ([ "nvim" ] ++ aliases) (_: nvim);
in
{
  flake = {
    packages = genAttrs config.nixpkgs.systems mkNvimPackages;
    modules.nixos.maor =
      { pkgs, ... }:
      {
        users.users.mcsimw.packages = [ config.flake.packages.${pkgs.stdenv.hostPlatform.system}.neovim ];
      };
  };
  nixpkgs.overlays = [
    (import sources.neovim-nightly-overlay)
    (_final: prev: {
      vimPlugins = prev.vimPlugins.extend (
        _f: p: {
          nvim-treesitter-textobjects = p.nvim-treesitter-textobjects.overrideAttrs {
            dependencies = [ ];
          };
        }
      );
    })
  ];
}
