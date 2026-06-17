{ inputs, ... }:
{
  flake.nixosModules.desktop-config =
    { pkgs, ... }:
    {
      imports = [
        inputs.niri.nixosModules.niri
        inputs.noctalia-greeter.nixosModules.default
        inputs.hyprland.nixosModules.default
      ];
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      services = {
        getty.autologinUser = "jeffrey";
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
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
        ];
        config = {
          niri.default = "gnome";
          hyprland.default = "hyprland";
          common.default = "gnome";
        };
      };

      programs = {
        kdeconnect.enable = true;
        niri = {
          enable = true;
          package = pkgs.niri;
        };

        hyprland = {
          enable = true;
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        };

        gpu-screen-recorder.enable = true;
        #noctalia-greeter.enable = true;
      };

      home-manager.users.jeffrey =
        { config, ... }:
        {
          imports = [
            inputs.nix-index-database.homeModules.nix-index
          ];

          xdg.configFile."hypr/hyprland.lua".source =
            config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/hyprland.lua";

          xdg.configFile."niri/config.kdl".source =
            config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/niri.kdl";

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
          # programs.zsh.profileExtra = ''
          #   if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then exec niri-session -l; fi
          # '';

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
            libnotify
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
