{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    zip
    unzip
    docker-compose
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
    (firefox.override {nativeMessagingHosts = [passff-host];})
    nautilus
    trash-cli
    shfmt
    nixfmt
    multimarkdown
  ];

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
