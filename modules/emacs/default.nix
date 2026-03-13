{ pkgs, ... }:
{
  home-manager.users.jeffrey = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages =
        epkgs: with epkgs; [
          vterm
          treesit-grammars.with-all-grammars
        ];
    };

    home.packages = with pkgs; [
      cmake
      libtool
      gnumake
      # doom core
      binutils
      git
      ripgrep
      gnutls
      fd
      imagemagick
      zstd
      editorconfig-core-c
      sqlite
      # :lang nix
      nil
      nixd
      # :lang cc
      clang-tools
      # :lang python
      pyright
      # :lang latex
      texlive.combined.scheme-full
      # :checkers spell
      (aspellWithDicts (
        ds: with ds; [
          en
          nl
        ]
      ))
    ];

    home.sessionPath = [ "$home/.config/emacs/bin" ];
  };
}
