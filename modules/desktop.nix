{
  config,
  pkgs,
  inputs,
  user,
  ...
}:
let
  flakeDir = config.programs.nh.flake;
in
{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
    inputs.umbriel.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    nautilus
  ];

  hardware.opentabletdriver.enable = true;

  services = {
    keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(nav, capslock)";
          };
          nav = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          };
        };
      };
    };

    displayManager.noctalia-greeter = {
      enable = true;
      passwordless-sync-users = [ user ];
      settings = {
        user.default = user;
        appearance = {
          scheme_selector_position = "hidden";
          hide_logo = true;
        };
        cursor = {
          path = pkgs.bibata-cursors;
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
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      extraConfig.pipewire."99-disable-x11-bell" = {
        "context.properties" = {
          "module.x11.bell" = false;
        };
      };
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
      inputs.luciole.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "luciole"
        "gtk"
      ];
    };
  };

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
    umbriel.enable = true;
    gpu-screen-recorder.enable = true;
  };

  home-manager.users.${user} =
    { config, ... }:
    {
      imports = [
        inputs.nix-index-database.homeModules.nix-index
        inputs.luciole.homeModules.default
      ];

      xdg.configFile."umbriel/config.toml".source =
        config.lib.file.mkOutOfStoreSymlink "${flakeDir}/assets/umbriel.toml";

      programs = {
        rbw = {
          enable = true;
          settings = {
            email = "jeffreydebaere19@gmail.com";
            base_url = "https://home-server.tailf8334c.ts.net:1052/";
            pinentry = pkgs.pinentry-gnome3;
            lock_timeout = 3600;
          };
        };
        vscode.enable = true;
        fzf.enable = true;
        nix-index-database.comma.enable = true;
        luciole = {
          enable = true;
          settings = {
            browser = {
              view_mode = "grid";
              show_hidden = false;
            };
          };
        };
      };

      systemd.user.startServices = "sd-switch";

      home.packages = with pkgs; [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        swappy
        mpv
        wl-clipboard
        wl-mirror
        wtype
        spotify
        libnotify
        krita
        xournalpp
        rnote
      ];
    };
}
