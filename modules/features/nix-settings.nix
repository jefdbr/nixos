{ ... }:
{
  flake.nixosModules.nix-settings =
    { ... }:
    {
      nixpkgs.config.allowUnfree = true;

      nix.settings = {
        experimental-features = [
          "flakes"
          "nix-command"
        ];

        extra-substituters = [
          "https://nix-community.cachix.org"
          "https://noctalia.cachix.org"
          "https://attic.xuyh0120.win/lantian"
          "https://niri.cachix.org"
        ];

        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        ];
      };
    };
}
