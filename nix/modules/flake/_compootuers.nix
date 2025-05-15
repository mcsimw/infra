{ localFlake, ... }:
{
  config,
  lib,
  inputs,
  withSystem,
  self,
  ...
}:

let
  allowedSystems = [
    "aarch64-linux"
    "x86_64-linux"
  ];
  modulesPath = "${inputs.nixpkgs.outPath}/nixos/modules";
  pathOrNull = p: if p != null && builtins.pathExists p then builtins.toPath p else null;
  nixIfExists = dir: name: if dir == null then null else pathOrNull "${dir}/${name}.nix";
  perSystemPath = pathOrNull config.compootuers.perSystem;
  perArchPath = pathOrNull config.compootuers.perArch;
  allSystemsPath = pathOrNull config.compootuers.allSystems;
  maybeFile = path: if builtins.pathExists path then path else null;
  computedCompootuers =
    if perSystemPath == null then
      [ ]
    else
      builtins.concatLists (
        map (
          system:
          let
            dir = "${perSystemPath}/${system}";
          in
          if !builtins.pathExists dir then
            [ ]
          else
            let
              hostNames = builtins.attrNames (builtins.readDir dir);
            in
            map (hostName: {
              inherit system hostName;
              src = builtins.toPath "${dir}/${hostName}";
            }) hostNames
        ) allowedSystems
      );
  hasHosts = computedCompootuers != [ ];
  globalBothFile =
    if hasHosts && allSystemsPath != null then maybeFile "${allSystemsPath}/_both.nix" else null;
  globalDefaultFile =
    if hasHosts && allSystemsPath != null then maybeFile "${allSystemsPath}/_default.nix" else null;
  globalIsoFile =
    if hasHosts && allSystemsPath != null then maybeFile "${allSystemsPath}/_iso.nix" else null;
  configForSub =
    {
      sub,
      iso ? false,
    }:
    let
      inherit (sub) system src hostName;

      archBothFile = if perArchPath != null then nixIfExists "${perArchPath}/${system}" "_both" else null;
      archDefaultFile =
        if perArchPath != null then nixIfExists "${perArchPath}/${system}" "_default" else null;
      archIsoFile = if perArchPath != null then nixIfExists "${perArchPath}/${system}" "_iso" else null;
    in
    withSystem system (
      {
        config,
        inputs',
        self',
        system,
        ...
      }:
      let
        srcBothFile = nixIfExists src "_both";
        srcDefaultFile = nixIfExists src "_default";
        srcIsoFile = nixIfExists src "_iso";
        baseModules =
          [
            {
              networking.hostName = hostName;
              nixpkgs.pkgs = withSystem system ({ pkgs, ... }: pkgs);
            }
            localFlake.modules.nixos.sane
            localFlake.modules.nixos.nix-conf
          ]
          ++ lib.optional (globalBothFile != null) globalBothFile
          ++ lib.optional (archBothFile != null) archBothFile
          ++ lib.optional (srcBothFile != null) srcBothFile;
        nonIsoModules =
          [
            (
              { lib, config, ... }:
              {
                networking.hostId = lib.mkDefault (
                  builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName)
                );
              }
            )
          ]
          ++ lib.optional (globalDefaultFile != null) globalDefaultFile
          ++ lib.optional (archDefaultFile != null) archDefaultFile
          ++ lib.optional (srcDefaultFile != null) srcDefaultFile;
        isoModules =
          [
            (
              { lib, ... }:
              {
                imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-base.nix" ];
                boot.initrd.systemd.enable = lib.mkForce false;
                isoImage.squashfsCompression = "lz4";
                system.installer.channel.enable = lib.mkForce false;
                networking.wireless.enable = lib.mkForce false;
                systemd.targets = lib.genAttrs [ "sleep" "suspend" "hibernate" "hybrid-sleep" ] (_: {
                  enable = lib.mkForce false;
                });

                users.users.nixos = {
                  initialPassword = "iso";
                  initialHashedPassword = lib.mkForce null;
                  hashedPassword = lib.mkForce null;
                  password = lib.mkForce null;
                  hashedPasswordFile = lib.mkForce null;
                };

                networking.hostId = lib.mkForce (builtins.substring 0 8 (builtins.hashString "md5" hostName));
              }
            )
          ]
          ++ lib.optional (globalIsoFile != null) globalIsoFile
          ++ lib.optional (archIsoFile != null) archIsoFile
          ++ lib.optional (srcIsoFile != null) srcIsoFile;
        finalModules = baseModules ++ lib.optionals iso isoModules ++ lib.optionals (!iso) nonIsoModules;
      in
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit (config) packages;
          inherit
            inputs
            inputs'
            self'
            self
            system
            ;
        };
        modules = finalModules;
      }
    );
in
{
  options.compootuers = {
    perSystem = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Directory tree: <root>/<system>/<host>/_*.nix";
    };
    perArch = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Optional overrides per architecture: <root>/<system>/_both|_default|_iso.nix";
    };
    allSystems = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Optional global overrides applied to every host.";
    };
  };
  config = {
    flake.nixosConfigurations = builtins.listToAttrs (
      builtins.concatLists (
        map (
          sub:
          lib.optionals (sub.hostName != null) [
            {
              name = sub.hostName;
              value = configForSub {
                inherit sub;
                iso = false;
              };
            }
            {
              name = "${sub.hostName}-iso";
              value = configForSub {
                inherit sub;
                iso = true;
              };
            }
          ]
        ) computedCompootuers
      )
    );
    systems = lib.unique (map ({ system, ... }: system) computedCompootuers);
  };
}
