{ pkgs, ... }:
{
  services.spice-vdagentd.enable = true;
  programs = {
    virt-manager.enable = true;
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = true; # prevents overriding
          settings = {
            "org/virt-manager/virt-manager/connections" = {
              autoconnect = ["qemu:///system"];
              uris = ["qemu:///system"];
            };
          };
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    virt-viewer
    spice-protocol
    spice-gtk
    win-virtio
    win-spice
  ];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
}
