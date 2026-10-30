{ config, user, ... }:
let
  home = config.users.users.${user}.home;

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
        "tcp://home-server:22000"
        "dynamic"
      ];
    };
  };

  allDevices = builtins.attrNames devices;
in
{
  services.syncthing = {
    enable = true;
    inherit user;
    group = config.users.users.${user}.group;
    dataDir = home;
    configDir = "${home}/.config/syncthing";
    openDefaultPorts = true;
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      inherit devices;
      options.relaysEnabled = true;

      folders = {
        uni = {
          path = "${home}/uni";
          devices = allDevices;
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "2592000";
            };
          };
        };

        wallpapers = {
          path = "${home}/Pictures/Wallpapers";
          devices = allDevices;
        };
      };
    };
  };

  home-manager.users.${user}.home.file."uni/.stignore".text = ''
    .#*
    #*#
    *~
    (?d).venv
    (?d)venv
    (?d).direnv
    (?d)__pycache__
    (?d)*.pyc
    (?d).ipynb_checkpoints
    (?d).pytest_cache
    (?d).mypy_cache
    (?d).ruff_cache
    (?d)node_modules
    target
  '';
}
