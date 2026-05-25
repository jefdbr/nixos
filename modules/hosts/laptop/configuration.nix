{ self, inputs, ... }:
{
  flake.nixosModules.laptopConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
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
      ];

      networking.hostName = "laptop";
      system.stateVersion = "25.11";

      services.power-profiles-daemon.enable = false;
      services.auto-cpufreq.enable = true;
      services.thermald.enable = true;
    };
}
