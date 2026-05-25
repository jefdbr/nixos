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

        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;

          oh-my-zsh = {
            enable = true;
            theme = "eastwood-custom";
            custom = "${pkgs.writeTextDir "share/zsh/custom/themes/eastwood-custom.zsh-theme" (builtins.readFile ../../assets/eastwood-custom.zsh-theme)}/share/zsh/custom";
            plugins = [
              "vi-mode"
              "ssh-agent"
              "zoxide"
            ];
            extraConfig = ''
              zstyle ':omz:update' mode disabled
              zstyle :omz:plugins:ssh-agent lazy yes
            '';
          };

          initContent = ''
            export EDITOR=vim
            export VISUAL=vim
          '';

          shellAliases = {
            o = "xdg-open";
            ls = "eza --icons=always --group-directories-first";
            lt = "eza --tree --icons=always";
            cat = "bat --style=plain --paging=never";
            cd = "z";
            cdi = "zi";
            rebuild = "nh os switch";
            update = "nh os switch --update";
            clean = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3 && sudo nix-collect-garbage && nix-collect-garbage -d && nix store optimise";
          };

          history = {
            size = 10000;
            ignoreDups = true;
          };
        };
      };
    };
}
