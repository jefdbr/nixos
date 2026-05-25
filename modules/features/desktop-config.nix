{ inputs, ... }:
{
  flake.nixosModules.desktop-config =
    { pkgs, ... }:
    {
      imports = [
        inputs.niri.nixosModules.niri
      ];
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      services = {
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
          wireplumber.enable = true;
        };
      };

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
        config.common.default = "gnome";
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
        imports = [
          inputs.nix-index-database.homeModules.nix-index
        ];

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
        programs.zsh.profileExtra = ''
          if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then exec niri-session -l; fi
        '';

        home.packages = with pkgs; [
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          swappy
          mpv
          fuzzel
          wl-clipboard
          wtype
          seahorse
          wl-mirror
          spotify
          vesktop
          (pkgs.writeShellApplication {
            name = "ns";
            runtimeInputs = [
              fzf
              nix-search-tv
            ];
            text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
          })
        ];
      };

      systemd.user.services.niri-flake-polkit.enable = false;
    };
}
