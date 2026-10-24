{ user, ... }:
{
  users.users.${user} = {
    isNormalUser = true;
    description = "Jeffrey Debaere";
    group = user;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "render"
      "vboxusers"
    ];
  };

  users.groups.${user} = { };
}
