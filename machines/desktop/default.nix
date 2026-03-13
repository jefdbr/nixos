{...}: {
  imports = [
    ./hardware.nix
    ./users.nix
  ];

  networking.hostName = "desktop";
  system.stateVersion = "25.11";
  services.getty.autologinUser = "jeffrey";
}
