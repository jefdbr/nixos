{ user, ... }:
{
  home-manager.users.${user}.programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Jeffrey Debaere";
        email = "jeffreydebaere@proton.me";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
