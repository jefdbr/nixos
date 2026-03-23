{ pkgs, ... }:
{
  home-manager.users.jeffrey = {
    home.packages = with pkgs; [
      file
      gcc
      tree-sitter
      statix
      kdePackages.qttools
      zoxide
      nerd-fonts.jetbrains-mono
      font-awesome
      vesktop
      lazygit
      nodejs
      grim
      slurp
      swappy
      mpv
      fuzzel
      gnome-system-monitor
      hyprpolkitagent
      gnupg
      eza
      qt6Packages.qt6ct
      libsForQt5.qt5ct
      kdePackages.breeze
      wl-clip-persist
      wl-clipboard
      ripgrep
      fd
      shellcheck
      noto-fonts-color-emoji
      nerd-fonts.symbols-only
      symbola
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      clang-tools
      ruff
      pyright
      texlab
      nixd
      nil
      seahorse
      qt6.qtdeclarative
      (pkgs.writeShellApplication {
        name = "ns";
        runtimeInputs = [
          fzf
          nix-search-tv
        ];
        text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
      })
      claude-code
    ];

    programs.fzf.enable = true;
    programs.vscode = {
      enable = true;
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      };
    };

    home = {
      stateVersion = "25.11";

      sessionVariables = {
        XDG_SESSION_TYPE = "wayland";
        EDITOR = "emacs";
        VISUAL = "emacs";
      };

      sessionPath = [ "$HOME/.config/emacs/bin" ];

      file = {
        ".config/gtk-3.0/bookmarks".text = ''
          sftp://home-server home-server
          sftp://desaere desaere
        '';
      };
    };

    fonts.fontconfig.enable = true;
  };
}
