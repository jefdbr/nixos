{ ... }:
{
  imports = [
    ./hardware.nix
    ../../modules
    ../../modules/gaming.nix
    ../../modules/open-webui.nix
  ];

  networking.hostName = "desktop";
  system.stateVersion = "25.11";

  services.fwupd.enable = true;
  services.input-remapper.enable = true;
}
