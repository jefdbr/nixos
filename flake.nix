{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Do not override its nixpkgs input, otherwise there can be mismatch between patches and kernel version
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            inputs.stylix.nixosModules.stylix
            ./machines/desktop
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                sharedModules = [
                  inputs.noctalia.homeModules.default
                  inputs.spicetify-nix.homeManagerModules.default
                ];
              };
            }
            ./modules/noctalia
            ./modules/boot
            ./modules/locale
            ./modules/networking
            ./modules/gaming
            ./modules/nix
            ./modules/core
            ./modules/packages
            ./modules/desktop-services
            ./modules/zsh
            ./modules/kitty
            ./modules/emacs
            ./modules/direnv
            ./modules/gpg
            ./modules/git
            ./modules/fastfetch
            ./modules/spicetify
            ./modules/theme
            ./modules/calender
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            inputs.stylix.nixosModules.stylix
            ./machines/laptop
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                sharedModules = [
                  inputs.noctalia.homeModules.default
                  inputs.spicetify-nix.homeManagerModules.default
                ];
              };
            }
            ./modules/noctalia
            ./modules/boot
            ./modules/locale
            ./modules/networking
            ./modules/nix
            ./modules/core
            ./modules/packages
            ./modules/desktop-services
            ./modules/zsh
            ./modules/kitty
            ./modules/emacs
            ./modules/direnv
            ./modules/gpg
            ./modules/git
            ./modules/fastfetch
            ./modules/spicetify
            ./modules/theme
          ];
        };
      };
    };
}
