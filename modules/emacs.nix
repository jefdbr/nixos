{
  pkgs,
  user,
  ...
}:
{
  environment.variables = {
    EDITOR = "emacsclient -nw";
    VISUAL = "emacsclient -nw";
  };

  home-manager.users.${user} = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages = epkgs: with epkgs; [ vterm ];
    };

    services.emacs = {
      enable = true;
      client.enable = true;
      startWithUserSession = "graphical";
    };

    home.packages = with pkgs; [
      cmake
      gcc
      libtool
      gnumake
      binutils
      gnutls
      imagemagick
      zstd
      editorconfig-core-c
      sqlite
      vips
      ffmpegthumbnailer
      mediainfo
      p7zip
      texliveSmall
      (aspellWithDicts (
        ds: with ds; [
          en
          nl
        ]
      ))
      nodejs
      typescript-language-server
      vscode-langservers-extracted
      clang-tools
      ruff
      pyright
      texlab
      nixd
      nil
      tree-sitter
      shellcheck
      statix
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer
      gdb
    ];

    home.sessionPath = [ "$HOME/.config/emacs/bin" ];

    home.sessionVariables.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

    xdg.desktopEntries = {
      "emacs" = {
        name = "Emacs";
        noDisplay = true;
      };
      "emacsclient-mail" = {
        name = "Emacs (Client) Mail";
        noDisplay = true;
      };
      "emacs-mail" = {
        name = "Emacs Mail";
        noDisplay = true;
      };
    };
  };
}
