{config, ...}: {
  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [config.services.tailscale.port];
      allowedTCPPorts = [80];
    };
  };

  systemd = {
    services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];
    network.wait-online.enable = false;
  };

  services.tailscale.enable = true;

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    virtualHosts."localhost" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 8080;
        }
      ];

      extraConfig = ''
        client_max_body_size 50M;
      '';

      locations."/media/" = {
        root = "/www";
        extraConfig = ''
          sendfile on;
          tcp_nopush on;
          sendfile_max_chunk 1m;
        '';
      };

      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
      };
    };
  };
}
