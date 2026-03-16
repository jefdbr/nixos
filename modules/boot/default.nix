{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.systemd.network.wait-online.enable = false;
  };
}
