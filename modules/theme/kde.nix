{ config, ... }:
let
  c = config.lib.stylix.colors;
  hexToRgb =
    hex:
    let
      r = builtins.substring 0 2 hex;
      g = builtins.substring 2 2 hex;
      b = builtins.substring 4 2 hex;
      toInt = s: builtins.fromTOML "v = 0x${s}";
    in
    "${toString (toInt r).v},${toString (toInt g).v},${toString (toInt b).v}";
in
{
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
}
