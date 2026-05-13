{ ... }:
{
  flake.nixosModules.librewolf =
    { pkgs, ... }:
    {
      home-manager.users.jeffrey = {
        programs.firefox = {
          enable = true;
          package = pkgs.librewolf;
          nativeMessagingHosts = [
            (pkgs.passff-host.override {
              pass = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
            })
          ];
          policies = {
            DontCheckDefaultBrowser = true;
            OfferToSaveLogins = false;
            ExtensionSettings = {
              "uBlock0@raymondhill.net" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                installation_mode = "force_installed";
              };
              "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
                installation_mode = "force_installed";
              };
              "sponsorBlocker@ajay.app" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
                installation_mode = "force_installed";
              };
              "passff@invicem.pro" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/passff/latest.xpi";
                installation_mode = "force_installed";
              };
            };
          };

          profiles.default = {
            isDefault = true;
            settings = {
              "browser.tabs.warnOnClose" = false;
              "privacy.sanitize.sanitizeOnShutdown" = false;
              "privacy.clearOnShutdown.cookies" = false;
              "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
            };
          };
        };
      };
    };
}
