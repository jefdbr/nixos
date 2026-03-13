{...}: {
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
        {type = "os"; key = "OS";}
        {type = "kernel"; key = "Kernel";}
        {type = "uptime"; key = "Uptime";}
        {type = "shell"; key = "Shell";}
        {type = "terminal"; key = "Terminal";}
        {type = "wm"; key = "WM";}
        {type = "display"; key = "Resolution"; compactType = "original";}
        "separator"
        {type = "cpu"; key = "CPU"; showPeCoreCount = true;}
        {type = "gpu"; key = "GPU";}
        {type = "memory"; key = "Memory";}
        {type = "disk"; folders = "/"; key = "NixOS";}
        {type = "disk"; folders = "/home"; key = "Home";}
        "separator"
        {type = "packages"; key = "Packages"; format = "{all}";}
        "colors"
      ];
    };
  };
}
