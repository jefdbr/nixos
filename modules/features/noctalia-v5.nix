{ inputs, ... }:
{
  flake.nixosModules.noctalia-v5 =
    { pkgs, ... }:
    {
      home-manager.users.jeffrey.home.packages = [
        inputs.noctalia-v5.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
