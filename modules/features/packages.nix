{ ... }: {
  flake.nixosModules.packages = { pkgs, ... }: {
    home-manager.users.jeffrey = {
      home.packages = with pkgs; [
        # CLI tools
        file
        gcc
        tree-sitter
        statix
        zoxide
        lazygit
        eza
        ripgrep
        fd
        shellcheck

        # Dev tooling
        nodejs
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
        clang-tools
        ruff
        pyright
        texlab
        nixd
        nil
        claude-code

        # Wayland / desktop
        grim
        slurp
        swappy
        mpv
        fuzzel
        hyprpolkitagent
        wl-clip-persist
        wl-clipboard
        gnome-system-monitor
        seahorse

        # Qt / KDE
        kdePackages.qttools
        qt6Packages.qt6ct
        libsForQt5.qt5ct
        kdePackages.breeze
        qt6.qtdeclarative

        # Fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
        font-awesome
        noto-fonts-color-emoji
        symbola

        # Apps
        vesktop
        gnupg

        # Custom scripts
        (pkgs.writeShellApplication {
          name = "ns";
          runtimeInputs = [ fzf nix-search-tv ];
          text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
        })
      ];

      programs.fzf.enable = true;
      programs.vscode.enable = true;
    };
  };
}
