{pkgs, ...}: {
  home-manager.users.jeffrey = {
    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 12;
      gtk.enable = true;
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };

    xdg.configFile."kdeglobals".text = ''
      [Colors:Button]
      BackgroundNormal=#242424
      ForegroundNormal=#ffffff

      [Colors:View]
      BackgroundNormal=#1e1e1e
      ForegroundNormal=#ffffff

      [Colors:Window]
      BackgroundNormal=#242424
      ForegroundNormal=#ffffff

      [Colors:Selection]
      BackgroundNormal=#3584e4
      ForegroundNormal=#ffffff

      [General]
      ColorScheme=Noctalia
    '';

    programs.noctalia-shell.enable = true;
  };
}
