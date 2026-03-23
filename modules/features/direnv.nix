{ ... }: {
  flake.nixosModules.direnv = { ... }: {
    home-manager.users.jeffrey.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
