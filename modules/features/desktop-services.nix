{ inputs, ... }:
{
  flake.nixosModules.desktop-services =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.nixosModules.niri ];
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      environment.systemPackages = [ pkgs.ddcutil ];
      hardware.i2c.enable = true;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
        config.common.default = "gnome";
      };

      programs = {
        kdeconnect.enable = true;
        niri = {
          enable = true;
          package = pkgs.niri;
        };
        gpu-screen-recorder.enable = true;
      };

      home-manager.users.jeffrey = {
        programs.niri.config = null;
        stylix.targets.niri.enable = false;
        systemd.user.startServices = "sd-switch";
      };

      systemd.user.services.niri-flake-polkit.enable = false;
    };
}
