{ pkgs, lib, ... }:
{
  home-manager.users.jeffrey.programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "spacious";
        position = "top";
        widgets = {
          left = [
            {
              id = "Workspace";
              labelMode = "index";
              hideUnoccupied = false;
              showBadge = true;
            }
            {
              id = "MediaMini";
              maxWidth = 145;
              showAlbumArt = true;
              showProgressRing = true;
            }
          ];
          center = [
            {
              id = "Clock";
              formatHorizontal = "HH:mm ddd, MMM dd";
            }
          ];
          right = [
            {
              id = "Network";
              displayMode = "onhover";
            }
            { id = "Tray"; }
            {
              id = "Battery";
              displayMode = "graphic-clean";
              hideIfNotDetected = true;
            }
            {
              id = "Volume";
              displayMode = "onhover";
            }
            {
              id = "Brightness";
              displayMode = "onhover";
            }
            { id = "plugin:kde-connect"; }
            { id = "plugin:screen-recorder"; }
            { id = "plugin:tailscale"; }
            {
              id = "ControlCenter";
              icon = "noctalia";
            }
          ];
        };
      };
      dock = {
        enabled = true;
        displayMode = "auto_hide";
        position = "bottom";
      };
      location = {
        weatherEnabled = true;
        useFahrenheit = false;
        weatherShowEffects = false;
      };
      wallpaper = {
        enabled = true;
        directory = "/home/jeffrey/Pictures/Wallpapers";
        fillMode = "crop";
        transitionType = "random";
        transitionDuration = 1500;
        skipStartupTransition = true;
      };
      templates = {
        activeTemplates = [ ];
        enableUserTheming = false;
      };
      plugins = {
        autoUpdate = true;
      };
      sessionMenu = {
        enableCountdown = false;
      };
      idle = {
        enabled = true;
        lockTimeout = 300;
      };
      hooks = {
        enabled = true;
        startup = ''
          export loc=$(${lib.getExe pkgs.curl} -s ipinfo.io | ${lib.getExe pkgs.jq} -r ".city + \",\" + .country"); noctalia-shell ipc call location set $loc
        '';
      };
    };
  };
}
