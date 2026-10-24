{ pkgs, user, ... }:
{
  home-manager.users.${user} =
    { config, ... }:
    {
      programs.gpg.enable = true;

      services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-gnome3;
      };

      programs.password-store = {
        enable = true;
        package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
        settings.PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      };
    };
}
