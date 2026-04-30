{ self, inputs, ... }:
{
  flake.nixosModules.laptopConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.laptopHardware
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
        inputs.clipboard-sync.nixosModules.default
        self.nixosModules.users
        self.nixosModules.home-manager
        self.nixosModules.nix-settings
        self.nixosModules.boot
        self.nixosModules.locale
        self.nixosModules.core
        self.nixosModules.desktop-services
        self.nixosModules.noctalia
        self.nixosModules.theme
        self.nixosModules.packages
        self.nixosModules.zsh
        self.nixosModules.kitty
        self.nixosModules.emacs
        self.nixosModules.direnv
        self.nixosModules.gpg
        self.nixosModules.git
        self.nixosModules.fastfetch
        self.nixosModules.spicetify
        self.nixosModules.networking
        self.nixosModules.calendar
      ];

      networking.hostName = "laptop";
      system.stateVersion = "25.11";
    };
}
