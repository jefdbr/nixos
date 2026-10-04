{ inputs, ... }:
{
  flake.nixosModules.desktop-config =
    { pkgs, ... }:
    {
      imports = [
        inputs.niri.nixosModules.niri
        inputs.noctalia-greeter.nixosModules.default
        inputs.umbriel.nixosModules.default
      ];
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      services = {
        displayManager.noctalia-greeter = {
          enable = true;
          passwordless-sync-users = [ "jeffrey" ];
          cursorTheme.package = pkgs.bibata-cursors;
          settings = {
            user.default = "jeffrey";
            cursor = {
              theme = "Bibata-Modern-Ice";
              size = 24;
            };
          };
        };
        printing.enable = true;
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
        scx = {
          enable = true;
          scheduler = "scx_lavd";
        };
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          wireplumber = {
            enable = true;
            extraConfig."90-prevent-helium-mic-adjust" = {
              "access.rules" = [
                {
                  matches = [ { "application.process.binary" = "helium"; } ];
                  actions = {
                    update-props = {
                      "default_permissions" = "rx";
                    };
                  };
                }
              ];
            };
          };
        };
      };

      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
        ];
      };

      programs = {
        dconf.enable = true;
        kdeconnect.enable = true;
        niri = {
          enable = true;
          package = pkgs.niri;
        };

        umbriel.enable = true;

        gpu-screen-recorder.enable = true;
      };

      home-manager.users.jeffrey =
        { config, ... }:
        {
          imports = [
            inputs.nix-index-database.homeModules.nix-index
          ];

          xdg.configFile."niri/config.kdl".source =
            config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/niri.kdl";

          xdg.configFile."umbriel/config.toml".source =
            config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/umbriel.toml";

          services.gpg-agent = {
            enable = true;
            pinentry.package = pkgs.pinentry-gnome3;
          };

          programs = {
            vscode.enable = true;
            fzf.enable = true;
            nix-index-database.comma.enable = true;
            niri.config = null;
          };

          stylix.targets.niri.enable = false;
          systemd.user.startServices = "sd-switch";

          home.packages = with pkgs; [
            inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
            bitwarden-cli
            bitwarden-desktop
            swappy
            mpv
            wl-clipboard
            wl-mirror
            wtype
            seahorse
            spotify
            libnotify
          ];
        };

      systemd.user.services.niri-flake-polkit.enable = false;
    };
}
