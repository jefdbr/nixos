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
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
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
                  inputs.lazyvim.homeManagerModules.default
                  inputs.spicetify-nix.homeManagerModules.default
                ];
              };
            }
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
            ./modules/neovim
            ./modules/emacs
            ./modules/direnv
            ./modules/gpg
            ./modules/git
            ./modules/fastfetch
            ./modules/spicetify
            ./modules/theme
          ];
        };

        # laptop = nixpkgs.lib.nixosSystem {
        #   specialArgs = {inherit inputs;};
        #   modules = [
        #     ./machines/laptop
        #     home-manager.nixosModules.home-manager
        #     { home-manager.useGlobalPkgs = true; home-manager.useUserPackages = true; }
        #     ./modules/boot
        #     # ... laptop-specific module list
        #   ];
        # };
      };
    };
}
