{ pkgs, ... }:
{
  stylix = {
    enable = true;
    # image = /home/jeffrey/Pictures/Wallpapers/wallhaven-xe762v.jpg;
    # polarity = "dark";

    base16Scheme = {
      base00 = "1e1e1e"; # background
      base01 = "2b2b2b"; # alt background
      base02 = "4a4a4a"; # selection
      base03 = "5e5e5e"; # comments
      base04 = "b0b0b0"; # alt foreground
      base05 = "e0e0e0"; # default text
      base06 = "f0f0f0"; # light foreground
      base07 = "ffffff"; # lightest
      base08 = "ed333b"; # red / error (Adwaita bright red)
      base09 = "e5a50a"; # orange / warning
      base0A = "f6d32d"; # yellow
      base0B = "26a269"; # green
      base0C = "2ec4b6"; # cyan
      base0D = "3584e4"; # blue / primary
      base0E = "9141ac"; # purple / tertiary (Adwaita deep purple)
      base0F = "1b467c"; # dark accent / secondary
    };

    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      dark = "Adwaita";
      light = "Adwaita";
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
}
