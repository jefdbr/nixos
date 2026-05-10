{ ... }:
{
  flake.nixosModules.git =
    { ... }:
    {
      home-manager.users.jeffrey.programs.git = {
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
    };
}
