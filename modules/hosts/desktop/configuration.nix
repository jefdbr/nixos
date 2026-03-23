{ self, inputs, ... }: {
  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }: {
    imports = [
      # Hardware
      self.nixosModules.desktopHardware

      # External module inputs
      inputs.stylix.nixosModules.stylix
      inputs.home-manager.nixosModules.home-manager

      # Shared base
      self.nixosModules.users
      self.nixosModules.home-base
      self.nixosModules.nix-settings
      self.nixosModules.boot
      self.nixosModules.locale
      self.nixosModules.core

      # Desktop / Wayland
      self.nixosModules.desktop-services
      self.nixosModules.noctalia
      self.nixosModules.theme

      # Apps & tools
      self.nixosModules.packages
      self.nixosModules.zsh
      self.nixosModules.kitty
      self.nixosModules.emacs
      self.nixosModules.direnv
      self.nixosModules.gpg
      self.nixosModules.git
      self.nixosModules.fastfetch
      self.nixosModules.spicetify

      # Services
      self.nixosModules.networking
      self.nixosModules.nginx
      self.nixosModules.calendar

      # Desktop-only
      self.nixosModules.gaming
    ];

    networking.hostName = "desktop";
    system.stateVersion = "25.11";
    services.getty.autologinUser = "jeffrey";
  };
}
