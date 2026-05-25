{ ... }:
{
  flake.nixosModules.gpg =
    { pkgs, ... }:
    {
      home-manager.users.jeffrey = {
        home.packages = [ pkgs.gnupg ];
        programs.password-store = {
          enable = true;
          settings = {
            PASSWORD_STORE_DIR = "/home/jeffrey/.password-store";
          };
          package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
        };
      };
    };
}
