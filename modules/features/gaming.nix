{ ... }: {
  flake.nixosModules.gaming = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.mangohud
      pkgs.polychromatic
    ];

    services.scx = {
      enable = true;
      scheduler = "scx_lavd";
    };

    hardware.openrazer = {
      enable = true;
      users = [ "jeffrey" ];
    };

    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };
    };
  };
}
