{ ... }: {
  flake.nixosModules.git = { ... }: {
    home-manager.users.jeffrey.programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Jeffrey Debaere";
          email = "jeffrey.debaere@ugent.be";
        };
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
  };
}
