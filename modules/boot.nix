{ ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "0";
      };
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };

    initrd.systemd.network.wait-online.enable = false;
  };
}
