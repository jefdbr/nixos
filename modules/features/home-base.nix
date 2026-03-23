{ inputs, ... }: {
  flake.nixosModules.home-base = { ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      sharedModules = [
        inputs.noctalia.homeModules.default
        inputs.spicetify-nix.homeManagerModules.default
      ];
    };

    home-manager.users.jeffrey = {
      home = {
        stateVersion = "25.11";

        sessionVariables = {
          XDG_SESSION_TYPE = "wayland";
          EDITOR = "emacs";
          VISUAL = "emacs";
        };

        sessionPath = [ "$HOME/.config/emacs/bin" ];

        file.".config/gtk-3.0/bookmarks".text = ''
          sftp://home-server home-server
          sftp://desaere desaere
        '';
      };

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        };
      };

      fonts.fontconfig.enable = true;
    };
  };
}
