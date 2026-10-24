# Everything both machines share. Host-specific extras (like gaming.nix)
# are imported from hosts/<name>/default.nix instead.
{ inputs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.home-manager.nixosModules.home-manager

    ./users.nix
    ./home-manager.nix
    ./nix-settings.nix
    ./boot.nix
    ./locale.nix
    ./core.nix
    ./desktop.nix
    ./keyring.nix
    ./theme.nix
    ./zsh.nix
    ./kitty.nix
    ./emacs.nix
    ./direnv.nix
    ./gpg.nix
    ./git.nix
    ./fastfetch.nix
    ./networking.nix
    ./calendar.nix
    ./helium.nix
    ./syncthing.nix
  ];
}
