{ inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, ... }: {
    home-manager.users.jeffrey.programs.noctalia-shell = {
      enable = true;
      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        calendarSupport = true;
      };
      settings = {
        general = {
          telemetryEnabled = true;
          animationSpeed = 1.5;
        };
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
          showOutline = false;
          density = "comfortable";
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
                hideUnoccupied = true;
                showApplications = true;
                unfocusedIconsOpacity = 0.5;
                groupedBorderOpacity = 0;
              }
              { id = "MediaMini"; }
            ];
            center = [
              { id = "Clock"; formatHorizontal = "HH:mm ddd, MMM dd"; }
            ];
            right = [
              {
                id = "Tray";
                drawerEnabled = false;
                blacklist = [ "spotify-client" ];
              }
              {
                id = "plugin:privacy-indicator";
                defaultSettings = { hideInactive = false; };
              }
              { id = "Network"; }
              { id = "Battery"; hideIfNotDetected = true; }
              { id = "Volume"; }
              { id = "Brightness"; }
              { id = "NotificationHistory"; }
              { id = "ControlCenter"; useDistroLogo = true; }
            ];
          };
        };
        dock = { enabled = false; };
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
        plugins = { autoUpdate = true; };
        sessionMenu = { enableCountdown = false; };
        idle = {
          enabled = true;
          lockTimeout = 300;
          screenOffTimeout = 0;
          suspendTimeout = 0;
        };
        hooks = {
          enabled = true;
          startup = ''
            noctalia-shell ipc call location set $(curl -s ipinfo.io | jq -r ".city + \",\" + .country")
          '';
        };
        appLauncher = {
          enableClipboardHistory = true;
          terminalCommand = "kitty -e";
        };
      };
    };
  };
}
