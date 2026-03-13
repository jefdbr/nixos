{...}: {
  home-manager.users.jeffrey.programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Nerd Font Mono";
      size = 13;
    };

    settings = {
      enable_audio_bell = false;
      window_padding_width = 5;
      hide_window_decorations = true;
      confirm_os_window_close = 0;
      shell = "zsh";
      scrollback_lines = 10000;
    };

    extraConfig = ''
      include ~/.config/kitty/themes/noctalia.conf
      selection_background #3a3a5a
    '';
  };
}
