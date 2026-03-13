{pkgs, ...}: {
  home-manager.users.jeffrey.programs.lazyvim = {
    enable = true;
    configFiles = ../../assets/nvim;
    extras = {
      dap.core.enable = true;
      lang = {
        nix.enable = true;
        python = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
        clangd = {
          enable = true;
          installDependencies = true;
        };
        typescript = {
          enable = true;
          installDependencies = true;
        };
        tailwind.enable = true;
        prisma.enable = true;
        json.enable = true;
      };
    };
    extraPackages = with pkgs; [
      alejandra
      bash-language-server
      vscode-langservers-extracted
      stylua
      lua-language-server
      vtsls
      nodePackages."@tailwindcss/language-server"
      pyright
      eslint_d
      python312Packages.debugpy
    ];
  };
}
