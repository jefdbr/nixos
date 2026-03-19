{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.mangohud ];

  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
