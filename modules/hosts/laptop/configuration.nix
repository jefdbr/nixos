{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptopHardware
      inputs.stylix.nixosModules.stylix
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.users
      self.nixosModules.home-manager
      self.nixosModules.nix-settings
      self.nixosModules.boot
      self.nixosModules.locale
      self.nixosModules.core
      self.nixosModules.desktop-config
      self.nixosModules.theme
      self.nixosModules.zsh
      self.nixosModules.kitty
      self.nixosModules.emacs
      self.nixosModules.direnv
      self.nixosModules.gpg
      self.nixosModules.git
      self.nixosModules.fastfetch
      self.nixosModules.networking
      self.nixosModules.calendar
      self.nixosModules.helium
      {
        networking.hostName = "laptop";
        system.stateVersion = "25.11";
        services.thermald.enable = true;
        services.fwupd.enable = true;
        services.fprintd.enable = true;
      }
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
  };
}
