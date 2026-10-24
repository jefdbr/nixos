{ user, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  home-manager.users.${user} = {
    home = {
      stateVersion = "25.11";

      sessionPath = [ "$HOME/.local/bin" ];
    };

    xdg.configFile."gtk-3.0/bookmarks".text = ''
      sftp://home-server home-server
      sftp://desaere desaere
    '';

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        "text/html" = "helium.desktop";
        "x-scheme-handler/http" = "helium.desktop";
        "x-scheme-handler/https" = "helium.desktop";
      };
    };

    fonts.fontconfig.enable = true;
  };
}
