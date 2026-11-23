{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    luciole.url = "github:noctalia-dev/luciole/cachix";
    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter/cachix";
    umbriel.url = "github:noctalia-dev/umbriel/cachix";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      mkHost =
        name:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            user = "jeffrey";
          };
          modules = [ ./hosts/${name} ];
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost "desktop";
        laptop = mkHost "laptop";
      };
    };
}
