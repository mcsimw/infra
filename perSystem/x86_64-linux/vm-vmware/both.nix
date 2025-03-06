{ pkgs, lib, ... }:
{
   boot.kernelPackages = lib.mkOverride 99 pkgs.linuxPackages_cachyos-rc;
   services.scx = {
     enable = true;
     scheduler = "scx_bpfland";
   };
}
