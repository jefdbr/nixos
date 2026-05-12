{ inputs, ... }:
{
  flake.nixosModules.zen =
    { pkgs, ... }:
    {
      home-manager.users.jeffrey = {
        imports = [ inputs.zen-browser.homeModules.beta ];

        programs.zen-browser = {
          enable = true;
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
          };

          profiles.default = {
            extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
              ublock-origin
              passff
              return-youtube-dislikes
            ];

            settings = {
              "browser.tabs.warnOnClose" = false;
            };
          };
        };
      };
    };
}
