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
  ];

  virtualisation.docker.enable = true;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  programs.nix-ld.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;
  services = {
    openssh.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
  };
}
