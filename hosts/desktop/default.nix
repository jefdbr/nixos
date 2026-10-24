{ ... }:
{
  imports = [
    ./hardware.nix
    ../../modules
    ../../modules/gaming.nix
  ];

  networking.hostName = "desktop";
  system.stateVersion = "25.11";

  services.input-remapper.enable = true;
}
