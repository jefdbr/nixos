{pkgs, ...}: {
  home-manager.users.jeffrey = {
    programs.password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "/home/jeffrey/.password-store";
      };
    };

    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-gnome3;
    };
  };
}
