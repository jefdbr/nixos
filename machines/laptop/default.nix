{ ... }:
{
  imports = [
    ./hardware.nix
    ./users.nix
  ];

  networking.hostName = "laptop";
  system.stateVersion = "25.11";
}
