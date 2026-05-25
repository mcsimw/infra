{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    kakoune = {
      url = "github:mawww/kakoune";
      flake = false;
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      flake = false;
    };
    statix = {
      url = "github:molybdenumsoftware/statix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      flake = false;
    };
    nixos-facter-modules = {
      url = "github:nix-community/nixos-facter-modules";
      flake = false;
    };
    hjem = {
      url = "github:feel-co/hjem";
      flake = false;
    };
    smfh = {
      url = "github:feel-co/smfh";
      flake = false;
    };
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      flake = false;
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?ref=master";
      flake = false;
    };
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel";
      flake = false;
    };
  };
  outputs = inputs: (import ./nix/_eval.nix inputs).flake;
}
