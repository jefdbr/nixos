{ ... }:
{
  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  systemd = {
    services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];
    services.NetworkManager-wait-online.enable = false;
    network.wait-online.enable = false;
  };
}
