{ lib, ... }:
{
  flake.nixosModules.home-manager =
    { ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
      };

      home-manager.users.jeffrey = {
        home = {
          stateVersion = "25.11";

          sessionVariables = {
            XDG_SESSION_TYPE = "wayland";
            EDITOR = lib.mkForce "emacsclient -nw";
            VISUAL = lib.mkForce "emacsclient -nw";
          };

          sessionPath = [
            "$HOME/.local/bin"
          ];

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
