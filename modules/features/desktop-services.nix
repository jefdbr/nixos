{ inputs, ... }:
{
  flake.nixosModules.desktop-services =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.nixosModules.niri ];
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      services.clipboard-sync.enable = true;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      programs = {
        kdeconnect.enable = true;
        niri = {
          enable = true;
          package = pkgs.niri;
        };
        gpu-screen-recorder.enable = true;
      };

      home-manager.users.jeffrey = {
        programs.niri.config = null;
        stylix.targets.niri.enable = false;
      };

      home-manager.users.jeffrey.systemd.user = {
        startServices = "sd-switch";
        services = {
          hyprpolkitagent = {
            Unit = {
              Description = "Hypr Polkit authentication agent";
              Wants = [ "graphical-session.target" ];
              After = [ "graphical-session.target" ];
            };
            Install.WantedBy = [ "graphical-session.target" ];
            Service = {
              Type = "simple";
              ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
              Restart = "on-failure";
            };
          };

          wl-clip-persist = {
            Unit = {
              Description = "Persist Wayland clipboard after app closes";
              After = [ "graphical-session.target" ];
              PartOf = [ "graphical-session.target" ];
            };
            Install.WantedBy = [ "graphical-session.target" ];
            Service = {
              ExecStart = "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both";
              Restart = "always";
            };
          };
        };
      };
    };
}
