{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    lsof
    zip
    unzip
    docker-compose
    trash-cli
    shfmt
    nixfmt
    multimarkdown
    jq
    python3
    ps_mem
    btop
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  virtualisation.virtualbox.host.enable = true;

  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      libGL
      glib
    ];
  };

  security.pam.loginLimits = [
    {
      domain = user;
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
  ];

  zramSwap.enable = true;

  console = {
    earlySetup = true;
    font = "ter-v32n";
    packages = [ pkgs.terminus_font ];
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    upower.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
  };
}
