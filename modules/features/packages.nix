{ inputs, ... }:
{
  flake.nixosModules.packages =
    { pkgs, ... }:
    {
      home-manager.users.jeffrey = {
        imports = [
          inputs.nix-index-database.hmModules.nix-index
        ];

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
          bat
          dust
          bitwarden-cli

          # Dev tooling
          nodejs
          typescript-language-server
          vscode-langservers-extracted
          clang-tools
          ruff
          pyright
          texlab
          nixd
          nil
          aider-chat

          # Wayland / desktop
          xdg-desktop-portal
          xdg-desktop-portal-gnome
          wayfreeze
          grim
          slurp
          swappy
          mpv
          fuzzel
          wl-clipboard
          seahorse
          wl-mirror
          spotify

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
            runtimeInputs = [
              fzf
              nix-search-tv
            ];
            text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
          })
        ];

        programs.fzf.enable = true;
        programs.vscode.enable = true;
        programs.nix-index-database.comma.enable = true;
      };
    };
}
