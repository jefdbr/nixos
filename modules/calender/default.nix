{ ... }:
{
  # Required services for GNOME Calendar
  programs.dconf.enable = true;
  services.gnome.evolution-data-server.enable = true;

  # Needed for Nextcloud integration
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
