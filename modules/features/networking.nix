{ ... }: {
  flake.nixosModules.networking = { config, ... }: {
    networking = {
      networkmanager.enable = true;
      nftables.enable = true;
      firewall = {
        enable = true;
        trustedInterfaces = [ "tailscale0" ];
        allowedUDPPorts = [ config.services.tailscale.port ];
        allowedTCPPorts = [ 8080 ];
      };
    };

    systemd = {
      services.tailscaled.serviceConfig.Environment = [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];
      services.NetworkManager-wait-online.enable = false;
      network.wait-online.enable = false;
    };

    services.tailscale.enable = true;
  };
}
