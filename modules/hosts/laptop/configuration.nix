{ self, inputs, ... }:
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
      self.nixosModules.librewolf
      {
        networking.hostName = "laptop";
        system.stateVersion = "25.11";
        services.thermald.enable = true;
      }
    ];
  };
}
