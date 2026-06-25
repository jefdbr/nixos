{ ... }: {
  flake.nixosModules.users = { pkgs, lib, ... }: {
    users.users.jeffrey = {
      isNormalUser = lib.mkForce true;
      description = "Jeffrey Debaere";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "media"
        "video"
        "render"
      ];
      shell = pkgs.zsh;
      group = "jeffrey";
      home = "/home/jeffrey";
    };

    users.groups.jeffrey = { };
  };
}
