{ ... }:
{
  flake.nixosModules.librewolf =
    { pkgs, ... }:
    {
      home-manager.users.jeffrey = {
        programs.firefox = {
          enable = true;
          package = pkgs.librewolf;
          nativeMessagingHosts = [ pkgs.passff-host ];
          policies = {
            DontCheckDefaultBrowser = true;
            OfferToSaveLogins = false;
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };
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
            bookmarks = {
              force = true;
              settings = [
                {
                  name = "School";
                  bookmarks = [
                    {
                      name = "Mail school";
                      url = "https://outlook.office365.com/mail/";
                    }
                    {
                      name = "Oasis";
                      url = "https://oasis.ugent.be/oasis-web/inbox/home?0";
                    }
                  ];
                }
                {
                  name = "Framework";
                  url = "https://frame.work";
                }
              ];
            };
            settings = {
              "browser.tabs.warnOnClose" = false;
              "ui.systemUsesDarkTheme" = 1;
            };
          };
        };
      };
    };
}
