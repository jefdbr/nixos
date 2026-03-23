{ ... }: {
  flake.nixosModules.theme = { pkgs, config, ... }:
  let
    c = config.lib.stylix.colors;
    hexToRgb = hex:
      let
        r = builtins.substring 0 2 hex;
        g = builtins.substring 2 2 hex;
        b = builtins.substring 4 2 hex;
        toInt = s: builtins.fromTOML "v = 0x${s}";
      in
      "${toString (toInt r).v},${toString (toInt g).v},${toString (toInt b).v}";
  in
  {
    stylix = {
      enable = true;

      base16Scheme = {
        base00 = "1e1e1e";
        base01 = "2b2b2b";
        base02 = "4a4a4a";
        base03 = "5e5e5e";
        base04 = "b0b0b0";
        base05 = "e0e0e0";
        base06 = "f0f0f0";
        base07 = "ffffff";
        base08 = "ed333b";
        base09 = "e5a50a";
        base0A = "f6d32d";
        base0B = "26a269";
        base0C = "2ec4b6";
        base0D = "3584e4";
        base0E = "9141ac";
        base0F = "1b467c";
      };

      cursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };

      icons = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.inter;
          name = "Inter";
        };
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        sizes = {
          applications = 11;
          terminal = 12;
        };
      };
    };

    # KDE color config
    home-manager.users.jeffrey.xdg.configFile."kdeglobals".text = ''
      [General]
      ColorScheme=Stylix

      [KDE]
      widgetStyle=Breeze

      [Colors:View]
      BackgroundNormal=${hexToRgb c.base00}
      ForegroundNormal=${hexToRgb c.base05}

      [Colors:Window]
      BackgroundNormal=${hexToRgb c.base01}
      ForegroundNormal=${hexToRgb c.base05}

      [Colors:Button]
      BackgroundNormal=${hexToRgb c.base02}
      ForegroundNormal=${hexToRgb c.base05}

      [Colors:Selection]
      BackgroundNormal=${hexToRgb c.base0D}
      ForegroundNormal=${hexToRgb c.base07}

      [Colors:Tooltip]
      BackgroundNormal=${hexToRgb c.base01}
      ForegroundNormal=${hexToRgb c.base05}

      [Colors:Complementary]
      BackgroundNormal=${hexToRgb c.base00}
      ForegroundNormal=${hexToRgb c.base05}
    '';
  };
}
