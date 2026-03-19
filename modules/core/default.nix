{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    zip
    unzip
    docker-compose
    xwayland-satellite
    (firefox.override { nativeMessagingHosts = [ passff-host ]; })
    nautilus
    trash-cli
    shfmt
    nixfmt
    multimarkdown
    jq
    python3
  ];

  virtualisation.docker.enable = true;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  programs.nix-ld.enable = true;
  nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
  ];

  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  security.pam.services.login.enableGnomeKeyring = true;
  services = {
    openssh.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
  };
}
