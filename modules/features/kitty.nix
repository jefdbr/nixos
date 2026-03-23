{ ... }: {
  flake.nixosModules.kitty = { ... }: {
    home-manager.users.jeffrey.programs.kitty = {
      enable = true;
      settings = {
        enable_audio_bell = false;
        window_padding_width = 5;
        hide_window_decorations = true;
        confirm_os_window_close = 0;
        shell = "zsh";
        scrollback_lines = 10000;
      };
    };
  };
}
