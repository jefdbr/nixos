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
            {
              id = "Workspace";
              focusedColor = "primary";
              occupiedColor = "none";
              emptyColor = "none";
              pillSize = 0.4;
              labelMode = "none";
            }
            { id = "MediaMini"; }
          ];
          center = [
            {
              id = "Clock";
              formatHorizontal = "HH:mm ddd, MMM dd";
            }
          ];
          right = [
            {
              id = "Tray";
              drawerEnabled = false;
            }
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
        startup =
          let
            where-am-i = "${pkgs.geoclue2}/libexec/geoclue-2.0/demos/where-am-i";
          in
          ''
            loc=$(curl -s ipinfo.io | jq -r '.city + "," + .country')
            noctalia-shell ipc call location set "$loc"

            coords=$(${where-am-i} -t 10 2>/dev/null | grep -oP '[\d.]+' | head -2 | paste -sd,)
            if [ -n "$coords" ]; then
              lat=$(echo "$coords" | cut -d',' -f1)
              lon=$(echo "$coords" | cut -d',' -f2)
              loc=$(curl -s "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json" | jq -r '(.address.village // .address.town // .address.city) + "," + .address.country')
              noctalia-shell ipc call location set "$loc"
            fi
          '';
      };
    };
  };
}
