{ inputs, ... }:
{
  flake.nixosModules.helium =
    { pkgs, ... }:
    {
      imports = [ inputs.helium-flake.nixosModules.default ];

      services.pcscd.enable = true;

      systemd.tmpfiles.rules = [
        "L+ /usr/lib/x86_64-linux-gnu/libbeidpkcs11.so.0 - - - - ${pkgs.eid-mw}/lib/pkcs11/beidpkcs11.so"
      ];

      environment.etc."chromium/native-messaging-hosts/eu.webeid.json".source =
        "${pkgs.web-eid-app}/share/web-eid/eu.webeid.json";

      programs.helium = {
        enable = true;
        flags = [
          "--ozone-platform-hint=auto"
          "--start-maximized"
        ];
        policies = {
          "PasswordManagerEnabled" = false;
          "ExtensionInstallForcelist" = [
            "ckibcdccnfeookdmbahgiakhnjcddpki" # Web eID extension ID for Chrome
          ];
        };
      };
    };
}
