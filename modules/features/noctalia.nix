{ inputs, ... }:
{
  flake.nixosModules.noctalia =
    { pkgs, ... }:
    {
      home-manager.users.jeffrey.home.packages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
