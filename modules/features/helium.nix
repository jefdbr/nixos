{ inputs, ... }:
{
  flake.nixosModules.helium =
    { pkgs, ... }:
    {
      imports = [ inputs.helium-flake.nixosModules.default ];

      programs.helium = {
        enable = true;

        flags = [
          "--ozone-platform-hint=auto"
          "--start-maximized"
        ];

        policies = {
          "PasswordManagerEnabled" = false;
        };
      };
    };
}
