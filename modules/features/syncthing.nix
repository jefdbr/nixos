{ ... }:
{
  flake.nixosModules.syncthing =
    { ... }:
    let
      devices = {
        laptop = {
          id = "FQVBPMU-FTQSOOO-GZ7REY4-6TQ3IYA-AYXDLVK-OKUDC66-5JO6YEN-2UL53QW";
          addresses = [ "dynamic" ];
        };
        desktop = {
          id = "RWS25GM-HKELPNQ-VKLENCO-VUC5FCZ-PI4VVOV-ADEP3I3-SG4DM35-EDEEXQK";
          addresses = [ "dynamic" ];
        };
        home-server = {
          id = "MI4YDN7-YB4WBEU-VX5GL37-6ORZLMJ-Q73GK66-FOU7GQJ-X5OSP6L-A5KESAK";
          addresses = [
            "tcp://homeserver:22000"
            "dynamic"
          ];
        };
      };
    in
    {
      services.syncthing = {
        enable = true;
        user = "jeffrey";
        group = "jeffrey";
        dataDir = "/home/jeffrey";
        configDir = "/home/jeffrey/.config/syncthing";
        openDefaultPorts = true;
        overrideDevices = true;
        overrideFolders = true;

        settings = {
          inherit devices;
          options.relaysEnabled = true;

          folders.uni = {
            path = "/home/jeffrey/uni";
            devices = [
              "laptop"
              "desktop"
              "home-server"
            ];
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600";
                maxAge = "2592000";
              };
            };
          };
        };
      };

      # Keep Emacs lock/backup/autosave files out of the sync
      home-manager.users.jeffrey.home.file."uni/.stignore".text = ''
        .#*
        #*#
        *~
      '';
    };
}
