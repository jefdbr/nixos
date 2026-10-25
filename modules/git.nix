{ user, ... }:
{
  home-manager.users.${user}.programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Jeffrey Debaere";
        email = "jeffreydebaere19@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
