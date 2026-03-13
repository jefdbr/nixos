{pkgs, ...}: {
  home-manager.users.jeffrey.programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        treesit-grammars.with-all-grammars
        lsp-mode
        lsp-ui
        auctex
        corfu
      ];
  };
}
