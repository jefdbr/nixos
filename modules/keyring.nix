{ pkgs, user, ... }:
{
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  home-manager.users.${user}.home.packages = [ pkgs.seahorse ];
}
