{ ... }: {
  flake.nixosModules.nginx = { ... }: {
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;

      virtualHosts."localhost" = {
        listen = [
          { addr = "0.0.0.0"; port = 8080; }
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
  };
}
