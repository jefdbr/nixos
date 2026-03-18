{ pkgs, lib, ... }:
{
  home-manager.users.jeffrey.programs.noctalia-shell = {
    enable = true;
    settings = {
      controlCenter = {
        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
            { id = "WallpaperSelector"; }
            { id = "NoctaliaPerformance"; }
          ];
          right = [
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "plugin:kde-connect"; }
            { id = "plugin:screen-recorder"; }
          ];
        };
      };
      bar = {
        density = "spacious";
        position = "top";
        widgets = {
          left = [
            { id = "Workspace"; }
            { id = "MediaMini"; }
          ];
          center = [
            {
              id = "Clock";
              formatHorizontal = "HH:mm ddd, MMM dd";
            }
          ];
          right = [
            { id = "Tray"; }
            {
              id = "plugin:privacy-indicator";
              defaultSettings = {
                hideInactive = false;
              };
            }
            { id = "Network"; }
            {
              id = "Battery";
              hideIfNotDetected = true;
            }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "NotificationHistory"; }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      dock = {
        enabled = false;
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
        skipStartupTransition = true;
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
        screenOffTimeout = 0;
        suspendTimeout = 0;
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
