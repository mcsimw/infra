{ self, config, ... }:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];
  environment = {
    variables = {
      DOTFILES = "/mnt/nyx/.dotfiles";
    };
    shellAliases = {
      switch = "nixos-rebuild switch --flake ${config.environment.variables.DOTFILES}#${config.networking.hostName} --show-trace --verbose --sudo";
      boot = "nixos-rebuild boot --flake ${config.environment.variables.DOTFILES}#${config.networking.hostName} --show-trace --verbose --sudo";
    };
  };
}
