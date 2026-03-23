{ ... }: {
  flake.nixosModules.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;

    home-manager.users.jeffrey.programs.zsh = {
      enable = true;
      enableCompletion = true;

      oh-my-zsh = {
        enable = true;
        theme = "eastwood-custom";
        custom = "${pkgs.writeTextDir "share/zsh/custom/themes/eastwood-custom.zsh-theme" (builtins.readFile ../../assets/eastwood-custom.zsh-theme)}/share/zsh/custom";
        plugins = [ "vi-mode" "ssh-agent" "zoxide" ];
        extraConfig = ''
          zstyle ':omz:update' mode disabled
          zstyle :omz:plugins:ssh-agent lazy yes
        '';
      };

      shellAliases = {
        o = "xdg-open";
        ls = "eza --icons=always";
        lt = "eza --tree --icons=always";
        cd = "z";
        cdi = "zi";
        dev = "nix develop --ignore-dirty";
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)";
        update = "sudo nix flake update --flake /etc/nixos";
        clean = "sudo nix-collect-garbage -d";
      };

      history = {
        size = 10000;
        ignoreDups = true;
      };

      profileExtra = ''
        if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then exec niri-session -l; fi
      '';
    };
  };
}
