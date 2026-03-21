{ ... }:
{
  home-manager.users.jeffrey.programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "auto";
        padding.right = 2;
      };
      display = {
        separator = " → ";
        color = {
          keys = "blue";
          title = "cyan";
        };
      };
      modules = [
        "title"
        "separator"
        {
          type = "os";
          key = "OS";
        }
        {
          type = "kernel";
          key = "Kernel";
        }
        {
          type = "uptime";
          key = "Uptime";
        }
        "separator"
        {
          type = "shell";
          key = "Shell";
        }
        {
          type = "terminal";
          key = "Terminal";
        }
        {
          type = "wm";
          key = "WM";
        }
        {
          type = "custom";
          key = "Desktop Shell";
          format = "Noctalia";
        }
        {
          type = "display";
          key = "Resolution";
          compactType = "original";
        }
        {
          type = "theme";
          key = "Theme";
        }
        {
          type = "cursor";
          key = "Cursor";
        }
        "separator"
        {
          type = "cpu";
          key = "CPU";
          showPeCoreCount = true;
        }
        {
          type = "gpu";
          key = "GPU";
        }
        {
          type = "memory";
          key = "Memory";
        }
        {
          type = "disk";
          folders = "/";
          key = "NixOS";
        }
        {
          type = "packages";
          key = "Packages";
          format = "{all}";
        }
      ];
    };
  };
}
