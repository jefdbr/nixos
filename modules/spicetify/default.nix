{
  pkgs,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  home-manager.users.jeffrey = {
    stylix.targets.spicetify.enable = false;
    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.default;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
      ];
    };
  };
}
