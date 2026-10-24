{ lib, ... }:
{
  imports = [
    ./hardware.nix
    ../../modules

    # Turn fingerprint auth off by default for every PAM service.
    # Re-enable it per service, e.g. security.pam.services.sudo.fprintAuth = true;
    {
      options.security.pam.services = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.submodule {
            config.fprintAuth = lib.mkDefault false;
          }
        );
      };
    }
  ];

  networking.hostName = "laptop";
  system.stateVersion = "25.11";

  services.thermald.enable = true;
  services.fwupd.enable = true;
  services.fprintd.enable = true;
}
