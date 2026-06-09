{ ... }:
{
  flake.nixosModules.librewolf =
    { pkgs, ... }:
    {
      # Eid shenanigans
      services.pcscd.enable = true;
      environment.systemPackages = [ pkgs.jdk ];
      systemd.tmpfiles.rules = [
        "L+ /usr/lib/x86_64-linux-gnu/libbeidpkcs11.so.0 - - - - ${pkgs.eid-mw}/lib/pkcs11/beidpkcs11.so"
        "L+ /usr/lib/x86_64-linux-gnu/libpcsclite.so.1 - - - - ${pkgs.pcsclite.lib}/lib/libpcsclite.so.1"
      ];

      home-manager.users.jeffrey = {
        programs.firefox = {
          enable = true;
          package = pkgs.librewolf;
          nativeMessagingHosts = [
            (pkgs.passff-host.override {
              pass = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
            })
            pkgs.web-eid-app
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
              "eu.webeid.web-eid-extension@web-eid.eu" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/web-eid/latest.xpi";
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
