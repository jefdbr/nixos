{
  pkgs,
  ...
}:
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
  ];

  home-manager.users.jeffrey.programs.noctalia-shell.enable = true;
  virtualisation.docker.enable = true;

  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;

  services = {
    openssh.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
  };
}
