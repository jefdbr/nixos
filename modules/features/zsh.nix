{ ... }:
{
  flake.nixosModules.zsh =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;
      home-manager.users.jeffrey = {
        home.packages = with pkgs; [
          zoxide
          eza
          bat
          fd
          ripgrep
          lazygit
          dust
          file
        ];
        programs.atuin = {
          enable = true;
          enableZshIntegration = false;
          settings = {
            auto_sync = false;
            update_check = false;
            style = "compact";
            dialect = "uk";
            search_mode = "fuzzy";
          };
        };
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          oh-my-zsh = {
            enable = true;
            theme = "eastwood-custom";
            custom = "${pkgs.writeTextDir "share/zsh/custom/themes/eastwood-custom.zsh-theme" (builtins.readFile ../../assets/eastwood-custom.zsh-theme)}/share/zsh/custom";
            plugins = [
              "ssh-agent"
              "zoxide"
            ];
            extraConfig = ''
              zstyle ':omz:update' mode disabled
              zstyle :omz:plugins:ssh-agent lazy yes
            '';
          };
          initContent = ''
            export EDITOR="emacsclient -nw"
            export VISUAL="emacsclient -nw"
            eval "$(atuin init zsh --disable-up-arrow --disable-ai)"

            if [[ -z "$INSIDE_EMACS" ]]; then
              source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
            fi
          '';
          shellAliases = {
            e = "emacsclient -nw";
            o = "xdg-open";
            ls = "eza --icons=always --group-directories-first";
            cat = "bat --style=plain --paging=never";
            lt = "eza --tree --icons=always";
            cd = "z";
            cdi = "zi";
            rebuild = "nh os switch";
            update = "nh os switch --update";
            clean = "nh clean all --keep 3 --no-gcroots";
          };
          history = {
            size = 10000;
            ignoreDups = true;
            share = true;
          };
        };
      };
    };
}
